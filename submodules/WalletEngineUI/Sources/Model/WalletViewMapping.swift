import Foundation
import WalletEngineFFI

/// Adapts  engine records to the DTOs consumed by the existing views.
@available(iOS 18.0, *)
nonisolated extension WalletAccountSnapshot {
    init(engine value: WalletEngineFFI.AccountSnapshot) {
        balanceNanograms = value.balanceNanograms
        status = switch value.status {
        case .nonexistent: "nonexistent"
        case .uninitialized: "uninitialized"
        case .active: "active"
        case .frozen: "frozen"
        case .unknown: "unknown"
        }
        syncUtime = value.syncUtime
    }
}

@available(iOS 18.0, *)
nonisolated extension WalletTransaction {
    init(engine value: WalletEngineFFI.ActivityItem) {
        id = value.id
        transactionHash = value.transactionHash
        logicalTime = value.logicalTime
        timestamp = value.timestamp
        direction = switch value.direction {
        case .sent: "sent"
        case .received: "received"
        }
        amountNanograms = value.amountNanograms
        counterparty = value.counterparty
    }
}

@available(iOS 18.0, *)
nonisolated extension WalletEngineFFI.WalletSnapshot {
    var viewAccount: WalletAccountSnapshot? {
        account.map(WalletAccountSnapshot.init(engine:))
    }

    var viewTransactions: [WalletTransaction] {
        activity.items.map(WalletTransaction.init(engine:))
    }
}
