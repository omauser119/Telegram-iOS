import Foundation

enum WalletResponseError: Error {
    case malformed
    case constructor(Int32)
}

final class WalletResponseReader {
    let reader: BufferReader
    let size: Int
    init(_ buffer: Buffer) { reader = BufferReader(buffer); size = buffer.size }
    var remaining: Int { size - Int(reader.offset) }
    func int() throws -> Int32 {
        guard let value = reader.readInt32() else { throw WalletResponseError.malformed }
        return value
    }
    func long() throws -> Int64 {
        guard let value = reader.readInt64() else { throw WalletResponseError.malformed }
        return value
    }
    func bytes() throws -> Buffer {
        guard let first = reader.readBytesAsInt32(1), first != 255 else { throw WalletResponseError.malformed }
        var length = Int(first)
        var header = 1
        if first == 254 {
            guard let extended = reader.readBytesAsInt32(3), extended >= 254 else { throw WalletResponseError.malformed }
            length = Int(extended); header = 4
        }
        let padding = (4 - ((header + length) % 4)) % 4
        guard length + padding <= remaining, let value = reader.readBuffer(length) else { throw WalletResponseError.malformed }
        for _ in 0..<padding {
            guard reader.readBytesAsInt32(1) == 0 else { throw WalletResponseError.malformed }
        }
        return value
    }
    func string() throws -> String {
        guard let value = String(data: try bytes().makeData(), encoding: .utf8) else { throw WalletResponseError.malformed }
        return value
    }
    func bool() throws -> Bool {
        let signature = try int()
        switch UInt32(bitPattern: signature) {
        case 0x997275b5: return true
        case 0xbc799737: return false
        default: throw WalletResponseError.constructor(signature)
        }
    }
    func vector<T>(_ element: () throws -> T) throws -> [T] {
        guard try int() == Int32(bitPattern: 0x1cb5c415) else { throw WalletResponseError.malformed }
        let count = try int()
        guard count >= 0, Int(count) <= remaining / 4 else { throw WalletResponseError.malformed }
        var result: [T] = []
        for _ in 0..<count { result.append(try element()) }
        return result
    }
    func api<T>(_ type: T.Type, signature: Int32? = nil) throws -> T {
        let constructor = try signature ?? int()
        guard let result = Api.parse(reader, signature: constructor) as? T else { throw WalletResponseError.constructor(constructor) }
        return result
    }
}

public extension WalletMTProto {
    typealias TypedRequest<T> = (FunctionDescription, Buffer, DeserializeFunctionResponse<T>)
    internal static func typed<T>(_ raw: Request, _ decode: @escaping (WalletResponseReader) throws -> T) -> TypedRequest<T> {
        return (raw.0, raw.1, DeserializeFunctionResponse { buffer in
            let reader = WalletResponseReader(buffer)
            guard let result = try? decode(reader), reader.remaining == 0 else { return nil }
            return result
        })
    }

    /// Wallet-specific updates remain explicit; ordinary updates retain their Api types.
    enum Updates {
        case short(update: WalletUpdate, date: Int32)
        case combined(updates: [WalletUpdate], users: [Api.User], chats: [Api.Chat], date: Int32, seqStart: Int32?, seq: Int32)
        case telegram(Api.Updates)
        static func read(_ reader: WalletResponseReader) throws -> Self {
            let signature = try reader.int()
            switch UInt32(bitPattern: signature) {
            case 0x78d4dec1:
                return .short(update: try WalletUpdate.read(reader), date: try reader.int())
            case 0x74ae4240, 0x725b04c3:
                let updates = try reader.vector { try WalletUpdate.read(reader) }
                let users = try reader.vector { try reader.api(Api.User.self) }
                let chats = try reader.vector { try reader.api(Api.Chat.self) }
                let date = try reader.int()
                let seqStart: Int32? = UInt32(bitPattern: signature) == 0x725b04c3 ? try reader.int() : nil
                return .combined(updates: updates, users: users, chats: chats, date: date, seqStart: seqStart, seq: try reader.int())
            default: return .telegram(try reader.api(Api.Updates.self, signature: signature))
            }
        }
    }
}
