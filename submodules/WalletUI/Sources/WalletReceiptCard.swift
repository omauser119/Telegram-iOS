import Foundation
import UIKit
import Postbox
import TelegramCore
import AccountContext
import WalletEngineUI

/// Shareable receipt image; a submitted transfer is never labelled confirmed.
@available(iOS 18.0, *)
enum WalletReceiptCard {
    static func message(context: AccountContext, receipt: WalletTransferReceipt, recipientName: String) -> (String, TelegramMediaImage?) {
        let status = receipt.isConfirmed ? "Confirmed on blockchain" : "Submitted to network"
        var caption = "\(status): \(receipt.amountGrams) GRAM"
        if let usd = receipt.usdValue { caption += " (≈ \(usd) USD)" }
        if !receipt.comment.isEmpty { caption += "\n" + String(receipt.comment.prefix(256)) }
        caption += "\nMessage hash: \(receipt.messageHash)"

        let size = CGSize(width: 720, height: 480)
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        format.opaque = true
        let image = UIGraphicsImageRenderer(size: size, format: format).image { renderer in
            let cg = renderer.cgContext
            let colors = [UIColor(red: 0.0, green: 0.70, blue: 1.0, alpha: 1).cgColor,
                          UIColor(red: 0.08, green: 0.42, blue: 0.98, alpha: 1).cgColor] as CFArray
            if let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors, locations: [0, 1]) {
                cg.drawLinearGradient(gradient, start: .zero, end: CGPoint(x: 720, y: 480), options: [])
            }
            UIColor.white.withAlphaComponent(0.07).setFill()
            UIBezierPath(ovalIn: CGRect(x: 430, y: -120, width: 400, height: 400)).fill()
            UIBezierPath(ovalIn: CGRect(x: -140, y: 300, width: 440, height: 440)).fill()

            func text(_ value: String, y: CGFloat, size: CGFloat, weight: UIFont.Weight, opacity: CGFloat = 1, height: CGFloat = 50) {
                let paragraph = NSMutableParagraphStyle()
                paragraph.alignment = .center
                paragraph.lineBreakMode = .byTruncatingTail
                (value as NSString).draw(in: CGRect(x: 32, y: y, width: 656, height: height), withAttributes: [
                    .font: UIFont.systemFont(ofSize: size, weight: weight),
                    .foregroundColor: UIColor.white.withAlphaComponent(opacity),
                    .paragraphStyle: paragraph
                ])
            }
            UIImage(systemName: "diamond.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
                .draw(in: CGRect(x: 335, y: 35, width: 50, height: 44))
            text("\(receipt.amountGrams) GRAM", y: 100, size: receipt.amountGrams.count > 14 ? 32 : 48, weight: .semibold, height: 62)
            if let usd = receipt.usdValue { text("≈ \(usd) USD", y: 168, size: 22, weight: .medium, opacity: 0.85) }
            text("To \(recipientName)", y: 220, size: 23, weight: .medium)
            text(status, y: 264, size: 19, weight: .medium, opacity: 0.85)
            if !receipt.comment.isEmpty { text(String(receipt.comment.prefix(120)), y: 315, size: 22, weight: .regular, height: 64) }
            text("Wallet transfer receipt", y: 419, size: 17, weight: .medium, opacity: 0.7)
        }
        guard let data = image.jpegData(compressionQuality: 0.92) else { return (caption, nil) }
        let resource = LocalFileMediaResource(fileId: Int64.random(in: Int64.min ... Int64.max))
        context.account.postbox.mediaBox.storeResourceData(resource.id, data: data)
        let representation = TelegramMediaImageRepresentation(dimensions: PixelDimensions(width: 720, height: 480), resource: resource, progressiveSizes: [], immediateThumbnailData: nil)
        let media = TelegramMediaImage(imageId: MediaId(namespace: Namespaces.Media.LocalImage, id: Int64.random(in: Int64.min ... Int64.max)), representations: [representation], immediateThumbnailData: nil, reference: nil, partialReference: nil, flags: [])
        return (caption, media)
    }
}
