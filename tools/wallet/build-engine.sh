#!/bin/bash
set -euo pipefail
repo_root="$(cd "$(dirname "$0")/../.." && pwd)"
engine_root="$repo_root/third-party/wallet-engine"
output_root="$repo_root/third-party/WalletEngineBindings/Generated"
cd "$engine_root"
cargo xtask bindings swift
rustup target add aarch64-apple-ios
IPHONEOS_DEPLOYMENT_TARGET=18.0 cargo build --locked --release --target aarch64-apple-ios
mkdir -p "$output_root"
cp bindings/swift/Sources/WalletEngineFFI/WalletEngineFFI.swift "$output_root/"
cp bindings/swift/Sources/wallet_engineFFI/wallet_engineFFI.h "$output_root/"
cp target/aarch64-apple-ios/release/libwallet_engine.a "$output_root/"
