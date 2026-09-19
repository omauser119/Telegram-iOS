# Wallet integration — preview branch

This branch is **not a working money-transfer implementation**. It adds an
inspectable UI entry point and build workflow so integration can proceed in the
actual client without presenting fake balances or successful transfers.

## Implemented

- Wallet immediately below My Profile in Settings.
- Money in the attachment menu of non-bot private chats, opening a recipient
  screen. It currently opens a pushed controller rather than an embedded sheet.
- Balance card adapted from the wallet-engine Swift example, with attribution.
- Read-only `wallet.getProofChallenge` connectivity diagnostic through the
  logged-in account's MTProto network. No proof is signed or persisted.
- macOS 26 GitHub Actions build, ephemeral signing, IPA and dSYM artifacts.
  Adapted from https://github.com/zavolo/opengram-ios/blob/master/.github/workflows/build.yml.
  Requires repository secrets `TELEGRAM_API_ID` and `TELEGRAM_API_HASH`.
  Artifacts require appropriate re-signing for installation. No releases publish
  automatically. The workflow retains the upstream app identifier/profile
  configuration; a distinct installable app identity is still to be configured.

## Protocol correction

The earlier locally extracted TL file must not be treated as authoritative.
Swift large-string references point **32 bytes before** their string bytes.
Matching a LEA directly to a string shifted method names and constructor IDs.
For example:

| Method | Corrected serializer ID |
| --- | --- |
| wallet.getUserAddresses | 0x5275dfdd |
| wallet.replaceWallet | 0xd8c72eec |
| wallet.sendTransfer | 0xd37d8fdb |
| wallet.getProofChallenge | 0x2025e697 |
| wallet.tonConnectCreateSession | 0xcc931046 |
| toncenter.performApiRequest | 0x8d7bdd61 |

The previous live requests labelled getUserAddresses actually targeted
replaceWallet. Their WALLET_UNAVAILABLE responses do **not** establish the
getUserAddresses signature, recipient availability, or service access.
Generic decoder errors do not confirm the intended method's identity either.

`method-evidence.json` records file offsets and immediate candidates from the
12.10.283233 macOS binary. Reproduce with:

```sh
python3 tools/wallet/extract_method_ids.py /path/to/Telegram-12.10.283233.app.zip
```

This is evidence for manual disassembly, not a complete schema generator.
Nested constructor constants can appear among candidates. Return types, flag
semantics, and full field order must be verified before adding typed requests.

## Remaining implementation

1. Recover and verify the full request and response schema; regenerate typed
   TelegramApi objects. Compare read-only replies to the new parser.
2. Integrate the wallet-engine Rust library and generated UniFFI wrapper into
   Bazel and CI. Its packaged Apple binaries require iOS 18; this client targets
   iOS 13, so availability and linkage need explicit handling.
3. Account-scoped Keychain storage, create/import/backup, ownership proof and
   wallet registration; wire snapshot balance/history to the dashboard.
4. Typed peer address resolution, exact integer amounts, transaction preview,
   local authentication, signing and send journal. Route signed payloads through
   the verified MTProto transfer API. Only show completion after server success.
5. Native embedded attachment sheet and transaction chat bubble matching video.
6. macOS build and simulator/device verification, including unavailable-wallet,
   retry, cancellation and duplicate-send behavior.

No secret phrase, API credential, session file or access hash is included here.
No transfers or wallet mutations are performed by this preview.

## Sources and local verification

- Telegram-iOS base: 6ad963e5b62d354da79040f388ae2b9132fb17b8.
- wallet-engine reference: 12f0b49a1c0fbd6cd575bcadd9c54e5706b0f42e.
- Video: tglwal.mp4, 20.031 seconds, sampled at 2 fps (40 local frames).
- Checked workflow with actionlint, embedded shell/Python syntax and git diff whitespace.
- No Xcode/Swift SDK is installed on the Linux development host. An iOS build
  and runtime verification have **not** completed.
