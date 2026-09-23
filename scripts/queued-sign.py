import io, json, os, pathlib, plistlib, re, subprocess, time, urllib.parse, urllib.request, zipfile

BASE = 'https://ios-cert-app.pages.dev'
PUBLIC = 'https://pub-6f7ffe944e2948a19530df1f8bd6fc9f.r2.dev/sky/'
JOB = os.environ['JOB_ID']
if not re.fullmatch('[a-f0-9]{64}', JOB):
    raise SystemExit('Invalid job ID')
AUTH = {'Authorization': 'Bearer ' + os.environ['SKY_UPLOAD_TOKEN']}
WORK = pathlib.Path(os.environ.get('RUNNER_TEMP', '/tmp')) / ('sign-' + JOB)
WORK.mkdir(exist_ok=True)

def request(route, data=None, method=None, headers=None, retries=3):
    for attempt in range(retries):
        try:
            req = urllib.request.Request(BASE + route, data=data, method=method, headers={**AUTH, **(headers or {})})
            with urllib.request.urlopen(req, timeout=120) as r:
                return r.read()
        except Exception:
            if attempt + 1 == retries:
                raise
            time.sleep(2 ** attempt)

def api(route, body=None, retries=3):
    raw = request(route, json.dumps(body).encode() if body is not None else None,
                  headers={'Content-Type': 'application/json'}, retries=retries)
    return json.loads(raw)

def download(url, dest):
    subprocess.run(['curl', '--fail', '--location', '--silent', '--show-error', '--retry', '2',
                    '--connect-timeout', '15', '--max-time', '600', '--proto', '=https', '--proto-redir', '=https',
                    '-H', 'Cache-Control: no-cache', url, '-o', str(dest)], check=True)

def metadata(file):
    with zipfile.ZipFile(file) as archive:
        infos = [n for n in archive.namelist() if n.startswith('Payload/') and n.count('/') == 2 and n.endswith('.app/Info.plist')]
        if len(infos) != 1:
            raise ValueError('Expected one main app')
        return plistlib.loads(archive.read(infos[0]))

job = api('/api/signing/internal/job?id=' + JOB)
source = WORK / 'source.ipa'
if job['target'] == 'sky':
    download(PUBLIC + 'sky.ipa', source)
    info = metadata(source)
elif job['target'] == 'app':
    try:
        download('https://sign.drnrt8.cn/sign/sign/IPA/' + urllib.parse.quote('全能签.ipa'), source)
        info = metadata(source)
        print('Source: primary sign.drnrt8.cn')
    except Exception:
        download('https://raw.githubusercontent.com/sky-beta/ios/main/' + urllib.parse.quote('全能签.ipa'), source)
        info = metadata(source)
        print('Source: GitHub fallback')
else:
    raise ValueError('Unknown target')
bundle = 'skyshadan123' if job['target'] == 'app' else info['CFBundleIdentifier']
if not re.fullmatch('[A-Za-z0-9][A-Za-z0-9.-]{0,199}', bundle):
    raise ValueError('Invalid bundle identifier')
cert_zip = request('/api/signing/internal/certificate?id=' + JOB, json.dumps({'bundle': bundle}).encode(), headers={'Content-Type': 'application/json'}, retries=1)
(WORK / 'certificate.zip').write_bytes(cert_zip)
with zipfile.ZipFile(WORK / 'certificate.zip') as archive:
    for name in ['signing.p12', 'signing.mobileprovision']:
        (WORK / name).write_bytes(archive.read(name))
out = WORK / (bundle + '.ipa')
args = ['.tools/zsign', '-f', '-k', str(WORK / 'signing.p12'), '-p', os.environ['CERT_PASSWORD'], '-m', str(WORK / 'signing.mobileprovision'), '-z', '1', '-o', str(out)]
if job['target'] == 'app':
    args += ['-b', bundle]
subprocess.run(args + [str(source)], check=True)
signed = metadata(out)
if signed['CFBundleIdentifier'] != bundle:
    raise ValueError('Signed bundle does not match requested bundle')
version = str(signed['CFBundleVersion'])
title = str(signed.get('CFBundleDisplayName', signed.get('CFBundleName', bundle)))
icon_url = None
with zipfile.ZipFile(out) as archive:
    main = next(n for n in archive.namelist() if n.startswith('Payload/') and n.count('/') == 2 and n.endswith('.app/Info.plist')).rsplit('/', 1)[0] + '/'
    icon_names = list(signed.get('CFBundleIconFiles', []))
    for key in ['CFBundleIcons', 'CFBundleIcons~ipad']:
        icon_names += signed.get(key, {}).get('CFBundlePrimaryIcon', {}).get('CFBundleIconFiles', [])
    candidates = [n for n in archive.namelist() if n.startswith(main) and n.count('/') == 2 and n.lower().endswith('.png') and (any(pathlib.PurePosixPath(n).name.startswith(i.removesuffix('.png')) for i in icon_names) or 'appicon' in n.lower() or pathlib.PurePosixPath(n).name.lower().startswith('icon'))]
    candidates.sort(key=lambda n: archive.getinfo(n).file_size, reverse=True)
    for name in candidates:
        try:
            from PIL import Image
            image = Image.open(io.BytesIO(archive.read(name)))
            image.thumbnail((512, 512))
            buffer = io.BytesIO()
            image.convert('RGBA').save(buffer, format='PNG')
            request('/api/sky-upload/object?' + urllib.parse.urlencode({'name': bundle + '.png', 'scope': ''}), buffer.getvalue(), 'PUT')
            icon_url = PUBLIC + bundle + '.png?job=' + JOB
            break
        except Exception:
            continue
if not icon_url:
    print('Warning: no browser-compatible icon extracted; install page will use a placeholder')
query = urllib.parse.urlencode({'name': bundle + '.ipa', 'scope': ''})
upload_id = None
try:
    if out.stat().st_size < 64 * 1024 * 1024:
        request('/api/sky-upload/object?' + query, out.read_bytes(), 'PUT')
    else:
        upload_id = api('/api/sky-upload/create?' + query, {})['upload_id']
        parts = []
        with out.open('rb') as stream:
            number = 1
            while chunk := stream.read(32 * 1024 * 1024):
                part = json.loads(request('/api/sky-upload/part?' + query + '&' + urllib.parse.urlencode({'upload_id': upload_id, 'part_number': number}), chunk, 'PUT'))
                parts.append({'partNumber': number, 'etag': part['etag']})
                number += 1
        api('/api/sky-upload/complete', {'name': bundle + '.ipa', 'scope': '', 'upload_id': upload_id, 'parts': parts})
        upload_id = None
finally:
    if upload_id:
        try:
            api('/api/sky-upload/abort?' + query + '&' + urllib.parse.urlencode({'upload_id': upload_id}), {})
        except Exception:
            print('Warning: multipart cleanup failed')
assets = [{'kind': 'software-package', 'url': PUBLIC + bundle + '.ipa?job=' + JOB}]
if icon_url:
    assets += [{'kind': kind, 'url': icon_url} for kind in ['display-image', 'full-size-image']]
manifest = {'items': [{'assets': assets, 'metadata': {'bundle-identifier': bundle, 'bundle-version': version, 'kind': 'software', 'title': title}}]}
request('/api/sky-upload/object?' + urllib.parse.urlencode({'name': bundle + '.plist', 'scope': ''}), plistlib.dumps(manifest), 'PUT')
# The large Sky package goes only to R2. Keep a release backup for the small app.
if job['target'] == 'app':
    subprocess.run(['gh', 'release', 'upload', 'signed-latest', str(out), '--clobber'], check=True)
api('/api/signing/internal/complete?id=' + JOB, {'success': True, 'bundle': bundle, 'version': version, 'title': title, 'icon': bool(icon_url)})
print('Published:', bundle, version)
