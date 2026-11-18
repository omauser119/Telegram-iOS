#if os(iOS) && TGCALLS_RUST
import Foundation
import Darwin
import Network
import CTgCalls
import TgCallsRust

enum RustCallMediaError: Error {
    case socket, relayUnavailable, badTransport, workerRejected, missingGuest
}

struct RustCallEndpoint: Hashable {
    let host: String
    let port: UInt16
    let family: Int32

    init?(_ host: String, _ port: UInt16) {
        guard port != 0 else { return nil }
        var addr4 = in_addr()
        var addr6 = in6_addr()
        let size = socklen_t(INET6_ADDRSTRLEN)
        var canonical = [CChar](repeating: 0, count: Int(size))
        if inet_pton(AF_INET, host, &addr4) == 1 {
            family = AF_INET
            guard inet_ntop(AF_INET, &addr4, &canonical, size) != nil else { return nil }
        } else if inet_pton(AF_INET6, host, &addr6) == 1 {
            family = AF_INET6
            guard inet_ntop(AF_INET6, &addr6, &canonical, size) != nil else { return nil }
        } else {
            return nil
        }
        self.host = String(decoding: canonical.prefix(while: { $0 != 0 }).map { UInt8(bitPattern: $0) }, as: UTF8.self)
        self.port = port
    }

    init?(_ pair: String) {
        guard let i = pair.lastIndex(of: ":"), let port = UInt16(pair[pair.index(after: i)...]) else { return nil }
        let address = pair[..<i]
        if address.first == "[" && address.last == "]" {
            self.init(String(address.dropFirst().dropLast()), port)
        } else {
            self.init(String(address), port)
        }
    }

    init?(_ storage: inout sockaddr_storage, _ size: socklen_t) {
        let hostSize = socklen_t(NI_MAXHOST)
        let portSize = socklen_t(NI_MAXSERV)
        var host = [CChar](repeating: 0, count: Int(hostSize))
        var port = [CChar](repeating: 0, count: Int(portSize))
        let status = withUnsafePointer(to: &storage) { pointer in
            pointer.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                getnameinfo($0, size, &host, hostSize, &port, portSize, NI_NUMERICHOST | NI_NUMERICSERV)
            }
        }
        let portString = String(decoding: port.prefix(while: { $0 != 0 }).map { UInt8(bitPattern: $0) }, as: UTF8.self)
        guard status == 0, let number = UInt16(portString) else { return nil }
        self.init(String(decoding: host.prefix(while: { $0 != 0 }).map { UInt8(bitPattern: $0) }, as: UTF8.self), number)
    }

    var address: String { family == AF_INET6 ? "[\(host)]:\(port)" : "\(host):\(port)" }

    func withAddress<T>(port: UInt16? = nil, _ body: (UnsafePointer<sockaddr>, socklen_t) -> T) -> T {
        if family == AF_INET {
            var addr = sockaddr_in()
            addr.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
            addr.sin_family = sa_family_t(AF_INET)
            addr.sin_port = (port ?? self.port).bigEndian
            _ = inet_pton(AF_INET, host, &addr.sin_addr)
            return withUnsafePointer(to: &addr) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { body($0, socklen_t(MemoryLayout<sockaddr_in>.size)) }
            }
        }
        var addr = sockaddr_in6()
        addr.sin6_len = UInt8(MemoryLayout<sockaddr_in6>.size)
        addr.sin6_family = sa_family_t(AF_INET6)
        addr.sin6_port = (port ?? self.port).bigEndian
        _ = inet_pton(AF_INET6, host, &addr.sin6_addr)
        return withUnsafePointer(to: &addr) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { body($0, socklen_t(MemoryLayout<sockaddr_in6>.size)) }
        }
    }
}

struct RustIceServer {
    let endpoint: RustCallEndpoint
    let username: String
    let password: String
    let turn: Bool

    var request: [String: Any] {
        ["host": endpoint.host, "port": endpoint.port, "username": username, "password": password, "turn": turn]
    }
}

private final class RustCallSocket {
    let local: RustCallEndpoint
    private let fd: Int32
    private var reader: DispatchSourceRead?
    private var closed = false

    init(route: RustCallEndpoint) throws {
        let fd = Darwin.socket(route.family, SOCK_DGRAM, IPPROTO_UDP)
        guard fd >= 0 else { throw RustCallMediaError.socket }
        let probe = Darwin.socket(route.family, SOCK_DGRAM, IPPROTO_UDP)
        guard probe >= 0 else {
            Darwin.close(fd)
            throw RustCallMediaError.socket
        }
        defer { Darwin.close(probe) }
        // A UDP connect selects the OS route; it sends no application packet.
        guard route.withAddress({ Darwin.connect(probe, $0, $1) }) == 0,
              let address = Self.localAddress(probe),
              address.withAddress(port: 0, { Darwin.bind(fd, $0, $1) }) == 0,
              let local = Self.localAddress(fd),
              fcntl(fd, F_SETFL, O_NONBLOCK) == 0 else {
            Darwin.close(fd)
            throw RustCallMediaError.socket
        }
        self.local = local
        self.fd = fd
    }

    deinit { stop() }

    func stop() {
        guard !closed else { return }
        closed = true
        if let reader {
            reader.cancel()
            self.reader = nil
        } else {
            Darwin.close(fd)
        }
    }

    private static func localAddress(_ fd: Int32) -> RustCallEndpoint? {
        var storage = sockaddr_storage()
        var length = socklen_t(MemoryLayout<sockaddr_storage>.size)
        let status = withUnsafeMutablePointer(to: &storage) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { getsockname(fd, $0, &length) }
        }
        return status == 0 ? RustCallEndpoint(&storage, length) : nil
    }

    func start(queue: DispatchQueue, receive: @escaping (RustCallEndpoint, ArraySlice<UInt8>) -> Void) {
        let fd = self.fd
        let reader = DispatchSource.makeReadSource(fileDescriptor: fd, queue: queue)
        reader.setEventHandler {
            var packet = [UInt8](repeating: 0, count: 2049)
            for _ in 0..<32 {
                var storage = sockaddr_storage()
                var length = socklen_t(MemoryLayout<sockaddr_storage>.size)
                let count = withUnsafeMutablePointer(to: &storage) { pointer in
                    pointer.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                        recvfrom(fd, &packet, 2049, 0, $0, &length)
                    }
                }
                if count < 0 { break }
                if count > 0, count <= 2048, let endpoint = RustCallEndpoint(&storage, length) {
                    receive(endpoint, packet.prefix(count))
                }
            }
        }
        reader.setCancelHandler { Darwin.close(fd) }
        self.reader = reader
        reader.resume()
    }

    func send(_ bytes: [UInt8], to endpoint: RustCallEndpoint) -> Int {
        guard !closed, endpoint.family == local.family, !bytes.isEmpty, bytes.count <= 2048 else { return 0 }
        let result = endpoint.withAddress { addr, size in
            bytes.withUnsafeBytes { sendto(fd, $0.baseAddress, $0.count, 0, addr, size) }
        }
        return max(0, result)
    }
}

/// Owns the local media device and the narrowly scoped UDP capability for one call.
/// All methods run on the same serial queue as the parent Telegram call context.
final class RustCallMedia {
    static var hardenedByDefault: Bool { UserDefaults.standard.bool(forKey: "CallsHardenMode") }
    static let versions = ["9.0.0", "8.0.0"]

    private let queue: DispatchQueue
    private let group: Bool
    private let ssrc: UInt32
    private let ice: [RustIceServer]
    private let videoLayers: [VideoConfig]
    private let presentation: Bool
    private let encryption: OngoingGroupCallEncryptionContext?
    private let worker: LocalWorker
    let hardened: Bool
    private var socket: RustCallSocket
    private var audio: TGCallsIOSAudioDevice?
    private var timer: DispatchSourceTimer?
    private var paths: NWPathMonitor?
    private var path: NWPath?
    private var allowed: Set<RustCallEndpoint> = []
    private var connected = false
    private var closed = false
    private var hasConnected = false
    private var audioActive = false
    private var muted = false
    private var lowBattery = false
    private var noiseSuppression = true
    private var captureFormat: (UInt32, UInt16)?
    private var playback: [UInt32: [Data]] = [:]
    private var groupLiveSources: Set<UInt32> = []
    private var sourceVolume: [UInt32: Double] = [:]
    private var peers: [UInt32: Int64] = [:]
    private var videoPeers: [UInt32: Int64] = [:]
    private var endpoints: [UInt32: String] = [:]
    private var lastVideo: UInt64 = 0
    private var videoNegotiated = false
    private var sentBytes: Int64 = 0
    private var receivedBytes: Int64 = 0
    private var tick = 0
    private let decoder = JSONDecoder()
    var stateChanged: ((OngoingCallContextState.State, Bool, Bool) -> Void)?
    var levels: (([(UInt32, Float, Bool)]) -> Void)?
    var signaling: ((Data) -> Void)?
    var networkChanged: (() -> Void)?
    var incomingVideo: ((String, TgCallsRust.VideoFrame) -> Void)?

    init(queue: DispatchQueue, group: Bool, ice: [RustIceServer] = [], videoLayers: [VideoConfig] = [],
         presentation: Bool = false, encryption: OngoingGroupCallEncryptionContext? = nil,
         hardened: Bool = RustCallMedia.hardenedByDefault) throws {
        self.queue = queue
        self.group = group
        self.ssrc = UInt32.random(in: 1...UInt32(Int32.max) - 6)
        self.ice = Array(ice.prefix(16))
        self.videoLayers = videoLayers
        self.presentation = presentation
        self.encryption = encryption
        self.hardened = hardened
        if hardened {
            guard let wasmURL = Bundle.main.url(forResource: "tgcalls-worker", withExtension: "wasm") else {
                throw RustCallMediaError.missingGuest
            }
            worker = try LocalWorker(wasmModule: Data(contentsOf: wasmURL, options: .mappedIfSafe), hardened: true)
        } else {
            worker = try LocalWorker(hardened: false)
        }
        socket = try Self.openSocket(group: group, ice: self.ice)
        let usableIce = self.ice.filter { $0.endpoint.family == socket.local.family }
        allowed = Set(usableIce.map(\.endpoint))
        try request(["op": "new", "local": socket.local.address, "ssrc": ssrc, "group": group,
                     "relay_only": !group, "ice_servers": usableIce.map(\.request), "conference": encryption != nil,
                     "video_layers": group ? videoLayers.map { ["width": $0.width, "height": $0.height, "fps": $0.fps, "bitrate": $0.bitrate] } : []])
    }

    deinit { stop() }

    private static func openSocket(group: Bool, ice: [RustIceServer]) throws -> RustCallSocket {
        let routes = ice.filter(\.turn).map(\.endpoint)
        if group {
            for address in ["192.0.2.1", "2001:db8::1"] {
                if let endpoint = RustCallEndpoint(address, 9), let socket = try? RustCallSocket(route: endpoint) { return socket }
            }
        } else {
            for route in routes {
                if let socket = try? RustCallSocket(route: route) { return socket }
            }
        }
        throw group ? RustCallMediaError.socket : RustCallMediaError.relayUnavailable
    }

    @discardableResult
    private func request(_ fields: [String: Any]) throws -> Data {
        try submit(JSONSerialization.data(withJSONObject: fields))
    }

    @discardableResult
    private func submit(_ bytes: Data) throws -> Data {
        let reply = try worker.request(bytes)
        let output = try decoder.decode(WorkerResponse.self, from: reply)
        guard output.ok else { throw RustCallMediaError.workerRejected }
        for packet in output.datagrams.prefix(256) {
            if let endpoint = RustCallEndpoint(packet.peer), allowed.contains(endpoint) {
                sentBytes += Int64(socket.send(packet.bytes, to: endpoint))
            }
        }
        for frame in output.audio.prefix(64) where frame.pcm.count == 3840 && (!group || groupLiveSources.contains(frame.ssrc)) {
            if (playback[frame.ssrc]?.count ?? 0) < 3 {
                playback[frame.ssrc, default: []].append(Data(frame.pcm))
            }
        }
        for payload in output.signaling.prefix(64) where payload.count <= 65_536 {
            signaling?(Data(payload))
        }
        for frame in output.video.prefix(4) {
            if let endpoint = endpoints[frame.ssrc] {
                incomingVideo?(endpoint, frame)
            }
        }
        for frame in output.conferenceFrames.prefix(16) {
            guard let encryption, frame.bytes.count <= 1024 * 1024,
                  (0..<frame.bytes.count).contains(frame.clearBytes) else { continue }
            let input = Data(frame.bytes)
            var transformed: Data?
            if frame.encrypt {
                for _ in 0..<(frame.kind == .h264 ? 4 : 1) {
                    guard let cipher = encryption.encrypt(message: input, plaintextPrefixLength: frame.clearBytes) else { break }
                    if frame.kind == .audio || !containsStartCode(cipher, start: max(0, frame.clearBytes - 2)) {
                        transformed = cipher
                        break
                    }
                }
            } else if let peer = peers[frame.ssrc] ?? videoPeers[frame.ssrc] {
                transformed = encryption.decrypt(message: input, userId: peer)
            }
            var request = Data([0x54, 0x47, 0x43, 1, 5])
            var identity = frame.id.littleEndian
            withUnsafeBytes(of: &identity) { request.append(contentsOf: $0) }
            if let transformed, transformed.count <= 1024 * 1024 { request.append(transformed) }
            tolerateRejected { try submit(request) }
        }
        return reply
    }

    private func containsStartCode(_ bytes: Data, start: Int) -> Bool {
        guard start < bytes.count - 2 else { return false }
        return bytes.withUnsafeBytes { (buffer: UnsafeRawBufferPointer) in
            (start..<(buffer.count - 2)).contains { buffer[$0] == 0 && buffer[$0 + 1] == 0 && buffer[$0 + 2] == 1 }
        }
    }

    func startPersonal(key: Data, outgoing: Bool) throws {
        var buffer = Data([0x54, 0x47, 0x43, 1, 1])
        buffer.append(key)
        defer { buffer.resetBytes(in: 0..<buffer.count) }
        try submit(buffer)
        try request(["op": "start_personal", "outgoing": outgoing])
        startPump()
    }

    func joinPayload() throws -> (String, UInt32) {
        struct Join: Decodable { let payload: String }
        let join = try decoder.decode(Join.self, from: request(["op": "group_payload"]))
        return (join.payload, ssrc)
    }

    func connectGroup(_ params: String) throws {
        guard params.utf8.count <= 65_536,
              let response = try JSONSerialization.jsonObject(with: Data(params.utf8)) as? [String: Any],
              let transport = response["transport"] as? [String: Any],
              let candidates = transport["candidates"] as? [[String: Any]], candidates.count <= 64 else {
            throw RustCallMediaError.badTransport
        }
        func number(_ value: Any?) -> UInt16? {
            if let value = value as? String { return UInt16(value) }
            if let value = value as? NSNumber { return UInt16(value.stringValue) }
            return nil
        }
        let endpoints = candidates.compactMap { candidate -> RustCallEndpoint? in
            guard (candidate["protocol"] as? String)?.lowercased() == "udp",
                  number(candidate["component"]) == 1,
                  let host = candidate["ip"] as? String, let port = number(candidate["port"]),
                  let endpoint = RustCallEndpoint(host, port), endpoint.family == socket.local.family else { return nil }
            return endpoint
        }
        guard !endpoints.isEmpty else { throw RustCallMediaError.badTransport }
        allowed = Set(endpoints)
        struct GroupAnswer: Decodable { let payload: String }
        let answer = try decoder.decode(GroupAnswer.self, from: request(["op": "group_connect", "params": params]))
        videoNegotiated = answer.payload.split(separator: "\r\n").contains { line in
            line.hasPrefix("m=video ") && !line.hasPrefix("m=video 0 ")
        }
        startPump()
    }

    func addSources(_ sources: [UInt32]) throws {
        let next = Set(sources.filter { $0 != 0 && $0 != ssrc }).subtracting(groupLiveSources)
        guard !next.isEmpty else { return }
        try request(["op": "group_sources", "ssrcs": next.sorted()])
        groupLiveSources.formUnion(next)
    }

    func setConferencePeers(_ mapping: [UInt32: Int64]) {
        peers = mapping.filter { $0.key != 0 && $0.value != 0 }
    }

    func requestVideo(_ channels: [OngoingGroupCallContext.VideoChannel]) throws {
        guard videoNegotiated, !videoLayers.isEmpty else { return }
        var endpoints: [UInt32: String] = [:]
        var users: [UInt32: Int64] = [:]
        var subscriptions: [[String: Any]] = []
        func height(_ quality: OngoingGroupCallContext.VideoChannel.Quality) -> Int {
            switch quality {
            case .thumbnail: return 180
            case .medium: return 360
            case .full: return 720
            }
        }
        for channel in channels.prefix(4) {
            let fid = channel.ssrcGroups.filter { $0.semantics == "FID" && $0.ssrcs.count == 2 }
            let primary = channel.ssrcGroups.first(where: { $0.semantics == "SIM" })?.ssrcs ?? fid.map { $0.ssrcs[0] }
            var sources: [[String: Any]] = []
            for source in primary.prefix(3) where source != 0 {
                var spec: [String: Any] = ["ssrc": source]
                if let secondary = fid.first(where: { $0.ssrcs[0] == source })?.ssrcs[1] { spec["rtx"] = secondary }
                sources.append(spec)
                endpoints[source] = channel.endpointId
                users[source] = channel.peerId
            }
            if !sources.isEmpty {
                subscriptions.append(["endpoint": channel.endpointId, "sources": sources,
                                      "min_height": height(channel.minQuality), "max_height": height(channel.maxQuality)])
            }
        }
        try request(["op": "group_video", "subscriptions": subscriptions])
        videoPeers = users
        self.endpoints = endpoints
    }

    func sendVideo(_ frame: OngoingGroupCallContext.VideoFrameData) {
        guard !closed, connected, videoNegotiated, let format = videoLayers.last else { return }
        let now = DispatchTime.now().uptimeNanoseconds
        let interval = 1_000_000_000 / UInt64(format.fps)
        guard now &- lastVideo >= interval,
              let i420 = RustCallVideo.prepare(frame, width: format.width, height: format.height) else { return }
        lastVideo = now
        var input = Data([0x54, 0x47, 0x43, 1, 4])
        input.append(i420)
        tolerateRejected { try submit(input) }
    }

    func removeSources(_ sources: [UInt32]) {
        groupLiveSources.subtract(sources)
        for source in sources {
            playback.removeValue(forKey: source)
            sourceVolume.removeValue(forKey: source)
            peers.removeValue(forKey: source)
        }
    }

    func setVolume(ssrc: UInt32, volume: Double) {
        guard volume.isFinite, groupLiveSources.contains(ssrc) else { return }
        sourceVolume[ssrc] = min(2.0, max(0, volume))
    }

    func receiveSignaling(_ packet: Data) {
        guard !closed, !packet.isEmpty, packet.count <= 65_536 else { return }
        tolerateRejected { try request(["op": "signaling", "packet": Array(packet)]) }
    }

    func setMuted(_ muted: Bool) {
        self.muted = muted
        updateMedia()
    }

    func setLowBattery(_ low: Bool) {
        lowBattery = low
        updateMedia()
    }

    func setNoiseSuppression(_ enabled: Bool) {
        noiseSuppression = enabled
        captureFormat = nil
    }

    private func updateMedia() {
        guard !closed else { return }
        perform { try request(["op": "media_state", "state": ["muted": muted, "lowBattery": lowBattery]]) }
    }

    func setAudioActive(_ active: Bool) {
        audioActive = active
        if !active { playback.removeAll(keepingCapacity: true) }
        audio?.setCallKitActive(active)
    }

    func sendExternalAudio(_ data: Data) {
        guard !closed, connected, !muted, data.count == 3840 else { return }
        perform { try request(["op": "send_audio", "pcm": Array(data)]) }
    }

    private func startPump() {
        guard timer == nil else { return }
        startReader()
        if !presentation {
            let audio = TGCallsIOSAudioDevice(queue: queue, manageSessionActivation: false, capture: { [weak self] pcm, rate, channels, delay in
            self?.onCapture(pcm, rate, channels, delay)
        }, render: { [weak self] pcm in
            self?.onRender(pcm)
        }, failure: { [weak self] _ in self?.fail() })
            self.audio = audio
            perform { try audio.start() }
            guard !closed else { return }
            audio.setCallKitActive(audioActive)
            guard !closed else { return }
        }
        let timer = DispatchSource.makeTimerSource(queue: queue)
        timer.schedule(deadline: .now(), repeating: .milliseconds(10), leeway: .milliseconds(1))
        timer.setEventHandler { [weak self] in self?.pump() }
        self.timer = timer
        timer.resume()
        let paths = NWPathMonitor()
        paths.pathUpdateHandler = { [weak self] path in self?.updatePath(path) }
        self.paths = paths
        paths.start(queue: queue)
    }

    private func startReader() {
        socket.start(queue: queue) { [weak self] endpoint, datagram in
            guard let self, !self.closed, self.allowed.contains(endpoint) else { return }
            self.receivedBytes += Int64(datagram.count)
            self.tolerateRejected { try self.request(["op": "packet", "peer": endpoint.address, "bytes": Array(datagram)]) }
        }
    }

    private func updatePath(_ next: NWPath) {
        defer { path = next }
        guard !closed, let path, path != next, next.status == .satisfied, hasConnected else { return }
        if group {
            networkChanged?()
        } else {
            perform {
                let rebound = try Self.openSocket(group: false, ice: ice.filter { $0.endpoint.family == socket.local.family })
                let previous = socket
                socket = rebound
                do { try request(["op": "rebind_personal", "local": rebound.local.address]) }
                catch { socket = previous; throw error }
                startReader()
            }
        }
    }

    private func pump() {
        guard !closed else { return }
        struct Tick: Decodable {
            struct Status: Decodable {
                struct Media: Decodable { let muted: Bool; let lowBattery: Bool }
                let connection_state: String
                let remote_media: Media
            }
            let payload: Status
        }
        perform {
            let status = try decoder.decode(Tick.self, from: request(["op": "tick"])).payload
            let state: OngoingCallContextState.State
            switch status.connection_state.lowercased() {
            case "connected": state = .connected
            case "failed", "closed": state = .failed
            default: state = hasConnected ? .reconnecting : .initializing
            }
            connected = state == .connected
            hasConnected = hasConnected || connected
            stateChanged?(state, status.remote_media.muted, status.remote_media.lowBattery)
            guard !closed else { return }
            if state == .failed {
                stop()
                return
            }
            if !group, tick % 2 == 0 { try request(["op": "poll_signaling"]) }
            if tick % 2 == 0 { playFrame() }
            tick = (tick + 1) % 100
        }
    }

    private func playFrame() {
        guard audioActive else {
            playback.removeAll(keepingCapacity: true)
            return
        }
        var mixed = [Int32](repeating: 0, count: 1920)
        var measured: [(UInt32, Float, Bool)] = []
        for ssrc in Array(playback.keys) {
            guard var fifo = playback.removeValue(forKey: ssrc), !fifo.isEmpty else { continue }
            let frame = fifo.removeFirst()
            if !fifo.isEmpty { playback[ssrc] = fifo }
            var peak: Int32 = 0
            let volume = sourceVolume[ssrc] ?? 1.0
            frame.withUnsafeBytes { (pcm: UnsafeRawBufferPointer) in
                for i in mixed.indices {
                    let bits = UInt16(pcm[2 * i]) | UInt16(pcm[2 * i + 1]) << 8
                    let value = Int32(Int16(bitPattern: bits))
                    mixed[i] += Int32(Double(value) * volume)
                    peak = max(peak, abs(value))
                }
            }
            measured.append((ssrc, Float(peak) / 32768, peak > 700))
        }
        guard !measured.isEmpty else { return }
        let pcm = mixed.map { Int16(clamping: $0).littleEndian }
        _ = pcm.withUnsafeBytes { audio?.enqueuePlayback(Data($0)) }
        levels?(measured)
    }

    private func onCapture(_ pcm: Data, _ rate: UInt32, _ channels: UInt16, _ delay: UInt16) {
        guard !closed, connected else { return }
        perform {
            if captureFormat?.0 != rate || captureFormat?.1 != channels {
                try request(["op": "configure_audio", "capture_rate": rate, "capture_channels": channels,
                             "render_rate": 48_000, "render_channels": 2, "options": [
                                "echo_cancellation": true, "noise_suppression": noiseSuppression, "automatic_gain": true,
                             ]])
                captureFormat = (rate, channels)
            }
            var input = Data([0x54, 0x47, 0x43, 1, 3, UInt8(truncatingIfNeeded: delay), UInt8(delay >> 8)])
            input.append(pcm)
            try submit(input)
        }
    }

    private func onRender(_ pcm: Data) {
        guard !closed, captureFormat != nil else { return }
        perform {
            var input = Data([0x54, 0x47, 0x43, 1, 2])
            input.append(pcm)
            try submit(input)
        }
    }

    private func tolerateRejected(_ action: () throws -> Data) {
        do { _ = try action() }
        catch RustCallMediaError.workerRejected { }
        catch { fail() }
    }

    private func perform(_ action: () throws -> Void) {
        do { try action() }
        catch { fail() }
    }

    private func fail() {
        guard !closed else { return }
        stop()
        stateChanged?(.failed, false, false)
    }

    @discardableResult
    func stop() -> (sent: Int64, received: Int64) {
        closed = true
        paths?.cancel()
        paths = nil
        timer?.cancel()
        timer = nil
        audio?.stop()
        audio = nil
        socket.stop()
        allowed.removeAll()
        playback.removeAll()
        return (sentBytes, receivedBytes)
    }
}
#endif
