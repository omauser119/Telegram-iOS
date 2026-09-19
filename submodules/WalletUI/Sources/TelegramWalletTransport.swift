import Foundation
import AccountContext
import TelegramCore
import Postbox
import TelegramApi
import SwiftSignalKit
import WalletEngineUI

private enum WalletTransportError: LocalizedError {
    case rpc(Int, String)
    case invalidResponse
    var errorDescription: String? {
        switch self {
        case let .rpc(code, message): return "RPC \(code): \(message)"
        case .invalidResponse: return "Unexpected wallet response"
        }
    }
}

/// Owns cancellation and continuation completion even when an RPC completes
/// synchronously or cancellation races with the network callback.
private final class WalletRPCOperation: @unchecked Sendable {
    private let lock = NSLock()
    private let disposable = MetaDisposable()
    private var continuation: CheckedContinuation<Data, Error>?
    private var result: Result<Data, Error>?

    func install(_ continuation: CheckedContinuation<Data, Error>) {
        lock.lock()
        if let result = self.result {
            lock.unlock()
            continuation.resume(with: result)
        } else {
            self.continuation = continuation
            lock.unlock()
        }
    }
    func setDisposable(_ value: Disposable) { disposable.set(value) }
    func finish(_ result: Result<Data, Error>) {
        lock.lock()
        guard self.result == nil else { lock.unlock(); return }
        self.result = result
        let continuation = self.continuation
        self.continuation = nil
        lock.unlock()
        disposable.dispose()
        continuation?.resume(with: result)
    }
}

final class TelegramWalletTransport: WalletProviderTransport, @unchecked Sendable {
    private let context: AccountContext
    private let recipient: TelegramUser?
    init(context: AccountContext, recipient: TelegramUser? = nil) {
        self.context = context
        self.recipient = recipient
    }

    func recipientAddress() async throws -> String {
        guard let recipient, let hash = recipient.accessHash else { throw WalletTransportError.invalidResponse }
        let user = Api.InputUser.inputUser(.init(userId: recipient.id.id._internalGetInt64Value(), accessHash: hash.value))
        let data = try await execute(WalletMTProto.getUserAddresses(id: [user], addresses: []))
        let reader = BufferReader(Buffer(data: data))
        guard reader.readInt32() == Int32(bitPattern: 0x928e7b55),
              reader.readInt32() == Int32(bitPattern: 0x1cb5c415),
              let count = reader.readInt32(), count >= 0, count <= 1000 else {
            throw WalletTransportError.invalidResponse
        }
        for _ in 0..<count {
            guard reader.readInt32() == Int32(bitPattern: 0xa1b895e5),
                  let id = reader.readInt64(),
                  let address = readString(reader),
                  let _ = parseBytes(reader) else { throw WalletTransportError.invalidResponse }
            if id == recipient.id.id._internalGetInt64Value() { return address }
        }
        throw WalletTransportError.rpc(400, "Recipient has no linked wallet")
    }

    func proofChallenge() async throws -> WalletLinkChallenge {
        let data = try await execute(WalletMTProto.getProofChallenge())
        let reader = BufferReader(Buffer(data: data))
        guard reader.readInt32() == Int32(bitPattern: 0x99e41707),
              let payload = readString(reader), let expires = reader.readInt32(),
              let domain = readString(reader) else { throw WalletTransportError.invalidResponse }
        return WalletLinkChallenge(payload: payload, expires: expires, domain: domain)
    }

    func linkWallet(publicKey: Data, timestamp: Int32, signature: Data) async throws {
        let proof = WalletMTProto.OwnershipProof(timestamp: timestamp, signature: Buffer(data: signature))
        let data = try await execute(WalletMTProto.replaceWallet(wallet: .imported(publicKey: Buffer(data: publicKey), proof: proof), password: nil))
        let reader = BufferReader(Buffer(data: data))
        guard reader.readInt32() == Int32(bitPattern: 0x95c5346b),
              let _ = reader.readInt32(), let _ = readString(reader),
              let returnedKey = parseBytes(reader), returnedKey.makeData() == publicKey,
              let _ = reader.readInt64() else { throw WalletTransportError.invalidResponse }
    }

    private func readString(_ reader: BufferReader) -> String? {
        guard let bytes = parseBytes(reader) else { return nil }
        return String(data: bytes.makeData(), encoding: .utf8)
    }

    func perform(endpoint: String, query: String?, payload: String?) async throws -> String {
        let data = try await execute(WalletMTProto.performApiRequest(endpoint: endpoint, query: query, payload: payload))
        let reader = BufferReader(Buffer(data: data))
        guard reader.readInt32() == Int32(bitPattern: 0xac8dfe19),
              let signature = reader.readInt32(),
              let response = Api.parse(reader, signature: signature) as? Api.DataJSON else {
            throw WalletTransportError.invalidResponse
        }
        switch response {
        case let .dataJSON(value): return value.data
        }
    }

    func execute(_ request: WalletMTProto.Request) async throws -> Data {
        let operation = WalletRPCOperation()
        return try await withTaskCancellationHandler(operation: {
            try await withCheckedThrowingContinuation { continuation in
                operation.install(continuation)
                if Task.isCancelled {
                    operation.finish(.failure(CancellationError()))
                    return
                }
                operation.setDisposable(context.account.network.request(request, automaticFloodWait: false).start(next: { buffer in
                    operation.finish(.success(buffer.makeData()))
                }, error: { error in
                    operation.finish(.failure(WalletTransportError.rpc(Int(error.errorCode), error.errorDescription ?? "RPC error")))
                }))
            }
        }, onCancel: { operation.finish(.failure(CancellationError())) })
    }
}
