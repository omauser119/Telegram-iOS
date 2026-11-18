#!/usr/bin/env bash
set -euo pipefail
input="${1:?input IPA}"
output="${2:?output IPA}"
stage="$(mktemp -d)"
trap 'rm -rf -- "$stage"' EXIT
unzip -q "$input" -d "$stage"
app="$(find "$stage/Payload" -mindepth 1 -maxdepth 1 -type d -name '*.app' -print -quit)"
test -n "$app"
executable="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleExecutable' "$app/Info.plist")"
xcrun lipo -verify_arch arm64 "$app/$executable"
xcrun vtool -show-build "$app/$executable" | grep -Eq 'platform[[:space:]]+IOS[[:space:]]*$'
test -s "$app/tgcalls-worker.wasm"
cmp "$app/tgcalls-worker.wasm" submodules/TgCallsRust/Prepared/tgcalls-worker.wasm
while IFS= read -r -d '' binary; do
    if file -b "$binary" | grep -q 'Mach-O' && codesign --display "$binary" >/dev/null 2>&1; then
        codesign --remove-signature "$binary"
    fi
done < <(find "$app" -type f -perm -111 -print0)
find "$app" -name _CodeSignature -prune -exec rm -rf -- {} +
find "$app" -type f -name embedded.mobileprovision -delete
if codesign --display "$app/$executable" >/dev/null 2>&1; then
    echo 'The iOS executable still has a signature' >&2
    exit 1
fi
ditto -c -k --keepParent "$stage/Payload" "$output"
(cd "$(dirname "$output")" && shasum -a 256 "$(basename "$output")" > "$(basename "$output").sha256")
