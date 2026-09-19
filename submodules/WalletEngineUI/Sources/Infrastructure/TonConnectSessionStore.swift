import Foundation
import Security

@available(iOS 18.0, *)
nonisolated struct StoredTonConnectSession: Codable, Sendable {
    let rustSession: String
    let manifestURL: String
    let manifestName: String
    let manifestIconURL: String
    let manifestDomain: String
}

/// Keychain-backed storage for secret-bearing TON Connect session keys.
@available(iOS 18.0, *)
actor TonConnectSessionStore {
    static let shared = TonConnectSessionStore()

    private let service = "org.ton.wallet-engine.example.ton-connect"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    func load(recordId: String) throws -> StoredTonConnectSession? {
        var query = baseQuery(recordId: recordId)
        query[kSecReturnData as String] = true
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        addPlatformAttributes(to: &query)

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        if status == errSecItemNotFound {
            return nil
        }
        guard status == errSecSuccess, let data = item as? Data else {
            throw TonConnectSessionStoreError.keychain(status)
        }
        return try decoder.decode(StoredTonConnectSession.self, from: data)
    }

    func save(_ value: StoredTonConnectSession, recordId: String) throws {
        let data = try encoder.encode(value)
        var query = baseQuery(recordId: recordId)
        addPlatformAttributes(to: &query)
        let attributes: [String: Any] = [kSecValueData as String: data]
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        if status == errSecSuccess {
            return
        }
        guard status == errSecItemNotFound else {
            throw TonConnectSessionStoreError.keychain(status)
        }
        query[kSecValueData as String] = data
        query[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        let addStatus = SecItemAdd(query as CFDictionary, nil)
        guard addStatus == errSecSuccess else {
            throw TonConnectSessionStoreError.keychain(addStatus)
        }
    }

    func remove(recordId: String) throws {
        var query = baseQuery(recordId: recordId)
        addPlatformAttributes(to: &query)
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw TonConnectSessionStoreError.keychain(status)
        }
    }

    private func baseQuery(recordId: String) -> [String: Any] {
        [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: recordId,
        ]
    }

    private func addPlatformAttributes(to query: inout [String: Any]) {
#if targetEnvironment(simulator)
        query[kSecUseDataProtectionKeychain as String] = false
#elseif os(iOS)
        query[kSecAttrSynchronizable as String] = false
#elseif DEBUG
        query[kSecUseDataProtectionKeychain as String] = false
        query[kSecAttrSynchronizable as String] = false
#else
        query[kSecUseDataProtectionKeychain as String] = true
        query[kSecAttrSynchronizable as String] = false
#endif
    }
}

@available(iOS 18.0, *)
nonisolated enum TonConnectSessionStoreError: LocalizedError, Sendable {
    case keychain(OSStatus)

    var errorDescription: String? {
        switch self {
        case .keychain(let status):
            "TON Connect session storage failed (\(status))."
        }
    }
}
