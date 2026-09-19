// Request signatures verified against serializer instructions and TL CRC32.
// Unknown true-only flag semantics are deliberately not named.
---functions---
wallet.disableBackup#0b0bf0da flags:# password:flags.0?InputCheckPasswordSRP new_public_key:flags.1?bytes proof:flags.2?WalletOwnershipProof = WalletState;
wallet.enableBackup#81a2b0f3 flags:# parts:Vector<bytes> password:flags.0?InputCheckPasswordSRP = WalletState;
wallet.exportSecretPhrase#9077c9ac flags:# password:flags.0?InputCheckPasswordSRP = wallet.SecretPhraseParts;
wallet.fetchEncryptedSecretPhrasePart#f53925cf token:string public_key:bytes = wallet.EncryptedSecretPhrasePart;
wallet.getBackupHolderDcs#d179d494 = Vector<wallet.HolderDc>;
wallet.getExistingWaltBalance#628746e3 = Bool;
wallet.getGaslessInfo#742df0a1 = Updates;
wallet.getProofChallenge#2025e697 = wallet.ProofChallenge;
wallet.getTransactions#a8830a83 flags:# offset:string limit:int = wallet.Transactions;
wallet.getTransactionsByIDs#811ceab6 id:Vector<string> = wallet.Transactions;
wallet.getTransactionsByMsgHash#a6bb795d msg_hash:Vector<string> = wallet.Transactions;
wallet.getUserAddresses#5275dfdd flags:# id:Vector<InputUser> addresses:Vector<string> = wallet.UserAddresses;
wallet.replaceWallet#d8c72eec flags:# wallet:InputWalletReplacement password:flags.0?InputCheckPasswordSRP = WalletState;
wallet.sendTransfer#d37d8fdb flags:# data_normal:bytes data_gasless:flags.0?bytes random_id:long = Updates;
wallet.tonConnectClaimRequest#d5a9848b flags:# session_id:long msg_id:long app_request_id:long challenge_answer:flags.0?bytes = Bool;
wallet.tonConnectCloseSession#99c1ca3b session_id:long body:bytes = Bool;
wallet.tonConnectCreateSession#cc931046 dapp_client_id:string manifest_url:string = TonConnectSession;
wallet.tonConnectGetPending#11aee065 flags:# dapp_client_id:flags.0?string session_id:flags.1?long = wallet.TonConnectPending;
wallet.tonConnectGetSessions#a7ffb56e = wallet.TonConnectSessions;
wallet.tonConnectNextEventId#775d7244 session_id:long = TonConnectNextEventId;
wallet.tonConnectRegisterKey#338bcf1c session_id:long client_id:string = wallet.TonConnectChallenge;
wallet.tonConnectSubmitConnectResult#c2c00779 flags:# session_id:long challenge_answer:bytes body:bytes trace_id:flags.1?string = Bool;
wallet.tonConnectSubmitResponse#4528f33d flags:# session_id:long msg_id:long body:bytes trace_id:flags.0?string = Bool;
toncenter.performApiRequest#8d7bdd61 flags:# endpoint:string query:flags.1?string payload:flags.2?string = toncenter.ApiResponse;
toncenter.getStreamingUrl#cdaf63c7 = toncenter.StreamingUrl;
