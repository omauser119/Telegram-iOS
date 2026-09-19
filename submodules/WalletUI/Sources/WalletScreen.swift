import Foundation
import UIKit
import SwiftUI
import AsyncDisplayKit
import Display
import AccountContext
import Postbox
import TelegramCore
import TelegramPresentationData
import SwiftSignalKit
import WalletEngineUI
import AttachmentUI

/// Hosts the adapted wallet-engine Swift example inside Telegram navigation.
@available(iOS 18.0, *)
public final class WalletScreen: ViewController, AttachmentContainable {
    public var requestAttachmentMenuExpansion: () -> Void = {}
    public var updateNavigationStack: (@escaping ([AttachmentContainable]) -> ([AttachmentContainable], AttachmentMediaPickerContext?)) -> Void = { _ in }
    public var parentController: () -> ViewController? = { nil }
    public var updateTabBarAlpha: (CGFloat, ContainedViewLayoutTransition) -> Void = { _, _ in }
    public var updateTabBarVisibility: (Bool, ContainedViewLayoutTransition) -> Void = { _, _ in }
    public var cancelPanGesture: () -> Void = {}
    public var isContainerPanning: () -> Bool = { false }
    public var isContainerExpanded: () -> Bool = { true }
    public var mediaPickerContext: AttachmentMediaPickerContext? { nil }
    public var isMinimized = false
    private let context: AccountContext
    private let peerRequest = MetaDisposable()
    private var host: UIHostingController<AnyView>?
    private var lastLayout: ContainerViewLayout?
    private let recipientId: PeerId?

    public init(context: AccountContext, recipientId: PeerId? = nil) {
        self.context = context
        self.recipientId = recipientId
        super.init(navigationBarPresentationData: nil)
    }

    required public init(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    deinit { peerRequest.dispose() }

    override public func loadDisplayNode() {
        self.displayNode = ASDisplayNode()
        self.displayNode.backgroundColor = .systemBackground
        self.displayNodeDidLoad()
        let accountId = context.account.peerId
        let recipientId = self.recipientId
        self.peerRequest.set((context.account.postbox.transaction { transaction -> (TelegramUser?, TelegramUser?) in
            return (transaction.getPeer(accountId) as? TelegramUser, recipientId.flatMap { transaction.getPeer($0) as? TelegramUser })
        }
        |> deliverOnMainQueue).start(next: { [weak self] peers in
            guard let self, self.host == nil else { return }
            let wallet = WalletEngineView(
                accountId: String(self.context.account.peerId.toInt64()),
                ownerName: [peers.0?.firstName, peers.0?.lastName].compactMap { $0 }.joined(separator: " "),
                recipientName: peers.1.map { [$0.firstName, $0.lastName].compactMap { $0 }.joined(separator: " ") },
                onClose: { [weak self] in
                    guard let self else { return }
                    if recipientId != nil, let parent = self.parentController() { parent.dismiss() }
                    else { self.dismiss() }
                },
                onInputFocusChanged: { [weak self] focused in
                    guard let self, recipientId != nil else { return }
                    if focused { self.requestAttachmentMenuExpansion() }
                    self.updateTabBarVisibility(!focused, .animated(duration: 0.25, curve: .easeInOut))
                },
                transport: TelegramWalletTransport(context: self.context, recipient: peers.1)
            )
            let host = UIHostingController(rootView: AnyView(wallet))
            self.host = host
            self.addChild(host)
            self.displayNode.view.addSubview(host.view)
            host.didMove(toParent: self)
            if let layout = self.lastLayout {
                host.view.frame = CGRect(origin: .zero, size: layout.size)
            }
        }))
    }

    override public func containerLayoutUpdated(_ layout: ContainerViewLayout, transition: ContainedViewLayoutTransition) {
        super.containerLayoutUpdated(layout, transition: transition)
        self.lastLayout = layout
        self.host?.view.frame = CGRect(origin: .zero, size: layout.size)
    }
}
