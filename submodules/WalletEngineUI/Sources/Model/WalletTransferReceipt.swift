import Foundation

@available(iOS 18.0, *)
public nonisolated struct WalletTransferReceipt: Sendable {
    public let operationId: String
    public let amountGrams: String
    public let usdValue: String?
    public let comment: String
    public let messageHash: String
    public let isConfirmed: Bool
}

/// Fiat is an estimate for display only; transfer amounts still use exact nanograms.
@available(iOS 18.0, *)
nonisolated enum WalletUsdValue {
    static func format(grams: String, rate: Double?) -> String? {
        guard let rate, rate.isFinite, rate > 0,
              let nanograms = GramAmount.nanograms(from: grams),
              nanograms.count <= 30,
              let amount = Decimal(string: GramAmount.format(nanograms: nanograms), locale: Locale(identifier: "en_US_POSIX")),
              let decimalRate = Decimal(string: String(rate), locale: Locale(identifier: "en_US_POSIX")) else { return nil }
        let value = amount * decimalRate
        guard !value.isNaN else { return nil }
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSDecimalNumber(decimal: value))
    }
}
