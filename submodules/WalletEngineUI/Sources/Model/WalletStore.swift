import Foundation

struct WalletArchive: Codable, Sendable {
    static let currentVersion = 3

    let version: Int
    var wallets: [StoredWallet]
    var selectedAddress: String?

    static let empty = WalletArchive(
        version: currentVersion,
        wallets: [],
        selectedAddress: nil
    )
}

nonisolated struct WalletStore: Sendable {
    let namespace: String
    private nonisolated var fileURL: URL {
        get throws {
            let applicationSupport = try FileManager.default.url(
                for: .applicationSupportDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            let directory = applicationSupport.appendingPathComponent(
                Bundle.main.bundleIdentifier ?? "TON-Wallet",
                isDirectory: true
            )
            let namespacedDirectory = directory.appendingPathComponent(namespace, isDirectory: true)
            try FileManager.default.createDirectory(
                at: namespacedDirectory,
                withIntermediateDirectories: true,
                attributes: [.posixPermissions: 0o700]
            )
            return namespacedDirectory.appendingPathComponent("wallets.json")
        }
    }

    func load() throws -> WalletArchive {
        let url = try fileURL
        guard FileManager.default.fileExists(atPath: url.path) else {
            return .empty
        }
        let data = try Data(contentsOf: url)
        let archive = try JSONDecoder().decode(WalletArchive.self, from: data)
        guard archive.version == 2 || archive.version == WalletArchive.currentVersion else {
            throw CocoaError(.fileReadCorruptFile)
        }
        return WalletArchive(
            version: WalletArchive.currentVersion,
            wallets: archive.wallets,
            selectedAddress: archive.selectedAddress
        )
    }

    func save(wallets: [StoredWallet], selectedAddress: String?) throws {
        let archive = WalletArchive(
            version: WalletArchive.currentVersion,
            wallets: wallets,
            selectedAddress: selectedAddress
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(archive)
        let url = try fileURL
        try data.write(to: url, options: .atomic)
        try FileManager.default.setAttributes(
            [.posixPermissions: 0o600],
            ofItemAtPath: url.path
        )
    }

}
