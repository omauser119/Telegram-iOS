// Generated from docs/wallet/methods.tl. Response buffers remain unparsed here.
// These requests must be followed by the appropriate response decoder.
public enum WalletMTProto {
    public enum Replacement {
        case new
        case imported(publicKey: Buffer, proof: OwnershipProof)
        fileprivate func serialize(_ buffer: Buffer) {
            switch self {
            case .new: buffer.appendInt32(Int32(bitPattern: 0x63a440dc))
            case let .imported(publicKey, proof):
                buffer.appendInt32(Int32(bitPattern: 0x2959057c))
                serializeBytes(publicKey, buffer: buffer, boxed: false)
                proof.serialize(buffer)
            }
        }
    }
    public struct OwnershipProof {
        public let timestamp: Int32
        public let signature: Buffer
        public init(timestamp: Int32, signature: Buffer) {
            self.timestamp = timestamp
            self.signature = signature
        }
        fileprivate func serialize(_ buffer: Buffer) {
            buffer.appendInt32(Int32(bitPattern: 0x60bccb0d))
            buffer.appendInt32(timestamp)
            serializeBytes(signature, buffer: buffer, boxed: false)
        }
    }
    public typealias Request = (FunctionDescription, Buffer, DeserializeFunctionResponse<Buffer>)
    private static func request(_ name: String, _ buffer: Buffer) -> Request {
        // Never include passwords, proof signatures or encrypted secrets in log metadata.
        return (FunctionDescription(name: name, parameters: []), buffer, DeserializeFunctionResponse { $0 })
    }
    public static func disableBackup(flags: Int32 = 0, password: Api.InputCheckPasswordSRP?, newPublicKey: Buffer?, proof: OwnershipProof?) -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0x0b0bf0da))
        var resolvedFlags = flags & ~Int32(7)
        if password != nil { resolvedFlags |= 1 }
        if newPublicKey != nil { resolvedFlags |= 2 }
        if proof != nil { resolvedFlags |= 4 }
        buffer.appendInt32(resolvedFlags)
        if let password {
            password.serialize(buffer, true)
        }
        if let newPublicKey {
            serializeBytes(newPublicKey, buffer: buffer, boxed: false)
        }
        if let proof {
            proof.serialize(buffer)
        }
        return request("wallet.disableBackup", buffer)
    }
    public static func enableBackup(flags: Int32 = 0, parts: [Buffer], password: Api.InputCheckPasswordSRP?) -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0x81a2b0f3))
        var resolvedFlags = flags & ~Int32(1)
        if password != nil { resolvedFlags |= 1 }
        buffer.appendInt32(resolvedFlags)
        buffer.appendInt32(Int32(bitPattern: 0x1cb5c415))
        buffer.appendInt32(Int32(parts.count))
        for item in parts {
            serializeBytes(item, buffer: buffer, boxed: false)
        }
        if let password {
            password.serialize(buffer, true)
        }
        return request("wallet.enableBackup", buffer)
    }
    public static func exportSecretPhrase(flags: Int32 = 0, password: Api.InputCheckPasswordSRP?) -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0x9077c9ac))
        var resolvedFlags = flags & ~Int32(1)
        if password != nil { resolvedFlags |= 1 }
        buffer.appendInt32(resolvedFlags)
        if let password {
            password.serialize(buffer, true)
        }
        return request("wallet.exportSecretPhrase", buffer)
    }
    public static func fetchEncryptedSecretPhrasePart(token: String, publicKey: Buffer) -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0xf53925cf))
        serializeString(token, buffer: buffer, boxed: false)
        serializeBytes(publicKey, buffer: buffer, boxed: false)
        return request("wallet.fetchEncryptedSecretPhrasePart", buffer)
    }
    public static func getBackupHolderDcs() -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0xd179d494))
        return request("wallet.getBackupHolderDcs", buffer)
    }
    public static func getExistingWaltBalance() -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0x628746e3))
        return request("wallet.getExistingWaltBalance", buffer)
    }
    public static func getGaslessInfo() -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0x742df0a1))
        return request("wallet.getGaslessInfo", buffer)
    }
    public static func getProofChallenge() -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0x2025e697))
        return request("wallet.getProofChallenge", buffer)
    }
    public static func getTransactions(flags: Int32 = 0, offset: String, limit: Int32) -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0xa8830a83))
        buffer.appendInt32(flags)
        serializeString(offset, buffer: buffer, boxed: false)
        buffer.appendInt32(limit)
        return request("wallet.getTransactions", buffer)
    }
    public static func getTransactionsByIDs(id: [String]) -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0x811ceab6))
        buffer.appendInt32(Int32(bitPattern: 0x1cb5c415))
        buffer.appendInt32(Int32(id.count))
        for item in id {
            serializeString(item, buffer: buffer, boxed: false)
        }
        return request("wallet.getTransactionsByIDs", buffer)
    }
    public static func getTransactionsByMsgHash(msgHash: [String]) -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0xa6bb795d))
        buffer.appendInt32(Int32(bitPattern: 0x1cb5c415))
        buffer.appendInt32(Int32(msgHash.count))
        for item in msgHash {
            serializeString(item, buffer: buffer, boxed: false)
        }
        return request("wallet.getTransactionsByMsgHash", buffer)
    }
    public static func getUserAddresses(flags: Int32 = 0, id: [Api.InputUser], addresses: [String]) -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0x5275dfdd))
        buffer.appendInt32(flags)
        buffer.appendInt32(Int32(bitPattern: 0x1cb5c415))
        buffer.appendInt32(Int32(id.count))
        for item in id {
            item.serialize(buffer, true)
        }
        buffer.appendInt32(Int32(bitPattern: 0x1cb5c415))
        buffer.appendInt32(Int32(addresses.count))
        for item in addresses {
            serializeString(item, buffer: buffer, boxed: false)
        }
        return request("wallet.getUserAddresses", buffer)
    }
    public static func replaceWallet(flags: Int32 = 0, wallet: Replacement, password: Api.InputCheckPasswordSRP?) -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0xd8c72eec))
        var resolvedFlags = flags & ~Int32(1)
        if password != nil { resolvedFlags |= 1 }
        buffer.appendInt32(resolvedFlags)
        wallet.serialize(buffer)
        if let password {
            password.serialize(buffer, true)
        }
        return request("wallet.replaceWallet", buffer)
    }
    public static func sendTransfer(flags: Int32 = 0, dataNormal: Buffer, dataGasless: Buffer?, randomId: Int64) -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0xd37d8fdb))
        var resolvedFlags = flags & ~Int32(1)
        if dataGasless != nil { resolvedFlags |= 1 }
        buffer.appendInt32(resolvedFlags)
        serializeBytes(dataNormal, buffer: buffer, boxed: false)
        if let dataGasless {
            serializeBytes(dataGasless, buffer: buffer, boxed: false)
        }
        buffer.appendInt64(randomId)
        return request("wallet.sendTransfer", buffer)
    }
    public static func tonConnectClaimRequest(flags: Int32 = 0, sessionId: Int64, msgId: Int64, appRequestId: Int64, challengeAnswer: Buffer?) -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0xd5a9848b))
        var resolvedFlags = flags & ~Int32(1)
        if challengeAnswer != nil { resolvedFlags |= 1 }
        buffer.appendInt32(resolvedFlags)
        buffer.appendInt64(sessionId)
        buffer.appendInt64(msgId)
        buffer.appendInt64(appRequestId)
        if let challengeAnswer {
            serializeBytes(challengeAnswer, buffer: buffer, boxed: false)
        }
        return request("wallet.tonConnectClaimRequest", buffer)
    }
    public static func tonConnectCloseSession(sessionId: Int64, body: Buffer) -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0x99c1ca3b))
        buffer.appendInt64(sessionId)
        serializeBytes(body, buffer: buffer, boxed: false)
        return request("wallet.tonConnectCloseSession", buffer)
    }
    public static func tonConnectCreateSession(dappClientId: String, manifestUrl: String) -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0xcc931046))
        serializeString(dappClientId, buffer: buffer, boxed: false)
        serializeString(manifestUrl, buffer: buffer, boxed: false)
        return request("wallet.tonConnectCreateSession", buffer)
    }
    public static func tonConnectGetPending(flags: Int32 = 0, dappClientId: String?, sessionId: Int64?) -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0x11aee065))
        var resolvedFlags = flags & ~Int32(3)
        if dappClientId != nil { resolvedFlags |= 1 }
        if sessionId != nil { resolvedFlags |= 2 }
        buffer.appendInt32(resolvedFlags)
        if let dappClientId {
            serializeString(dappClientId, buffer: buffer, boxed: false)
        }
        if let sessionId {
            buffer.appendInt64(sessionId)
        }
        return request("wallet.tonConnectGetPending", buffer)
    }
    public static func tonConnectGetSessions() -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0xa7ffb56e))
        return request("wallet.tonConnectGetSessions", buffer)
    }
    public static func tonConnectNextEventId(sessionId: Int64) -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0x775d7244))
        buffer.appendInt64(sessionId)
        return request("wallet.tonConnectNextEventId", buffer)
    }
    public static func tonConnectRegisterKey(sessionId: Int64, clientId: String) -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0x338bcf1c))
        buffer.appendInt64(sessionId)
        serializeString(clientId, buffer: buffer, boxed: false)
        return request("wallet.tonConnectRegisterKey", buffer)
    }
    public static func tonConnectSubmitConnectResult(flags: Int32 = 0, sessionId: Int64, challengeAnswer: Buffer, body: Buffer, traceId: String?) -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0xc2c00779))
        var resolvedFlags = flags & ~Int32(2)
        if traceId != nil { resolvedFlags |= 2 }
        buffer.appendInt32(resolvedFlags)
        buffer.appendInt64(sessionId)
        serializeBytes(challengeAnswer, buffer: buffer, boxed: false)
        serializeBytes(body, buffer: buffer, boxed: false)
        if let traceId {
            serializeString(traceId, buffer: buffer, boxed: false)
        }
        return request("wallet.tonConnectSubmitConnectResult", buffer)
    }
    public static func tonConnectSubmitResponse(flags: Int32 = 0, sessionId: Int64, msgId: Int64, body: Buffer, traceId: String?) -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0x4528f33d))
        var resolvedFlags = flags & ~Int32(1)
        if traceId != nil { resolvedFlags |= 1 }
        buffer.appendInt32(resolvedFlags)
        buffer.appendInt64(sessionId)
        buffer.appendInt64(msgId)
        serializeBytes(body, buffer: buffer, boxed: false)
        if let traceId {
            serializeString(traceId, buffer: buffer, boxed: false)
        }
        return request("wallet.tonConnectSubmitResponse", buffer)
    }
    public static func performApiRequest(flags: Int32 = 0, endpoint: String, query: String?, payload: String?) -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0x8d7bdd61))
        var resolvedFlags = flags & ~Int32(6)
        if query != nil { resolvedFlags |= 2 }
        if payload != nil { resolvedFlags |= 4 }
        buffer.appendInt32(resolvedFlags)
        serializeString(endpoint, buffer: buffer, boxed: false)
        if let query {
            serializeString(query, buffer: buffer, boxed: false)
        }
        if let payload {
            serializeString(payload, buffer: buffer, boxed: false)
        }
        return request("toncenter.performApiRequest", buffer)
    }
    public static func getStreamingUrl() -> Request {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0xcdaf63c7))
        return request("toncenter.getStreamingUrl", buffer)
    }
}
