# Wallet integration status

This branch integrates the original i582/wallet-engine Swift example, pinned at
12f0b49a1c0fbd6cd575bcadd9c54e5706b0f42e. Views, models and Apple hosts were copied
into `submodules/WalletEngineUI`, preserving their lifecycle, send journal,
recovery confirmation and cancellation handling. See its MIT license and NOTICE.
Minimum iOS is now 18, as authorized for this fork.

## Implemented in source; device verification pending

- Wallet below My Profile and Money hosted in Telegram's attachment container.
- Original dashboard, recovery, create/import, history, QR and send views.
- Card colors, owner name, QR action and Add Funds/Send order adapted to the
  reference video. Key frames are in `reference/`. Amount presentation and
  recipient prefilling are adapted in the original SendWalletView.
- Rust-backed local wallet creation/import and authenticated Keychain storage.
  Public wallet archives and secret services are scoped to the Telegram account.
- Registration path: getProofChallenge, local TON ownership proof signing,
  replaceWallet(imported), response constructor/public-key verification. This
  assumes Telegram's proof uses standard ton_proof; server acceptance is still
  unverified. A link failure leaves the backed-up local wallet intact and shows
  an error; it is never represented as a successful Telegram registration.
- Recipient address lookup through wallet.getUserAddresses using InputUser and
  checking the returned user ID.
- Wallet Engine Toncenter traffic routed through toncenter.performApiRequest,
  with request/response size limits and cancellation. Endpoint routing and
  server access still require live validation.
- All 25 discovered MTProto requests have generated Swift serializers in
  `TelegramApi/Sources/WalletMTProto.swift`. Signatures match their TL CRC32 and
  the corrected binary serializer IDs. Low-level request responses are raw
  buffers; only responses needed by the integration have decoders so far.
- CI builds pinned Rust bindings and the arm64 library before Bazel, then uploads
  the IPA and dSYM. Build follows the opengram workflow with self-signed signing.

## Still incomplete

- Full typed response/update handling for backup, transactions and TON Connect.
- UI wiring for wallet backup and the MTProto TON Connect lifecycle: copied
  TON Connect screens/coordinator still use the original bridge transport.
- Submitting signed messages specifically through wallet.sendTransfer. The
  copied send journal currently submits Toncenter JSON-RPC through the MTProto
  proxy. The presence of a sendTransfer serializer is not full integration.
- Exact embedded amount-sheet transitions, payment message bubble, confetti,
  fiat prices and funding-provider purchase flows from the reference video.
- Retry UI for account linking, 2FA/SRP handling and unlink behavior.
- Successful iOS compilation and simulator/device verification of this revision.

No account/session/API secrets are committed. No funds were sent during coding.

## Protocol evidence

Earlier extraction used the wrong Swift string address and shifted method IDs.
The previous local wallet.tl must not be used. String references point 32 bytes
before the actual string contents. `method-evidence.json` records corrected
function offsets and constructor immediates. `methods.tl` contains corrected
request fields. In particular getUserAddresses uses Vector<InputUser> and an
unconditional addresses vector; sendTransfer has mandatory data_normal.

Regenerate and verify the request signatures:

```sh
python3 tools/wallet/generate-requests.py
```

Build the native engine on macOS before invoking the normal Telegram build:

```sh
tools/wallet/build-engine.sh
```

Swift bindings were generated successfully on Linux. SwiftUI, Security framework
and final Apple linkage require the macOS CI runner.

## Live read-only checks (2026-09-19)

Using the existing authorized Telethon session and corrected request layouts:

- wallet.getProofChallenge: RPC 400 WALLET_UNAVAILABLE.
- wallet.getUserAddresses (InputUserSelf, empty addresses): RPC 400 WALLET_UNAVAILABLE.
- toncenter.performApiRequest: FILE_MIGRATE_4 on the account DC; after exporting
  authorization to DC 4: RPC 403 ACCESS_DENIED.

The iOS relay follows FILE_MIGRATE through Telegram's authorized worker pool.
These replies do not validate success-response parsing or ownership-proof
acceptance. Server access is currently an external blocker for end-to-end tests
on this account; no wallet mutation or fund transfer was performed.
