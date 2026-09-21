import Foundation

func check(_ value: @autoclosure () -> Bool, _ message: String) {
    if !value() { fatalError(message) }
}
func words(_ bytes: [UInt32]) -> Buffer {
    let b = Buffer()
    for word in bytes { b.appendInt32(Int32(bitPattern: word)) }
    return b
}
@main struct Tests {
    static func main() {
        check(FlashGiftCollections.convertFilterMask(2) == 4, "limited mapping")
        check(FlashGiftCollections.convertFilterMask(4) == 2, "upgradable mapping")
        for mask in 0..<64 {
            check(FlashGiftCollections.convertFilterMask(FlashGiftCollections.convertFilterMask(Int32(mask))) == Int32(mask), "filter round trip")
        }
        check(FlashGiftCollections.areValidItems([]), "empty collection")
        check(!FlashGiftCollections.areValidItems([.init(giftId: 1, order: 0, size: 2)]), "invalid size")
        check(!FlashGiftCollections.areValidItems([.init(giftId: 1, order: 1, size: 0)]), "nonzero initial order")
        check(!FlashGiftCollections.areValidItems([.init(giftId: 1, order: 0, size: 0), .init(giftId: 1, order: 1, size: 0)]), "duplicate id")
        check(!FlashGiftCollections.areValidItems([.init(giftId: 1, order: 0, size: 0), .init(giftId: 2, order: 0, size: 0)]), "duplicate order")
        let peer = Api.InputPeer.inputPeerSelf
        let get = FlashGiftCollections.get(peer: peer, hash: Int64.min + 17)
        let reader = BufferReader(get.1)
        check(reader.readInt32() == Int32(bitPattern: 0xdf1cfd23), "get id")
        check(reader.readInt32() == Int32(bitPattern: 0x7da07ec9), "self peer")
        check(reader.readInt64() == Int64.min + 17, "opaque hash")
        for flags in 0..<16 {
            let hidden: Bool? = flags & 1 == 0 ? nil : false
            let main: Bool? = flags & 2 == 0 ? nil : true
            let mask: Int32? = flags & 4 == 0 ? nil : 48
            let items: [FlashGiftCollections.Item]? = flags & 8 == 0 ? nil : [.init(giftId: 431, order: 0, size: 1), .init(giftId: 512, order: 1, size: 0)]
            let request = FlashGiftCollections.update(peer: peer, collectionId: 7, hidden: hidden, mainTab: main, filterMask: mask, items: items)
            let r = BufferReader(request.1)
            check(r.readInt32() == Int32(bitPattern: 0x8db0c705), "update id")
            check(r.readInt32() == Int32(flags), "presence flags")
            check(r.readInt32() == Int32(bitPattern: 0x7da07ec9), "update peer")
            check(r.readInt32() == 7, "collection id")
            if hidden != nil { check(r.readInt32() == Int32(bitPattern: 0xbc799737), "explicit boolFalse") }
            if main != nil { check(r.readInt32() == Int32(bitPattern: 0x997275b5), "explicit boolTrue") }
            if mask != nil { check(r.readInt32() == 48, "visibility mask") }
            if let items {
                check(r.readInt32() == Int32(bitPattern: 0x1cb5c415), "vector id")
                check(r.readInt32() == 2, "full vector")
                for item in items {
                    check(r.readInt32() == Int32(bitPattern: 0x60db9565), "item id")
                    check(r.readInt64() == item.giftId, "public instance id")
                    check(r.readInt32() == item.order, "order")
                    check(r.readInt32() == item.size, "size")
                }
            }
            check(Int(r.offset) == request.1.size, "exact request length")
        }
        let falseMain = FlashGiftCollections.update(peer: peer, collectionId: 7, mainTab: false)
        check(falseMain.1.makeData().suffix(4) == words([0xbc799737]).makeData(), "remove main tab")
        let empty = FlashGiftCollections.update(peer: peer, collectionId: 7, items: [])
        check(empty.1.size == 24, "explicit empty items vector")
        let settings = words([0x41455693, 3, 7, 63, 0x1cb5c415, 1, 0x60db9565, 431, 0, 0, 1])
        let update = FlashGiftCollections.update(peer: peer, collectionId: 7)
        let parsed = update.2.parse(settings)!
        check(parsed.hidden && parsed.mainTab && parsed.items[0].giftId == 431 && parsed.items[0].size == 1, "flags-only true fields")
        let list = words([0x283973d1, 0x1cb5c415, 1])
        settings.makeData().withUnsafeBytes { list.appendBytes($0.baseAddress!, length: UInt($0.count)) }
        list.appendInt64(Int64.min + 99)
        guard case let .settings(values, hash)? = get.2.parse(list) else { fatalError("list decode") }
        check(values == [parsed] && hash == Int64.min + 99, "settings/hash round trip")
        guard case .notModified? = get.2.parse(words([0x543daf4d])) else { fatalError("not modified") }
        for n in 0..<list.size {
            check(get.2.parse(Buffer(data: list.makeData().prefix(n))) == nil, "truncated response at \(n)")
        }
        list.appendInt32(0)
        check(get.2.parse(list) == nil, "trailing bytes")
        check(get.2.parse(words([0x283973d1, 0x1cb5c415, 0xffffffff])) == nil, "negative vector count")
        check(get.2.parse(words([0x283973d1, 0, 0])) == nil, "invalid vector constructor")
        for flags in [[true, false, false, false, true, true, false], [false, false, false], [true], []] {
            for columns in 1...5 {
                let frames = flashGiftMosaicFrames(expanded: flags, width: 350, columns: columns, spacing: 10, origin: .zero)
                check(frames.count == flags.count, "mosaic count")
                for (i, frame) in frames.enumerated() {
                    check(frame.minX >= 0 && frame.maxX <= 350.001, "mosaic width")
                    for other in frames.dropFirst(i + 1) { check(!frame.intersects(other), "nonoverlapping mosaic") }
                }
            }
        }
        let frames = flashGiftMosaicFrames(expanded: [true, false, false, false, true], width: 350, columns: 3, spacing: 10, origin: .zero)
        check(frames[0].width == frames[0].height && frames[0].width == 230, "leading 2x2 tile")
        check(frames[4].width == 230 && frames[4].height == 110, "wide 2x1 tile")
        print("Flash contract: all flags, Bool false, constructor IDs, hash, truncation and mosaic checks passed")
    }
}
