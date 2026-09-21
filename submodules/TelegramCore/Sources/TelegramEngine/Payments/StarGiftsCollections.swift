import Foundation
import Postbox
import MtProtoKit
import SwiftSignalKit
import TelegramApi

public struct StarGiftCollection: Codable, Equatable {
    public let id: Int32
    public let title: String
    public let icon: TelegramMediaFile?
    public let count: Int32
    public let hash: Int64
    
    public init(id: Int32, title: String, icon: TelegramMediaFile?, count: Int32, hash: Int64) {
        self.id = id
        self.title = title
        self.icon = icon
        self.count = count
        self.hash = hash
    }
    
    public static func ==(lhs: StarGiftCollection, rhs: StarGiftCollection) -> Bool {
        if lhs.id != rhs.id {
            return false
        }
        if lhs.title != rhs.title {
            return false
        }
        if lhs.icon != rhs.icon {
            return false
        }
        if lhs.count != rhs.count {
            return false
        }
        if lhs.hash != rhs.hash {
            return false
        }
        return true
    }
}

extension StarGiftCollection {
    init?(apiStarGiftCollection: Api.StarGiftCollection) {
        switch apiStarGiftCollection {
        case let .starGiftCollection(starGiftCollectionData):
            let _ = starGiftCollectionData.flags
            let collectionId = starGiftCollectionData.collectionId
            let title = starGiftCollectionData.title
            let icon = starGiftCollectionData.icon
            let giftsCount = starGiftCollectionData.giftsCount
            let hash = starGiftCollectionData.hash
            self.id = collectionId
            self.title = title
            self.icon = icon.flatMap { telegramMediaFileFromApiDocument($0, altDocuments: nil) }
            self.count = giftsCount
            self.hash = hash
        }
    }
}

private final class CachedProfileGiftsCollections: Codable {
    enum CodingKeys: String, CodingKey {
        case collections
    }
    
    let collections: [StarGiftCollection]
    
    init(collections: [StarGiftCollection]) {
        self.collections = collections
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.collections = try container.decode([StarGiftCollection].self, forKey: .collections)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.collections, forKey: .collections)
    }
}

private func entryId(peerId: EnginePeer.Id) -> ItemCacheEntryId {
    let cacheKey = ValueBoxKey(length: 8)
    cacheKey.setInt64(0, value: peerId.toInt64())
    return ItemCacheEntryId(collectionId: Namespaces.CachedItemCollection.cachedProfileGiftsCollections, key: cacheKey)
}

private func intListSimpleHash(_ list: [Int64]) -> Int64 {
    var acc: Int64 = 0
    for value in list {
        acc = ((acc * 20261) + Int64(0x80000000) + Int64(value)) % Int64(0x80000000)
    }
    return Int64(Int32(truncatingIfNeeded: acc))
}

private func _internal_getStarGiftCollections(postbox: Postbox, network: Network, peerId: EnginePeer.Id) -> Signal<[StarGiftCollection]?, NoError> {
    return postbox.transaction { transaction -> (Api.InputPeer, [StarGiftCollection]?)? in
        guard let inputPeer = transaction.getPeer(peerId).flatMap(apiInputPeer) else {
            return nil
        }
        let collections = transaction.retrieveItemCacheEntry(id: entryId(peerId: peerId))?.get(CachedProfileGiftsCollections.self)
        return (inputPeer, collections?.collections)
    }
    |> mapToSignal { inputPeerAndCollections -> Signal<[StarGiftCollection]?, NoError> in
        guard let (inputPeer, cachedCollections) = inputPeerAndCollections else {
            return .single(nil)
        }
        
        var hash: Int64 = 0
        if let cachedCollections {
            hash = intListSimpleHash(cachedCollections.map { $0.hash })
        }
        
        return .single(cachedCollections)
        |> then(
            network.request(Api.functions.payments.getStarGiftCollections(peer: inputPeer, hash: hash))
            |> map(Optional.init)
            |> `catch` { _ -> Signal<Api.payments.StarGiftCollections?, NoError> in
                return .single(nil)
            }
            |> mapToSignal { result -> Signal<[StarGiftCollection]?, NoError> in
                guard let result else {
                    return .single(nil)
                }
                return postbox.transaction { transaction -> [StarGiftCollection]? in
                    switch result {
                    case let .starGiftCollections(starGiftCollectionsData):
                        let apiCollections = starGiftCollectionsData.collections
                        let collections = apiCollections.compactMap { StarGiftCollection(apiStarGiftCollection: $0) }
                        return collections
                    case .starGiftCollectionsNotModified:
                        return cachedCollections ?? []
                    }
                }
            }
        )
    }
}

private func _internal_createStarGiftCollection(account: Account, peerId: EnginePeer.Id, title: String, starGifts: [ProfileGiftsContext.State.StarGift]) -> Signal<StarGiftCollection?, NoError> {
    return account.postbox.transaction { transaction -> (Api.InputPeer, [Api.InputSavedStarGift])? in
        guard let inputPeer = transaction.getPeer(peerId).flatMap(apiInputPeer) else {
            return nil
        }
        let inputStarGifts = starGifts.compactMap { $0.reference }.compactMap { $0.apiStarGiftReference(transaction: transaction) }
        return (inputPeer, inputStarGifts)
    }
    |> mapToSignal { inputPeerAndGifts -> Signal<StarGiftCollection?, NoError> in
        guard let (inputPeer, inputStarGifts) = inputPeerAndGifts else {
            return .single(nil)
        }
        
        return account.network.request(Api.functions.payments.createStarGiftCollection(peer: inputPeer, title: title, stargift: inputStarGifts))
        |> map(Optional.init)
        |> `catch` { _ -> Signal<Api.StarGiftCollection?, NoError> in
            return .single(nil)
        }
        |> map { result -> StarGiftCollection? in
            guard let result else {
                return nil
            }
            return StarGiftCollection(apiStarGiftCollection: result)
        }
        |> beforeNext { collection in
            let _ = account.postbox.transaction { transaction in
                if let collection, let entry = CodableEntry(CachedProfileGifts(gifts: starGifts.map { $0.withPinnedToTop(false) }, count: Int32(starGifts.count), notificationsEnabled: nil)) {
                    transaction.putItemCacheEntry(id: giftsEntryId(peerId: peerId, collectionId: collection.id), entry: entry)
                }
            }.start()
        }
    }
}

private func _internal_reorderStarGiftCollections(account: Account, peerId: EnginePeer.Id, order: [Int32]) -> Signal<Bool, NoError> {
    return account.postbox.transaction { transaction -> Api.InputPeer? in
        return transaction.getPeer(peerId).flatMap(apiInputPeer)
    }
    |> mapToSignal { inputPeer -> Signal<Bool, NoError> in
        guard let inputPeer else {
            return .single(false)
        }
        
        return account.network.request(Api.functions.payments.reorderStarGiftCollections(peer: inputPeer, order: order))
        |> map(Optional.init)
        |> `catch` { _ -> Signal<Api.Bool?, NoError> in
            return .single(nil)
        }
        |> map { result -> Bool in
            if let result, case .boolTrue = result {
                return true
            }
            return false
        }
    }
}

private func _internal_updateStarGiftCollection(account: Account, peerId: EnginePeer.Id, collectionId: Int32, giftsContext: ProfileGiftsContext?, allGiftsContext: ProfileGiftsContext?, actions: [ProfileGiftsCollectionsContext.UpdateAction]) -> Signal<StarGiftCollection?, NoError> {
    for action in actions {
        switch action {
        case let .addGifts(gifts):
            let gifts = gifts.map { gift in
                var collectionIds = gift.collectionIds ?? []
                collectionIds.append(collectionId)
                return gift.withCollectionIds(collectionIds)
            }
            giftsContext?.insertStarGifts(gifts: gifts)
        case let .removeGifts(gifts):
            giftsContext?.removeStarGifts(references: gifts)
        case let .reorderGifts(gifts):
            giftsContext?.reorderStarGifts(references: gifts)
        default:
            break
        }
    }
    
    return account.postbox.transaction { transaction -> (Api.InputPeer, (FunctionDescription, Buffer, DeserializeFunctionResponse<Api.StarGiftCollection>))? in
        guard let inputPeer = transaction.getPeer(peerId).flatMap(apiInputPeer) else {
            return nil
        }
        
        var flags: Int32 = 0
        var title: String?
        var deleteStarGift: [Api.InputSavedStarGift] = []
        var addStarGift: [Api.InputSavedStarGift] = []
        var order: [Api.InputSavedStarGift] = []
        
        for action in actions {
            switch action {
            case let .updateTitle(newTitle):
                flags |= (1 << 0)
                title = newTitle
            case let .addGifts(gifts):
                flags |= (1 << 2)
                addStarGift.append(contentsOf: gifts.compactMap { $0.reference }.compactMap { $0.apiStarGiftReference(transaction: transaction) })
            case let .removeGifts(gifts):
                flags |= (1 << 1)
                deleteStarGift.append(contentsOf: gifts.compactMap { $0.apiStarGiftReference(transaction: transaction) })
            case let .reorderGifts(gifts):
                flags |= (1 << 3)
                order = gifts.compactMap { $0.apiStarGiftReference(transaction: transaction) }
            }
        }
        
        let request = Api.functions.payments.updateStarGiftCollection(flags: flags, peer: inputPeer, collectionId: collectionId, title: title, deleteStargift: deleteStarGift, addStargift: addStarGift, order: order)
        
        return (inputPeer, request)
    }
    |> mapToSignal { peerAndRequest -> Signal<StarGiftCollection?, NoError> in
        guard let (_, request) = peerAndRequest else {
            return .single(nil)
        }
        
        return account.network.request(request)
        |> map(Optional.init)
        |> `catch` { _ -> Signal<Api.StarGiftCollection?, NoError> in
            return .single(nil)
        }
        |> map { result -> StarGiftCollection? in
            guard let result else {
                return nil
            }
            return StarGiftCollection(apiStarGiftCollection: result)
        }
    }
}

private func _internal_deleteStarGiftCollection(account: Account, peerId: EnginePeer.Id, collectionId: Int32) -> Signal<Bool, NoError> {
    return account.postbox.transaction { transaction -> Api.InputPeer? in
        return transaction.getPeer(peerId).flatMap(apiInputPeer)
    }
    |> mapToSignal { inputPeer -> Signal<Bool, NoError> in
        guard let inputPeer else {
            return .single(false)
        }
        
        return account.network.request(Api.functions.payments.deleteStarGiftCollection(peer: inputPeer, collectionId: collectionId))
        |> map(Optional.init)
        |> `catch` { _ -> Signal<Api.Bool?, NoError> in
            return .single(nil)
        }
        |> map { result -> Bool in
            if let result, case .boolTrue = result {
                return true
            }
            return false
        }
    }
}

public final class ProfileGiftsCollectionsContext {
    public struct State: Equatable {
        public var collections: [StarGiftCollection]
        public var isLoading: Bool
        public var displaySettings: [Int32: FlashGiftCollectionSettings]
    }
    
    public enum UpdateAction {
        case updateTitle(String)
        case addGifts([ProfileGiftsContext.State.StarGift])
        case removeGifts([StarGiftReference])
        case reorderGifts([StarGiftReference])
    }
    
    private let queue: Queue = .mainQueue()
    private let account: Account
    private let peerId: EnginePeer.Id
    private weak var allGiftsContext: ProfileGiftsContext?
    
    private let disposable = MetaDisposable()
    
    private var displaySettings: [Int32: FlashGiftCollectionSettings] = [:]
    private var displayHash: Int64 = 0
    private let displayDisposable = MetaDisposable()
    private var displayUpdating = false
    private var displayUpdateToken: Int = 0
    private var collections: [StarGiftCollection] = []
    private var giftsContexts: [Int32: ProfileGiftsContext] = [:]
    private var isLoading: Bool = false
    
    private let stateValue = Promise<State>()
    public var state: Signal<State, NoError> {
        return self.stateValue.get()
    }
    
    public init(account: Account, peerId: EnginePeer.Id, allGiftsContext: ProfileGiftsContext?) {
        self.account = account
        self.peerId = peerId
        self.allGiftsContext = allGiftsContext
                
        self.reload()
    }
    
    deinit {
        self.disposable.dispose()
        self.displayDisposable.dispose()
    }
    
    public func giftsContextForCollection(id: Int32) -> ProfileGiftsContext {
        if let current = self.giftsContexts[id] {
            return current
        } else {
            let giftsContext = ProfileGiftsContext(account: self.account, peerId: self.peerId, collectionId: id)
            self.giftsContexts[id] = giftsContext
            return giftsContext
        }
    }
    
    public func reload() {
        guard !self.isLoading else { return }
        
        self.isLoading = true
        self.pushState()
        
        self.disposable.set((_internal_getStarGiftCollections(postbox: self.account.postbox, network: self.account.network, peerId: self.peerId)
        |> deliverOn(self.queue)).start(next: { [weak self] collections in
            guard let self else {
                return
            }
            self.collections = collections ?? []
            self.isLoading = false
            self.pushState()
            self.updateCache()
            if self.account.network.isFlashEnvironment {
                self.displayDisposable.set(self.refreshDisplaySettings().start(error: { _ in }))
            }
        }))
    }
    
    public func createCollection(title: String, starGifts: [ProfileGiftsContext.State.StarGift]) -> Signal<StarGiftCollection?, NoError> {
        return _internal_createStarGiftCollection(account: self.account, peerId: self.peerId, title: title, starGifts: starGifts)
        |> deliverOn(self.queue)
        |> beforeNext { [weak self] collection in
            guard let self else {
                return
            }
            if let collection {
                self.collections.append(collection)
                self.pushState()
                self.updateCache()
            }
        }
    }
    
    public func updateCollection(id: Int32, actions: [UpdateAction]) -> Signal<StarGiftCollection?, NoError> {
        let giftsContext = self.giftsContextForCollection(id: id)
        return _internal_updateStarGiftCollection(account: self.account, peerId: self.peerId, collectionId: id, giftsContext: giftsContext, allGiftsContext: self.allGiftsContext, actions: actions)
        |> deliverOn(self.queue)
        |> afterNext { [weak self] collection in
            guard let self else {
                return
            }
            if let collection {
                if let index = self.collections.firstIndex(where: { $0.id == id }) {
                    self.collections[index] = collection
                    self.pushState()
                    self.updateCache()
                }
            }
        }
    }
    
    public func addGifts(id: Int32, gifts: [ProfileGiftsContext.State.StarGift]) -> Signal<StarGiftCollection?, NoError> {
        return self.updateCollection(id: id, actions: [.addGifts(gifts)])
    }
        
    public func removeGifts(id: Int32, gifts: [StarGiftReference]) -> Signal<StarGiftCollection?, NoError> {
        return self.updateCollection(id: id, actions: [.removeGifts(gifts)])
    }

    public func reorderGifts(id: Int32, gifts: [StarGiftReference]) -> Signal<StarGiftCollection?, NoError> {
        return self.updateCollection(id: id, actions: [.reorderGifts(gifts)])
    }
    
    public func renameCollection(id: Int32, title: String) -> Signal<StarGiftCollection?, NoError> {
        return self.updateCollection(id: id, actions: [.updateTitle(title)])
    }
    
    public func reorderCollections(order: [Int32]) -> Signal<Bool, NoError> {
        let peerId = self.peerId
        return _internal_reorderStarGiftCollections(account: self.account, peerId: peerId, order: order)
        |> deliverOn(self.queue)
        |> afterNext { [weak self] collection in
            guard let self else {
                return
            }
            var collectionMap: [Int32: StarGiftCollection] = [:]
            for collection in self.collections {
                collectionMap[collection.id] = collection
            }
            var collections: [StarGiftCollection] = []
            for id in order {
                if let collection = collectionMap[id] {
                    collections.append(collection)
                }
            }
            self.collections = collections
            self.pushState()
            self.updateCache()
        }
    }
    
    public func deleteCollection(id: Int32) -> Signal<Bool, NoError> {
        return _internal_deleteStarGiftCollection(account: self.account, peerId: self.peerId, collectionId: id)
        |> deliverOn(self.queue)
        |> afterNext { [weak self] _ in
            guard let self else {
                return
            }
            self.giftsContexts.removeValue(forKey: id)
            self.collections.removeAll(where: { $0.id == id })
            self.pushState()
            self.updateCache()
        }
    }
    
    private func updateCache() {
        let peerId = self.peerId
        let collections = self.collections
        let _ = (self.account.postbox.transaction { transaction in
            if let entry = CodableEntry(CachedProfileGiftsCollections(collections: collections)) {
                transaction.putItemCacheEntry(id: entryId(peerId: peerId), entry: entry)
            }
        }).start()
    }
    
    private func pushState() {
        let state = State(
            collections: self.collections,
            isLoading: self.isLoading,
            displaySettings: self.displaySettings
        )
        self.stateValue.set(.single(state))
    }
}

public typealias FlashGiftCollectionSettings = FlashGiftCollections.Settings
public typealias FlashGiftCollectionDisplayItem = FlashGiftCollections.Item

public enum FlashGiftCollectionError: Error {
    case unavailable
    case busy
    case invalidItems
    case invalidResponse
    case rpc(String)
}

public extension StarGiftReference {
    // Public instance identifiers, never StarGift.id / uniqueGift.id.
    func flashDisplayGiftId(peerId: EnginePeer.Id) -> Int64? {
        switch self {
        case let .message(messageId) where peerId.namespace == Namespaces.Peer.CloudUser:
            return Int64(messageId.id)
        case let .peer(ownerId, id) where ownerId == peerId && peerId.namespace == Namespaces.Peer.CloudChannel:
            return id
        default: return nil
        }
    }
}

public extension ProfileGiftsCollectionsContext {
    var supportsDisplaySettings: Bool { self.account.network.isFlashEnvironment }

    private func displayInputPeer() -> Signal<Api.InputPeer, FlashGiftCollectionError> {
        guard self.supportsDisplaySettings else { return .fail(.unavailable) }
        let account = self.account
        let peerId = self.peerId
        return account.postbox.transaction { transaction -> Api.InputPeer? in
            if peerId == account.peerId { return .inputPeerSelf }
            return transaction.getPeer(peerId).flatMap(apiInputPeer)
        }
        |> castError(FlashGiftCollectionError.self)
        |> deliverOnMainQueue
        |> mapToSignal { peer in
            guard let peer else { return .fail(.unavailable) }
            return .single(peer)
        }
    }

    func refreshDisplaySettings() -> Signal<Bool, FlashGiftCollectionError> {
        guard self.supportsDisplaySettings else { return .fail(.unavailable) }
        return self.displayInputPeer()
        |> mapToSignal { [weak self] peer -> Signal<FlashGiftCollections.Result, FlashGiftCollectionError> in
            guard let self else { return .fail(.unavailable) }
            return self.account.network.request(FlashGiftCollections.get(peer: peer, hash: self.displayHash), automaticFloodWait: false)
            |> mapError { .rpc($0.errorDescription ?? "RPC error") }
        }
        |> deliverOnMainQueue
        |> map { [weak self] response in
            guard let self else { return false }
            if case let .settings(settings, hash) = response {
                var result: [Int32: FlashGiftCollectionSettings] = [:]
                for value in settings { result[value.collectionId] = value }
                self.displaySettings = result
                self.displayHash = hash // Opaque Int64; do not recompute from settings.
                self.pushState()
            }
            return true
        }
    }

    // Independent, unfiltered pagination: a visible page is never a complete edit list.
    func loadAllDisplayGifts(collectionId: Int32) -> Signal<[ProfileGiftsContext.State.StarGift], FlashGiftCollectionError> {
        let account = self.account
        let peerId = self.peerId
        return self.displayInputPeer()
        |> mapToSignal { peer in
            func page(_ offset: String, _ seen: Set<String>, _ accumulated: [ProfileGiftsContext.State.StarGift], expectedCount: Int32? = nil) -> Signal<[ProfileGiftsContext.State.StarGift], FlashGiftCollectionError> {
                return account.network.request(Api.functions.payments.getSavedStarGifts(flags: 1 << 6, peer: peer, collectionId: collectionId, offset: offset, limit: 100), automaticFloodWait: false)
                |> mapError { FlashGiftCollectionError.rpc($0.errorDescription ?? "RPC error") }
                |> mapToSignal { response in
                    return account.postbox.transaction { transaction -> ([ProfileGiftsContext.State.StarGift], String?, Bool, Int32) in
                        switch response {
                        case let .savedStarGifts(value):
                            updatePeers(transaction: transaction, accountPeerId: account.peerId, peers: AccumulatedPeers(transaction: transaction, chats: value.chats, users: value.users))
                            let gifts = value.gifts.compactMap { ProfileGiftsContext.State.StarGift(apiSavedStarGift: $0, peerId: peerId, transaction: transaction, flashDisplay: true) }
                            return (gifts, value.nextOffset, gifts.count == value.gifts.count, value.count)
                        }
                    }
                    |> castError(FlashGiftCollectionError.self)
                }
                |> mapToSignal { gifts, nextOffset, valid, count in
                    guard valid, count >= 0, expectedCount == nil || expectedCount == count else { return .fail(.invalidResponse) }
                    let all = accumulated + gifts
                    let ids = all.compactMap { $0.reference?.flashDisplayGiftId(peerId: peerId) }
                    guard ids.count == all.count, Set(ids).count == ids.count else { return .fail(.invalidResponse) }
                    if let nextOffset, !nextOffset.isEmpty {
                        guard nextOffset != offset, !seen.contains(nextOffset) else { return .fail(.invalidResponse) }
                        return page(nextOffset, seen.union([offset]), all, expectedCount: count)
                    }
                    guard all.count == Int(count) else { return .fail(.invalidResponse) }
                    return .single(all)
                }
            }
            return page("", [], [])
        }
        |> deliverOnMainQueue
    }

    func updateDisplaySettings(collectionId: Int32, hidden: Bool? = nil, mainTab: Bool? = nil, filterMask: Int32? = nil, items: [FlashGiftCollectionDisplayItem]? = nil) -> Signal<Bool, FlashGiftCollectionError> {
        guard self.supportsDisplaySettings else { return .fail(.unavailable) }
        if let filterMask, filterMask < 0 || filterMask & ~63 != 0 { return .fail(.invalidItems) }
        if let items {
            guard FlashGiftCollections.areValidItems(items) else { return .fail(.invalidItems) }
        }
        return Signal { subscriber in
            guard !self.displayUpdating else {
                subscriber.putError(.busy)
                return EmptyDisposable
            }
            self.displayUpdating = true
            self.displayUpdateToken += 1
            let updateToken = self.displayUpdateToken
            self.displayDisposable.set(nil)
            let validation: Signal<Bool, FlashGiftCollectionError>
            if let items {
                validation = self.loadAllDisplayGifts(collectionId: collectionId)
                |> mapToSignal { gifts in
                    let ids = Set(gifts.compactMap { $0.reference?.flashDisplayGiftId(peerId: self.peerId) })
                    guard ids == Set(items.map { $0.giftId }) else { return .fail(.invalidItems) }
                    return .single(true)
                }
            } else { validation = .single(true) }
            let disposable = (validation
            |> mapToSignal { _ in self.displayInputPeer() }
            |> mapToSignal { peer in
                self.account.network.request(FlashGiftCollections.update(peer: peer, collectionId: collectionId, hidden: hidden, mainTab: mainTab, filterMask: filterMask, items: items), automaticFloodWait: false)
                |> mapError { FlashGiftCollectionError.rpc($0.errorDescription ?? "RPC error") }
            }
            |> deliverOnMainQueue
            |> mapToSignal { result -> Signal<Bool, FlashGiftCollectionError> in
                guard result.collectionId == collectionId else { return .fail(.invalidResponse) }
                self.displaySettings[collectionId] = result
                self.pushState()
                return self.account.postbox.transaction { transaction -> Bool in
                    if items != nil {
                        transaction.removeItemCacheEntry(id: entryId(peerId: self.peerId))
                        transaction.removeItemCacheEntry(id: giftsEntryId(peerId: self.peerId, collectionId: collectionId))
                    }
                    return true
                }
                |> castError(FlashGiftCollectionError.self)
                |> mapToSignal { _ in self.refreshDisplaySettings() }
            }
            |> deliverOnMainQueue).start(next: { result in
                if items != nil {
                    self.giftsContexts[collectionId]?.reload()
                    self.disposable.set(nil)
                    self.isLoading = false
                    self.reload()
                }
                subscriber.putNext(result)
            }, error: { error in
                self.displayUpdating = false
                subscriber.putError(error)
            }, completed: {
                self.displayUpdating = false
                subscriber.putCompletion()
            })
            return ActionDisposable {
                disposable.dispose()
                Queue.mainQueue().async {
                    if self.displayUpdateToken == updateToken { self.displayUpdating = false }
                }
            }
        }
    }
}

public extension ProfileGiftsContext.Filters {
    init(flashDisplayMask: Int32) {
        self.init(rawValue: FlashGiftCollections.convertFilterMask(flashDisplayMask))
    }
    var flashDisplayMask: Int32 { FlashGiftCollections.convertFilterMask(self.rawValue) }
}
