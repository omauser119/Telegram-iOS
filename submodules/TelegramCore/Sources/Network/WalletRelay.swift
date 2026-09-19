import Foundation
import TelegramApi
import SwiftSignalKit
import MtProtoKit

extension Network {
    /// Some wallet proxy endpoints live on another DC. Use Telegram's existing
    /// authorized worker pool without moving the account's primary connection.
    public func walletRelayRequest(_ data: WalletMTProto.Request) -> Signal<Buffer, MTRpcError> {
        return self.request(data, automaticFloodWait: false)
        |> `catch` { error -> Signal<Buffer, MTRpcError> in
            guard let message = error.errorDescription,
                  message.hasPrefix("FILE_MIGRATE_"),
                  let dc = Int(message.dropFirst("FILE_MIGRATE_".count)), dc > 0, dc <= 100 else {
                return .fail(error)
            }
            return self.multiplexedRequestManager.request(
                to: .main(dc), consumerId: Int64.random(in: 1...Int64.max),
                resourceId: nil, data: data, tag: nil, continueInBackground: false,
                automaticFloodWait: false, expectedResponseSize: nil
            )
        }
    }
}
