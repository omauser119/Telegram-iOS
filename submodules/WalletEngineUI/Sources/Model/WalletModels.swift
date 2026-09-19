import Foundation

@available(iOS 18.0, *)
nonisolated enum StoredWalletNetwork: String, Codable, Sendable {
    case mainnet
    case testnet
}

/// Public wallet metadata persisted by the example application.
/// Recovery words are stored only by `AppleWalletPlatformHost`.
@available(iOS 18.0, *)
nonisolated struct StoredWallet: Codable, Identifiable, Sendable {
    let recordId: String
    let address: String
    /// Public derivation data required to reconstruct the wallet account.
    let publicKey: Data
    var name: String
    let network: StoredWalletNetwork
    let secretRef: String

    var id: String { recordId }
}

@available(iOS 18.0, *)
nonisolated struct WalletAccountSnapshot: Sendable {
    let balanceNanograms: String
    let status: String
    let syncUtime: UInt64

    var balanceGrams: String {
        GramAmount.format(nanograms: balanceNanograms)
    }
}

@available(iOS 18.0, *)
nonisolated struct WalletTransaction: Identifiable, Sendable {
    let id: String
    let transactionHash: String
    let logicalTime: String
    let timestamp: UInt64
    let direction: String
    let amountNanograms: String
    let counterparty: String?

    var isReceived: Bool { direction == "received" }

    var amountGrams: String {
        GramAmount.format(nanograms: amountNanograms)
    }
}
