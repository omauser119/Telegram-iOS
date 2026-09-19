import Foundation
import WalletEngineFFI

public nonisolated struct WalletLinkChallenge: Sendable {
    public let payload: String
    public let expires: Int32
    public let domain: String
    public init(payload: String, expires: Int32, domain: String) {
        self.payload = payload; self.expires = expires; self.domain = domain
    }
}

public nonisolated protocol WalletProviderTransport: Sendable {
    func recipientAddress() async throws -> String
    func proofChallenge() async throws -> WalletLinkChallenge
    func linkWallet(publicKey: Data, timestamp: Int32, signature: Data) async throws
    func perform(endpoint: String, query: String?, payload: String?) async throws -> String
}

/// Wallet Engine still builds and parses Toncenter requests. Only transport is
/// replaced: every provider request goes through the logged-in Telegram account.
nonisolated final class TelegramWalletHTTPHost: WalletHttpHost, @unchecked Sendable {
    private let transport: any WalletProviderTransport
    private let lock = NSLock()
    private var tasks: [UInt64: Task<HttpResponse, Error>] = [:]
    private var earlyCancellation: Set<UInt64> = []

    init(transport: any WalletProviderTransport) { self.transport = transport }

    func executeHttp(request: HttpRequest) async throws -> HttpResponse {
        guard let url = URLComponents(string: request.url),
              url.scheme == "https", url.host == "toncenter.com",
              url.user == nil, url.password == nil, url.fragment == nil,
              request.body.count <= 256 * 1024 else {
            throw HttpHostError.Failed(kind: .policyViolation, diagnostic: "Invalid wallet provider request")
        }
        let payload: String?
        if request.body.isEmpty { payload = nil } else {
            guard let body = String(data: request.body, encoding: .utf8) else {
                throw HttpHostError.Failed(kind: .policyViolation, diagnostic: "Provider payload is not UTF-8")
            }
            payload = body
        }
        let transport = self.transport
        guard request.timeoutMs > 0 && request.timeoutMs <= 300_000 else {
            throw HttpHostError.Failed(kind: .policyViolation, diagnostic: "Invalid provider timeout")
        }
        let task = try lock.withLock { () throws -> Task<HttpResponse, Error> in
            guard tasks[request.id.value] == nil else {
                throw HttpHostError.Failed(kind: .policyViolation, diagnostic: "Duplicate provider request")
            }
            guard earlyCancellation.remove(request.id.value) == nil else {
                throw CancellationError()
            }
            let task = Task<HttpResponse, Error> {
                let json = try await withThrowingTaskGroup(of: String.self) { group in
                    group.addTask {
                        try await transport.perform(endpoint: url.path, query: url.percentEncodedQuery, payload: payload)
                    }
                    group.addTask {
                        try await Task.sleep(nanoseconds: request.timeoutMs * 1_000_000)
                        throw HttpHostError.Failed(kind: .timeout, diagnostic: "Wallet provider timed out")
                    }
                    defer { group.cancelAll() }
                    guard let result = try await group.next() else { throw CancellationError() }
                    return result
                }
                try Task.checkCancellation()
                guard json.utf8.count <= 4 * 1024 * 1024 else {
                    throw HttpHostError.Failed(kind: .responseTooLarge, diagnostic: "Wallet response exceeds limit")
                }
                return HttpResponse(status: 200, headers: [], body: Data(json.utf8), finalUrl: request.url)
            }
            tasks[request.id.value] = task
            return task
        }
        defer { _ = lock.withLock { tasks.removeValue(forKey: request.id.value) } }
        return try await withTaskCancellationHandler(operation: { try await task.value }, onCancel: { task.cancel() })
    }

    func cancelHttp(requestId: HttpRequestId) async {
        lock.withLock {
            if let task = tasks[requestId.value] { task.cancel() } else {
                earlyCancellation.insert(requestId.value)
                if earlyCancellation.count > 1024 { earlyCancellation.removeAll() }
            }
        }
    }
}
