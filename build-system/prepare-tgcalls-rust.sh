#!/usr/bin/env bash
set -euo pipefail
root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
engine="$(cd -- "${1:?usage: prepare-tgcalls-rust.sh ENGINE_CHECKOUT}" && pwd)"
revision="$(cat "$root/build-system/tgcalls-rust-revision")"
if [[ "$(git -C "$engine" rev-parse HEAD)" != "$revision" ]]; then
    echo "Expected tgcalls-rs revision $revision" >&2
    exit 1
fi
if [[ -n "$(git -C "$engine" status --porcelain --untracked-files=no)" ]]; then
    echo 'The pinned engine checkout has tracked modifications' >&2
    exit 1
fi
(
    cd "$engine"
    rustup target add wasm32-wasip1
    bash scripts/build-wasm.sh
    bash scripts/build-apple.sh --device-only
)
source="$engine/artifacts/apple"
prepared="$root/submodules/TgCallsRust/Prepared"
mkdir -p "$prepared"/{device,headers}
cp "$source/device/libtgcalls_ffi.a" "$prepared/device/"
cp "$source/headers/"*.h "$prepared/headers/"
cp "$source/TgCallsRust.xcframework/Resources/tgcalls-worker.wasm" "$prepared/"
cp "$engine/sdk/apple/Sources/TgCallsRust/Worker.swift" "$prepared/"
