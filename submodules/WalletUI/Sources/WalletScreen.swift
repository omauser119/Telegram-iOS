import Foundation
import UIKit
import SwiftUI
import AsyncDisplayKit
import Display
import AccountContext
import Postbox
import TelegramCore
import TelegramApi
import TelegramPresentationData
import SwiftSignalKit
import MtProtoKit

private final class WalletScreenModel: ObservableObject {
    @Published var loading = false
    @Published var notice = "Connect to check wallet availability."
    @Published var recipient = ""
    private let context: AccountContext
    private let request = MetaDisposable()
    private let peerRequest = MetaDisposable()

    init(context: AccountContext, recipientId: PeerId?) {
        self.context = context
        if let recipientId {
            self.recipient = "Recipient"
            self.peerRequest.set((context.engine.data.get(TelegramEngine.EngineData.Item.Peer.Peer(id: recipientId))
            |> deliverOnMainQueue).start(next: { [weak self] peer in
                self?.recipient = peer?.debugDisplayTitle ?? "Recipient unavailable"
            }))
        }
    }

    deinit {
        self.request.dispose()
        self.peerRequest.dispose()
    }

    func refresh() {
        guard !self.loading else { return }
        self.loading = true
        self.notice = "Checking wallet availability…"
        self.request.set((self.context.account.network.request(WalletExperimentalApi.proofChallengeConstructor(), automaticFloodWait: false)
        |> deliverOnMainQueue).start(next: { [weak self] _ in
            self?.loading = false
            self?.notice = "Wallet service is available. Wallet setup is not available in this preview."
        }, error: { [weak self] error in
            self?.loading = false
            if error.errorDescription == "WALLET_UNAVAILABLE" {
                self?.notice = "Wallet is currently unavailable for this account."
            } else {
                self?.notice = "Unable to load wallet: \(error.errorDescription ?? "Unknown error")"
            }
        }))
    }
}

// Balance card layout and actions adapted from i582/wallet-engine's Swift
// example (MIT license; see NOTICE and LICENSE-wallet-engine in this module).
private struct WalletDashboard: View {
    @ObservedObject var model: WalletScreenModel
    @State private var balanceVisible = true
    @State private var amount = ""
    let isSend: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 18) {
                    HStack {
                        Text("BALANCE").font(.caption).bold()
                        Spacer()
                        Button(action: { self.balanceVisible.toggle() }) {
                            Image(systemName: self.balanceVisible ? "eye" : "eye.slash")
                        }.accessibility(label: Text(self.balanceVisible ? "Hide balance" : "Show balance"))
                    }
                    HStack(alignment: .firstTextBaseline, spacing: 10) {
                        Text(self.balanceVisible ? "—" : "••••••")
                            .font(Font.system(size: 42, weight: .semibold, design: .rounded).monospacedDigit())
                        Text("GRAM").font(.title)
                    }
                }
                .foregroundColor(.white)
                .padding(24)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.03, green: 0.38, blue: 0.68), Color(red: 0.02, green: 0.22, blue: 0.46)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(20)
                .accessibility(identifier: "wallet-balance")

                if self.isSend {
                    Text("Send Money to \(self.model.recipient)").font(.headline)
                    TextField("0 GRAM", text: self.$amount)
                        .keyboardType(.decimalPad)
                        .font(.largeTitle)
                        .accessibility(identifier: "wallet-send-amount")
                    Text("Transfers are not available in this preview.").foregroundColor(.secondary)
                    Button("Send") {}.disabled(true)
                } else {
                    HStack {
                        Text("↙ Receive")
                        Spacer()
                        Text("↗ Send")
                    }.foregroundColor(.secondary)
                    Text("Recent Activity").font(.headline)
                    Text("Wallet activity is not available yet.").foregroundColor(.secondary)
                }
                Text(self.model.notice).font(.callout)
                    .accessibility(identifier: "wallet-service-status")
                if self.model.loading {
                    Text("Loading…").foregroundColor(.secondary)
                } else {
                    Button("Retry", action: self.model.refresh)
                }
            }.padding(20)
        }
        .background(Color(UIColor.systemGroupedBackground))
        .onAppear(perform: self.model.refresh)
    }
}

public final class WalletScreen: ViewController {
    private let model: WalletScreenModel
    private var host: UIHostingController<WalletDashboard>?
    private let isSend: Bool

    public init(context: AccountContext, recipientId: PeerId? = nil) {
        self.model = WalletScreenModel(context: context, recipientId: recipientId)
        self.isSend = recipientId != nil
        let presentationData = context.sharedContext.currentPresentationData.with { $0 }
        super.init(navigationBarPresentationData: NavigationBarPresentationData(presentationData: presentationData, style: .glass))
        self.title = self.isSend ? "Send Money" : "Wallet"
    }

    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func loadDisplayNode() {
        self.displayNode = ASDisplayNode()
        let host = UIHostingController(rootView: WalletDashboard(model: self.model, isSend: self.isSend))
        self.host = host
        self.addChild(host)
        self.displayNode.view.addSubview(host.view)
        host.didMove(toParent: self)
        self.displayNodeDidLoad()
    }

    override public func containerLayoutUpdated(_ layout: ContainerViewLayout, transition: ContainedViewLayoutTransition) {
        super.containerLayoutUpdated(layout, transition: transition)
        let top = self.navigationLayout(layout: layout).navigationFrame.maxY
        self.host?.view.frame = CGRect(x: 0, y: top, width: layout.size.width, height: max(0, layout.size.height - top))
    }
}
