#if os(iOS) && TGCALLS_RUST
import Foundation
import CTgCalls
import SwiftSignalKit
import TgCallsRust
import TgVoipWebrtc

/// Sequential 1-second Ogg/Opus parts from the app's MTProto transport.
final class RustBroadcastAudio {
    private let queue: Queue
    private let source: BroadcastPartSource
    private let worker: LocalWorker
    private let audio: TGCallsIOSAudioDevice
    private let state: (Bool) -> Void
    private let rejoin: () -> Void
    private let pending = MetaDisposable()
    private var timer: DispatchSourceTimer?
    private var timestamp: Int64?
    private var requested = false
    private var stopped = false
    private var active = false
    private var playing = false
    private var retryAt: UInt64 = 0
    private var frames: [Data] = []

    init(queue: Queue, source: BroadcastPartSource, hardened: Bool, state: @escaping (Bool) -> Void, rejoin: @escaping () -> Void) throws {
        self.queue = queue
        self.source = source
        if hardened {
            guard let module = Bundle.main.url(forResource: "tgcalls-worker", withExtension: "wasm") else {
                throw RustCallMediaError.missingGuest
            }
            self.worker = try LocalWorker(wasmModule: Data(contentsOf: module, options: .mappedIfSafe), hardened: true)
        } else {
            self.worker = try LocalWorker(hardened: false)
        }
        self.audio = TGCallsIOSAudioDevice(queue: queue.queue, manageSessionActivation: false, captureEnabled: false,
                                          capture: { _, _, _, _ in }, render: { _ in }, failure: { _ in })
        self.state = state
        self.rejoin = rejoin
        try audio.start()
        let timer = DispatchSource.makeTimerSource(queue: queue.queue)
        timer.schedule(deadline: .now(), repeating: .milliseconds(20), leeway: .milliseconds(2))
        timer.setEventHandler { [weak self] in self?.tick() }
        self.timer = timer
        timer.resume()
    }

    deinit { stop() }

    func setAudioActive(_ active: Bool) {
        self.active = active
        audio.setCallKitActive(active)
    }

    private func tick() {
        guard !stopped else { return }
        if active, !frames.isEmpty {
            if audio.enqueuePlayback(frames[0]) {
                frames.removeFirst()
            }
        }
        guard !requested, frames.count < 50, DispatchTime.now().uptimeNanoseconds >= retryAt else { return }
        requested = true
        if let timestamp {
            pending.set(source.requestPart(timestampMilliseconds: timestamp, durationMilliseconds: 1000, subject: .audio, completion: { [weak self] part in
                self?.queue.justDispatch { [weak self] in self?.receive(part) }
            }, rejoinNeeded: { [weak self] in
                self?.queue.justDispatch { [weak self] in
                    guard let self, !self.stopped else { return }
                    self.stop()
                    self.rejoin()
                }
            }))
        } else {
            pending.set(source.requestTime(completion: { [weak self] now in
                self?.queue.justDispatch { [weak self] in
                    guard let self, !self.stopped else { return }
                    self.requested = false
                    if now > 2000 {
                        self.timestamp = now - now % 1000 - 2000
                    } else {
                        self.deferRetry()
                    }
                }
            }))
        }
    }

    private func receive(_ part: OngoingGroupCallBroadcastPart) {
        guard !stopped else { return }
        requested = false
        switch part.status {
        case .success:
            guard part.oggData.count <= 1024 * 1024, part.oggData.starts(with: Data("OggS".utf8)) else {
                deferRetry()
                return
            }
            do {
                var request = Data([0x54, 0x47, 0x43, 1, 6])
                request.append(part.oggData)
                let output = try JSONDecoder().decode(WorkerResponse.self, from: worker.request(request))
                guard output.ok, !output.audio.isEmpty else { deferRetry(); return }
                frames.append(contentsOf: output.audio.prefix(75).compactMap { $0.pcm.count == 3840 ? Data($0.pcm) : nil })
                timestamp = part.timestampMilliseconds + 1000
                if !playing { playing = true; state(true) }
            } catch {
                stop()
                rejoin()
            }
        case .notReady:
            deferRetry()
        case .resyncNeeded:
            timestamp = nil
            frames.removeAll(keepingCapacity: true)
        @unknown default:
            deferRetry()
        }
    }

    private func deferRetry() {
        retryAt = DispatchTime.now().uptimeNanoseconds + 250_000_000
    }

    func stop() {
        guard !stopped else { return }
        stopped = true
        pending.dispose()
        timer?.cancel()
        timer = nil
        audio.stop()
        frames.removeAll()
        if playing { state(false) }
    }
}
#endif
