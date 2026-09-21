// Flash-only extension. Constructor IDs are fixed by the server contract.
public enum FlashGiftCollections {
    public static func areValidItems(_ items: [Item]) -> Bool {
        return items.count <= Int(Int32.max)
            && Set(items.map { $0.giftId }).count == items.count
            && items.map({ $0.order }).sorted() == (0..<items.count).map(Int32.init)
            && items.allSatisfy { $0.size == 0 || $0.size == 1 }
    }

    // The standard iOS filter swaps limited/upgradable compared with Flash.
    public static func convertFilterMask(_ mask: Int32) -> Int32 {
        return (mask & 57) | ((mask & 2) << 1) | ((mask & 4) >> 1)
    }

    public struct Item: Codable, Equatable {
        public let giftId: Int64
        public let order: Int32
        public let size: Int32
        public init(giftId: Int64, order: Int32, size: Int32) {
            self.giftId = giftId; self.order = order; self.size = size
        }
        func serialize(_ buffer: Buffer) {
            buffer.appendInt32(Int32(bitPattern: 0x60db9565))
            buffer.appendInt64(giftId); buffer.appendInt32(order); buffer.appendInt32(size)
        }
        static func read(_ reader: WalletResponseReader) throws -> Item {
            guard try reader.int() == Int32(bitPattern: 0x60db9565) else { throw WalletResponseError.malformed }
            return Item(giftId: try reader.long(), order: try reader.int(), size: try reader.int())
        }
    }
    public struct Settings: Codable, Equatable {
        public let collectionId: Int32
        public let hidden: Bool
        public let mainTab: Bool
        public let filterMask: Int32
        public let items: [Item]
        public init(collectionId: Int32, hidden: Bool = false, mainTab: Bool = false, filterMask: Int32 = 63, items: [Item] = []) {
            self.collectionId = collectionId; self.hidden = hidden; self.mainTab = mainTab
            self.filterMask = filterMask; self.items = items
        }
        static func read(_ reader: WalletResponseReader) throws -> Settings {
            guard try reader.int() == Int32(bitPattern: 0x41455693) else { throw WalletResponseError.malformed }
            let flags = try reader.int()
            let result = Settings(collectionId: try reader.int(), hidden: flags & 1 != 0, mainTab: flags & 2 != 0,
                filterMask: try reader.int(), items: try reader.vector { try Item.read(reader) })
            guard areValidItems(result.items) else { throw WalletResponseError.malformed }
            return result
        }
    }
    public enum Result {
        case notModified
        case settings([Settings], hash: Int64)
    }
    public typealias Request<T> = (FunctionDescription, Buffer, DeserializeFunctionResponse<T>)
    private static func request<T>(_ name: String, _ buffer: Buffer, read: @escaping (WalletResponseReader) throws -> T) -> Request<T> {
        return (FunctionDescription(name: name, parameters: []), buffer, DeserializeFunctionResponse { buffer in
            let reader = WalletResponseReader(buffer)
            guard let value = try? read(reader), reader.remaining == 0 else { return nil }
            return value
        })
    }
    public static func get(peer: Api.InputPeer, hash: Int64) -> Request<Result> {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0xdf1cfd23))
        peer.serialize(buffer, true); buffer.appendInt64(hash)
        return request("payments.getStarGiftCollectionsDisplaySettings", buffer) { reader in
            switch UInt32(bitPattern: try reader.int()) {
            case 0x543daf4d: return .notModified
            case 0x283973d1:
                return .settings(try reader.vector { try Settings.read(reader) }, hash: try reader.long())
            default: throw WalletResponseError.malformed
            }
        }
    }
    public static func update(peer: Api.InputPeer, collectionId: Int32, hidden: Bool? = nil, mainTab: Bool? = nil, filterMask: Int32? = nil, items: [Item]? = nil) -> Request<Settings> {
        let buffer = Buffer()
        buffer.appendInt32(Int32(bitPattern: 0x8db0c705))
        var flags: Int32 = 0
        if hidden != nil { flags |= 1 }; if mainTab != nil { flags |= 2 }
        if filterMask != nil { flags |= 4 }; if items != nil { flags |= 8 }
        buffer.appendInt32(flags); peer.serialize(buffer, true); buffer.appendInt32(collectionId)
        // Optional Bool fields carry boxed boolFalse as well as boolTrue.
        for value in [hidden, mainTab] {
            if let value { buffer.appendInt32(Int32(bitPattern: value ? 0x997275b5 : 0xbc799737)) }
        }
        if let filterMask { buffer.appendInt32(filterMask) }
        if let items {
            buffer.appendInt32(Int32(bitPattern: 0x1cb5c415)); buffer.appendInt32(Int32(items.count))
            for item in items { item.serialize(buffer) }
        }
        return request("payments.updateStarGiftCollectionDisplaySettings", buffer, read: Settings.read)
    }
}
