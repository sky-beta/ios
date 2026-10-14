"""Read the NetEase Sky Android APK version and its embedded config key."""

from __future__ import annotations

import html
import json
import re
import tempfile
import urllib.request
import zipfile
from pathlib import Path, PurePosixPath
from urllib.parse import urlparse


SOURCE_URL = "https://adl.netease.com/d/g/sky/c/gw?type=android"
KEY_PATTERN = re.compile(rb"(?<![0-9A-Fa-f])1743442606-[0-9A-Fa-f]{64}(?![0-9A-Fa-f])")
APK_VERSION_PATTERN = re.compile(
    r"Sky-Gold-(?P<version>\d+(?:\.\d+)+)-(?P<version_code>\d+)-", re.IGNORECASE
)
MAX_APK_SIZE = 8 * 1024 * 1024 * 1024
MAX_DAT_SIZE = 256 * 1024 * 1024


def request(url: str):
    return urllib.request.Request(
        url,
        headers={
            "User-Agent": "Mozilla/5.0 (compatible; SkyStatusUpdater/1.0)",
            "Accept": "text/html,application/vnd.android.package-archive,*/*",
        },
    )


def get_apk_url_and_version(source_url: str) -> tuple[str, str, str]:
    with urllib.request.urlopen(request(source_url), timeout=60) as response:
        page = response.read(4 * 1024 * 1024 + 1)
    if len(page) > 4 * 1024 * 1024:
        raise ValueError("NetEase download page exceeded 4 MiB")
    text = page.decode("utf-8", errors="replace")
    match = re.search(
        r'var\s+android_link\s*=\s*android_type\s*\?\s*"([^"\r\n]+)"', text
    )
    if not match:
        raise ValueError("Could not find the Android APK link on the NetEase page")
    apk_url = html.unescape(match.group(1)).replace(r"\u0026", "&")
    parsed = urlparse(apk_url)
    if parsed.scheme != "https" or not parsed.hostname or not parsed.hostname.endswith(
        ".gdl.netease.com"
    ):
        raise ValueError("NetEase page returned an unexpected APK host")
    version_match = APK_VERSION_PATTERN.search(PurePosixPath(parsed.path).name)
    if not version_match:
        raise ValueError("APK filename does not contain a parseable version and version code")
    return apk_url, version_match["version"], version_match["version_code"]


def asset_dat_sort_key(name: str) -> tuple[int, int, str]:
    filename = PurePosixPath(name).name
    match = re.fullmatch(r"_ntcfgss(\d*)\.dat", filename, re.IGNORECASE)
    if not match:
        return (2, 0, name.casefold())
    suffix = match.group(1)
    if suffix == "3":
        return (0, 0, name.casefold())
    return (1, int(suffix or "0"), name.casefold())


def find_key_in_apk(apk_path: Path) -> tuple[str, str]:
    matches: set[bytes] = set()
    found_in: list[str] = []
    with zipfile.ZipFile(apk_path) as apk:
        dat_entries = sorted(
            (
                item
                for item in apk.infolist()
                if item.filename.casefold().startswith("assets/")
                and item.filename.casefold().endswith(".dat")
            ),
            key=lambda item: asset_dat_sort_key(item.filename),
        )
        if not dat_entries:
            raise ValueError("APK contains no assets/*.dat files")
        for entry in dat_entries:
            if entry.file_size > MAX_DAT_SIZE:
                raise ValueError(f"Asset is larger than 256 MiB: {entry.filename}")
            entry_matches = set(KEY_PATTERN.findall(apk.read(entry)))
            if entry_matches:
                matches.update(entry_matches)
                found_in.append(entry.filename)
    if not matches:
        raise ValueError("No key matching 1743442606- followed by 64 hex digits was found")
    if len(matches) != 1:
        raise ValueError("More than one distinct matching key was found in assets/*.dat")
    return next(iter(matches)).decode("ascii"), ", ".join(found_in)


def download_apk(apk_url: str, output_path: Path) -> None:
    total = 0
    with urllib.request.urlopen(request(apk_url), timeout=120) as response:
        declared_length = response.headers.get("Content-Length")
        if declared_length and int(declared_length) > MAX_APK_SIZE:
            raise ValueError("APK is larger than the 8 GiB safety limit")
        with output_path.open("wb") as output:
            while chunk := response.read(1024 * 1024):
                total += len(chunk)
                if total > MAX_APK_SIZE:
                    raise ValueError("APK exceeded the 8 GiB safety limit while downloading")
                output.write(chunk)
    if total == 0:
        raise ValueError("Downloaded APK is empty")


def main() -> None:
    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument("--source-url", default=SOURCE_URL)
    parser.add_argument("--status-file", type=Path, required=True)
    args = parser.parse_args()

    status = json.loads(args.status_file.read_text(encoding="utf-8"))
    package_data = status.get("com.netease.sky")
    if not isinstance(package_data, dict):
        package_data = {}

    apk_url, version, version_code = get_apk_url_and_version(args.source_url)
    existing_key = package_data.get("key")
    if (
        package_data.get("version") == version
        and str(package_data.get("version_code", "")) == version_code
        and isinstance(package_data.get("apk_url"), str)
        and package_data["apk_url"].startswith("https://")
        and isinstance(existing_key, str)
        and KEY_PATTERN.fullmatch(existing_key.encode("ascii", errors="ignore"))
    ):
        print(f"NetEase Sky is unchanged at version {version} ({version_code}); APK download skipped.")
        return

    with tempfile.TemporaryDirectory(prefix="netease-sky-") as temporary:
        apk_path = Path(temporary) / "netease-sky.apk"
        download_apk(apk_url, apk_path)
        key, asset_name = find_key_in_apk(apk_path)

    status["com.netease.sky"] = {
        "source_url": args.source_url,
        "apk_url": apk_url,
        "version": version,
        "version_code": version_code,
        "key": key,
    }
    args.status_file.write_text(
        json.dumps(status, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    print(f"Updated NetEase Sky status: version {version} ({version_code}); key found in {asset_name}.")


if __name__ == "__main__":
    main()
