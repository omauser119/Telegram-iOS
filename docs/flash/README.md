# Flash debug account environment

Open Debug Settings → Accounts → Login to another account → Flash. The ordinary
Add Account flow keeps its existing Production/Test behavior.

Flash is persisted as account environment raw value `2`. It connects exclusively
to DC 2 at `31.76.29.36:2398`, including authorization, restored accounts and the
standalone state manager. Other DCs have no transport; Telegram backup address
discovery is disabled. Persistent auth keys are used (no temporary-key prewarm).

The public RSA key embedded in `FlashNetworkConfiguration.swift` was imported
from `server_rsa.pub`. Its MTProto fingerprint is `48f342bf711f23fd` and its SPKI
SHA-256 is `55e1970fe35d1b3d0ad3c1e63d41d779ae5d986961036620f2253b960fdbf142`.
Flash contexts trust only this key; Production/Test keep their built-in keys.
Account deduplication, login phone matching and push user-ID lists distinguish
Flash accounts from Telegram accounts.

Validation on 2026-09-19: the endpoint returned `resPQ` to an unauthenticated
abridged `req_pq_multi`; its advertised RSA fingerprint matched the embedded key.
This verifies endpoint reachability and key selection, not completed iOS login.
The native app must be compiled in macOS CI and exercised on an iOS device.
