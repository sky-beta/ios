#!/bin/bash
set -euo pipefail

echo "Starting resign process"
ROOT_DIR="$(pwd)"
WORKDIR="$(mktemp -d)"
cleanup() { rm -rf "$WORKDIR"; }
trap cleanup EXIT

CERT_ZIP_URL="${CERT_ZIP_URL:-}"
CERT_PASSWORD="${CERT_PASSWORD:-}"

if [ -z "$CERT_ZIP_URL" ] || [ -z "$CERT_PASSWORD" ]; then
  echo "CERT_ZIP_URL or CERT_PASSWORD not set"; exit 1
fi

IPA="$ROOT_DIR/quan.ipa"
if [ ! -f "$IPA" ]; then echo "quan.ipa not found at $IPA"; exit 1; fi

mkdir -p "$WORKDIR/ipa"
unzip -q "$IPA" -d "$WORKDIR/ipa"

APP_PATH=$(ls "$WORKDIR/ipa/Payload"/*.app 2>/dev/null | head -n1 || true)
if [ -z "$APP_PATH" ]; then echo "App bundle not found inside IPA"; exit 1; fi

PLIST="$APP_PATH/Info.plist"
if [ ! -f "$PLIST" ]; then echo "Info.plist not found in app bundle"; exit 1; fi

BUNDLE_ID=$(/usr/libexec/PlistBuddy -c "Print :CFBundleIdentifier" "$PLIST")
BUNDLE_VER=$(/usr/libexec/PlistBuddy -c "Print :CFBundleVersion" "$PLIST" 2>/dev/null || true)

echo "Bundle ID: $BUNDLE_ID"
[ -n "$BUNDLE_VER" ] && echo "Bundle Version: $BUNDLE_VER"

# Download and extract certificate zip
curl -fsSL "$CERT_ZIP_URL" -o "$WORKDIR/certs.zip"
unzip -q "$WORKDIR/certs.zip" -d "$WORKDIR/certs"

P12_FILE=$(find "$WORKDIR/certs" -type f -name "*.p12" -print -quit || true)
MOBILEPROV_FILE=$(find "$WORKDIR/certs" -type f -name "*.mobileprovision" -print -quit || true)

if [ -z "$P12_FILE" ]; then echo "No .p12 file found in certificate bundle"; exit 1; fi

echo "Found p12: $P12_FILE"
[ -n "$MOBILEPROV_FILE" ] && echo "Found mobileprovision: $MOBILEPROV_FILE"

# Create temporary keychain
KEYCHAIN_NAME="build.keychain"
security create-keychain -p "$CERT_PASSWORD" "$KEYCHAIN_NAME"
security import "$P12_FILE" -k "$KEYCHAIN_NAME" -P "$CERT_PASSWORD" -A || true
security list-keychains -s "$KEYCHAIN_NAME" $(security list-keychains | sed -E 's/^\s*"([^"]+)"$/\1/' | tr '\n' ' ')
security unlock-keychain -p "$CERT_PASSWORD" "$KEYCHAIN_NAME"
# Allow codesign to access the key
security set-key-partition-list -S apple-tool:,apple: -s -k "$CERT_PASSWORD" "$KEYCHAIN_NAME" || true

# Find a signing identity in the keychain
IDENTITY_SHA=$(security find-identity -v -p codesigning "$KEYCHAIN_NAME" 2>/dev/null | sed -n 's/^[[:space:]]*\([0-9A-F]\{40\}\).*$/\1/p' | head -n1 || true)
if [ -z "$IDENTITY_SHA" ]; then
  echo "No signing identity found in keychain"; exit 1
fi

echo "Using identity SHA: $IDENTITY_SHA"

# Embed provisioning profile if present
if [ -n "$MOBILEPROV_FILE" ]; then
  cp "$MOBILEPROV_FILE" "$APP_PATH/embedded.mobileprovision"
fi

# Codesign the app (deep to sign nested frameworks)
echo "Codesigning $APP_PATH"
codesign --force --sign "$IDENTITY_SHA" --timestamp=none --deep "$APP_PATH"

# Verify codesign (non-fatal)
codesign --verify --verbose=2 "$APP_PATH" || true

# Repackage IPA
SIGNED_IPA="$ROOT_DIR/signed-quan.ipa"
cd "$WORKDIR/ipa"
zip -qr "$SIGNED_IPA" Payload
cd "$ROOT_DIR"

ls -lh "$SIGNED_IPA" || true

echo "Signed IPA produced at: $SIGNED_IPA"

# Cleanup keychain
security delete-keychain "$KEYCHAIN_NAME" || true

echo "Done"
