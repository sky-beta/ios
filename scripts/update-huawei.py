"""Read versions and icons from remote APKs using bounded HTTP Range requests."""

import argparse
import hashlib
import io
import json
import re
import subprocess
import tempfile
import time
import urllib.request
import zipfile
from datetime import datetime, timedelta, timezone
from pathlib import Path
from urllib.parse import urlparse

BEIJING = timezone(timedelta(hours=8))


class RemoteAPK(io.RawIOBase):
    def __init__(self, url):
        self.url = url
        self.position = 0
        self.transferred = 0
        _, size = self.fetch_range(0, 0)
        self.size = size

    def fetch_range(self, start, end):
        for attempt in range(3):
            try:
                request = urllib.request.Request(self.url, headers={
                    "Range": f"bytes={start}-{end}",
                    "Accept-Encoding": "identity",
                    "User-Agent": "Mozilla/5.0 Huawei-APK-Metadata/1.0",
                })
                with urllib.request.urlopen(request, timeout=90) as response:
                    content_range = response.headers.get("Content-Range", "")
                    match = re.fullmatch(r"bytes (\d+)-(\d+)/(\d+)", content_range)
                    if response.status != 206 or not match or (
                        int(match[1]), int(match[2])
                    ) != (start, end):
                        raise ValueError("Server did not honor the requested byte range")
                    payload = response.read(end - start + 2)
                    if len(payload) != end - start + 1:
                        raise ValueError("Incomplete APK byte range")
                    # Reuse the actual CDN endpoint returned by the first GET.
                    self.url = response.geturl()
                    self.transferred += len(payload)
                    return payload, int(match[3])
            except Exception:
                if attempt == 2:
                    raise
                time.sleep(2 * (attempt + 1))

    def seekable(self):
        return True

    def readable(self):
        return True

    def tell(self):
        return self.position

    def seek(self, offset, whence=0):
        position = offset if whence == 0 else (self.position if whence == 1 else self.size) + offset
        if position < 0:
            raise ValueError("Negative APK offset")
        self.position = position
        return position

    def read(self, length=-1):
        length = self.size - self.position if length < 0 else min(length, self.size - self.position)
        if length <= 0:
            return b""
        if length > 32 * 1024 * 1024:
            raise ValueError("APK metadata range exceeds 32 MiB")
        start = self.position
        data, size = self.fetch_range(start, start + length - 1)
        if size != self.size:
            raise ValueError("Remote APK size changed during extraction")
        self.position += len(data)
        return data


def address_time(url, package):
    match = re.fullmatch(re.escape(package) + r"\.(\d{10})\.apk", Path(urlparse(url).path).name)
    if not match:
        raise ValueError("APK address has no YYMMDDHHmm timestamp")
    return datetime.strptime(match[1], "%y%m%d%H%M").replace(
        tzinfo=BEIJING
    ).isoformat()


def extract_app(url, package, key, aapt):
    from PIL import Image

    remote = RemoteAPK(url)
    with zipfile.ZipFile(remote) as archive, tempfile.TemporaryDirectory(prefix="huawei-metadata-") as temporary:
        sparse_apk = Path(temporary) / "metadata.apk"
        with zipfile.ZipFile(sparse_apk, "w") as sparse:
            for name in ("AndroidManifest.xml", "resources.arsc"):
                if archive.getinfo(name).file_size > 64 * 1024 * 1024:
                    raise ValueError("APK manifest or resources are unexpectedly large")
                sparse.writestr(name, archive.read(name))
        result = subprocess.run([aapt, "dump", "badging", str(sparse_apk)],
                                check=True, capture_output=True, text=True)
        package_line = next(line for line in result.stdout.splitlines() if line.startswith("package:"))
        fields = dict(re.findall(r"(\w+)='([^']*)'", package_line))
        if fields.get("name") != package or not fields.get("versionName") or not fields.get("versionCode"):
            raise ValueError("APK package or version metadata is invalid")
        icons = re.findall(r"^application-icon-(\d+):'([^']+)'", result.stdout, re.MULTILINE)
        raster_icons = [(int(density), name) for density, name in icons
                        if name.lower().endswith((".png", ".webp", ".jpg", ".jpeg"))]
        if not raster_icons:
            raise ValueError("APK has no raster application icon in aapt metadata")
        icon_name = max(raster_icons)[1]
        if archive.getinfo(icon_name).file_size > 8 * 1024 * 1024:
            raise ValueError("Application icon exceeds 8 MiB")
        with Image.open(io.BytesIO(archive.read(icon_name))) as image:
            output = io.BytesIO()
            image.convert("RGBA").save(output, format="PNG", optimize=True)
        icon = output.getvalue()
    app = {"package": package, "version": fields["versionName"], "version_code": fields["versionCode"],
           "updated_at": address_time(url, package), "icon": f"{key}-icon.png",
           "icon_sha256": hashlib.sha256(icon).hexdigest()}
    print(f"{key}: version {app['version']} ({app['version_code']}), "
          f"read {remote.transferred} of {remote.size} bytes; icon {icon_name}")
    return app, icon


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--data-file", type=Path, required=True)
    parser.add_argument("--aapt", required=True)
    parser.add_argument("--huawei-url", required=True)
    parser.add_argument("--hms-url", required=True)
    args = parser.parse_args()
    old = json.loads(args.data_file.read_text(encoding="utf-8")) if args.data_file.exists() else {}
    downloads = {"huawei": args.huawei_url, "hms": args.hms_url}
    apps, icons = {}, {}
    for key, package in (("huawei", "com.tgc.sky.android.huawei"), ("hms", "com.huawei.hwid")):
        cached = old.get("apps", {}).get(key, {})
        icon_file = args.data_file.parent / f"{key}-icon.png"
        if old.get("downloads", {}).get(key) == downloads[key] and cached.get("version") and icon_file.is_file():
            apps[key] = cached
        else:
            apps[key], icons[key] = extract_app(downloads[key], package, key, args.aapt)
    count = old.get("update_count", 0)
    if type(count) is not int or count < 0:
        raise ValueError("Invalid Huawei update_count")
    changed = old.get("downloads") != downloads
    data = {"update_count": count + int(changed),
            "last_updated": datetime.now(BEIJING).isoformat(timespec="seconds")
            if changed else old["last_updated"], "downloads": downloads, "apps": apps}
    args.data_file.parent.mkdir(parents=True, exist_ok=True)
    # Fetch and validate both apps before updating any tracked files.
    for key, icon in icons.items():
        (args.data_file.parent / f"{key}-icon.png").write_bytes(icon)
    args.data_file.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()
