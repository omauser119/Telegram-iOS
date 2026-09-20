import Foundation
import AccountContext
import TelegramCore
import Postbox
import TelegramApi
import SwiftSignalKit
import WalletEngineUI
import TdBinding

@available(iOS 18.0, *)
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
@available(iOS 18.0, *)
private final class WalletRPCOperation<T>: @unchecked Sendable {
    private let lock = NSLock()
    private let disposable = MetaDisposable()
    private var continuation: CheckedContinuation<T, Error>?
    private var result: Result<T, Error>?

    func install(_ continuation: CheckedContinuation<T, Error>) {
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
    func finish(_ result: Result<T, Error>) {
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

@available(iOS 18.0, *)
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
        let response = try await execute(WalletMTProto.Typed.getUserAddresses(id: [user], addresses: []))
        guard case let .userAddresses(addresses, _) = response else { throw WalletTransportError.invalidResponse }
        for item in addresses {
            guard case let .walletUserAddress(id, address, _) = item else { throw WalletTransportError.invalidResponse }
            if id == recipient.id.id._internalGetInt64Value() { return address }
        }
        throw WalletTransportError.rpc(400, "Recipient has no linked wallet")
    }

    func proofChallenge() async throws -> WalletLinkChallenge {
        let response = try await execute(WalletMTProto.Typed.getProofChallenge())
        guard case let .proofChallenge(payload, expires, domain) = response else { throw WalletTransportError.invalidResponse }
        return WalletLinkChallenge(payload: payload, expires: expires, domain: domain)
    }

    func linkWallet(publicKey: Data, timestamp: Int32, signature: Data) async throws {
        let proof = WalletMTProto.OwnershipProof(timestamp: timestamp, signature: Buffer(data: signature))
        let state = try await execute(WalletMTProto.Typed.replaceWallet(wallet: .imported(publicKey: Buffer(data: publicKey), proof: proof), password: nil))
        guard case let .walletState(_, _, returnedKey, _) = state, returnedKey.makeData() == publicKey else { throw WalletTransportError.invalidResponse }
    }

    func perform(endpoint: String, query: String?, payload: String?) async throws -> String {
        let result = try await execute(WalletMTProto.Typed.performApiRequest(endpoint: endpoint, query: query, payload: payload))
        guard case let .apiResponse(response) = result else { throw WalletTransportError.invalidResponse }
        switch response {
        case let .dataJSON(value): return value.data
        }
    }

    // Explicit operations for the backup UI. No backup mutation runs at startup.
    func enableBackup(secret: Data, password: Api.InputCheckPasswordSRP?) async throws -> WalletMTProto.WalletState {
        let holders = try await execute(WalletMTProto.Typed.getBackupHolderDcs())
        guard holders.count == 3 else { throw WalletTransportError.invalidResponse }
        let keys = holders.map { holder -> Data in
            switch holder {
            case let .holderDc(_, publicKey): return publicKey.makeData()
            }
        }
        let parts = try WalletBackupCrypto.encryptSecret(secret, holderPublicKeys: keys)
        return try await execute(WalletMTProto.Typed.enableBackup(parts: parts.map { Buffer(data: $0) }, password: password))
    }

    func exportBackupSecret(password: Api.InputCheckPasswordSRP?) async throws -> Data {
        let keyPair = try WalletBackupCryptoKeyPair.generate()
        let exported = try await execute(WalletMTProto.Typed.exportSecretPhrase(password: password))
        guard case let .secretPhraseParts(token, holders) = exported else { throw WalletTransportError.invalidResponse }
        guard holders.count == 3 else { throw WalletTransportError.invalidResponse }
        var parts: [Data] = []
        for dc in holders {
            guard dc > 0, dc <= 100 else { throw WalletTransportError.invalidResponse }
            let result = try await execute(
                WalletMTProto.Typed.fetchEncryptedSecretPhrasePart(token: token, publicKey: Buffer(data: keyPair.publicKey)),
                datacenterId: dc
            )
            guard case let .encryptedSecretPhrasePart(data) = result else { throw WalletTransportError.invalidResponse }
            parts.append(data.makeData())
        }
        return try keyPair.decryptAndCombineEnvelopes(parts)
    }

    func execute<T>(_ request: WalletMTProto.TypedRequest<T>, datacenterId: Int32? = nil) async throws -> T {
        let operation = WalletRPCOperation<T>()
        return try await withTaskCancellationHandler(operation: {
            try await withCheckedThrowingContinuation { continuation in
                operation.install(continuation)
                if Task.isCancelled {
                    operation.finish(.failure(CancellationError()))
                    return
                }
                operation.setDisposable(context.account.network.walletRelayRequest(request, datacenterId: datacenterId).start(next: { response in
                    operation.finish(.success(response))
                }, error: { error in
                    operation.finish(.failure(WalletTransportError.rpc(Int(error.errorCode), error.errorDescription ?? "RPC error")))
                }))
            }
        }, onCancel: { operation.finish(.failure(CancellationError())) })
    }
}
