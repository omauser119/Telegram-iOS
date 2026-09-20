// Experimental response layouts from the local macOS extraction.
// IDs for State/UserAddress match the existing iOS transport.
// Sessions' outer ID was observed live; nested layouts are not live-validated.
---types---
walletState#95c5346b flags:# address:string public_key:bytes balance:long = WalletState;
walletStateEmpty#9cb9b2ec flags:# = WalletState;
walletUserAddress#a1b895e5 user_id:long address:string public_key:bytes = WalletUserAddress;
walletTransactionPeerAddress#e16b5ce1 flags:# address:string domain:flags.0?string = WalletTransactionPeer;
walletTransactionPeerUser#f8e0aa1c flags:# user_id:long address:string domain:flags.0?string = WalletTransactionPeer;
walletTransactionPeerUnsupported#957b50fb = WalletTransactionPeer;
walletTransaction#1e109708 flags:# id:string amount:long fee:long date:int peer:flags.0?WalletTransactionPeer comment:flags.1?string tx_hash:flags.2?string = WalletTransaction;
tonConnectManifest#d0f263bc url:string name:string icon_url:string = TonConnectManifest;
tonConnectNextEventId#582464e3 event_id:long = TonConnectNextEventId;
tonConnectRequest#a281cb31 flags:# session_id:long msg_id:long body:bytes expires:int topic:flags.0?string trace_id:flags.1?string = TonConnectRequest;
tonConnectSession#126556c6 flags:# id:long dapp_client_id:string client_id:flags.3?string nonce:bytes manifest:flags.4?TonConnectManifest manifest_error:flags.5?int date:int = TonConnectSession;
wallet.encryptedSecretPhrasePart#18e82537 data:bytes = wallet.EncryptedSecretPhrasePart;
wallet.holderDc#f9d612ef dc:int public_key:bytes = wallet.HolderDc;
wallet.proofChallenge#99e41707 payload:string expires:int domain:string = wallet.ProofChallenge;
wallet.secretPhraseParts#e6d0ef01 token:string dcs:Vector<int> = wallet.SecretPhraseParts;
wallet.tonConnectChallenge#4bc89693 challenge:bytes event_id:long = wallet.TonConnectChallenge;
wallet.tonConnectPending#85c0f124 session:TonConnectSession requests:Vector<TonConnectRequest> = wallet.TonConnectPending;
wallet.tonConnectSessions#0e1f6896 sessions:Vector<TonConnectSession> = wallet.TonConnectSessions;
wallet.transactions#4322d5a5 flags:# balance:long transactions:Vector<WalletTransaction> next_offset:flags.0?string chats:Vector<Chat> users:Vector<User> = wallet.Transactions;
wallet.userAddresses#928e7b55 addresses:Vector<WalletUserAddress> users:Vector<User> = wallet.UserAddresses;
toncenter.apiResponse#ac8dfe19 response:DataJSON = toncenter.ApiResponse;
toncenter.streamingUrl#19887601 url:string expires:int = toncenter.StreamingUrl;
updateSentWalletTransaction#686c85a6 transaction:WalletTransaction = WalletUpdate;
updateWalletGaslessInfo#aeaf9e74 reset_at:int min_amount:long relayer_address:string = WalletUpdate;
updateWalletState#9375341e state:WalletState = WalletUpdate;
updateWalletTonConnectPendingDisconnect#39c67432 session_ids:Vector<long> = WalletUpdate;
updateWalletTonConnectSession#74d8be99 session:TonConnectSession = WalletUpdate;
