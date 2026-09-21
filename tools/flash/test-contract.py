#!/usr/bin/env python3
"""Run real Flash serializers/readers and mosaic code with Swift on Linux.
Only the standard InputPeerSelf constructor is stubbed (the custom wire code is not).
Linux-only Foundation/C pointer adaptations apply to a temporary Buffer.swift copy.
"""
from pathlib import Path
import subprocess
import tempfile

root = Path(__file__).resolve().parents[2]
api = root / 'submodules/TelegramApi/Sources'
with tempfile.TemporaryDirectory(prefix='flash-contract-') as temp:
    target = Path(temp)
    buffer = (api / 'Buffer.swift').read_text().replace('NSMutableString()', 'NSMutableString(capacity: 0)')
    buffer = buffer.replace('hexString.appendFormat("%02x", UInt(bytes.advanced(by: i).pointee))', 'hexString.append(String(format: "%02x", UInt(bytes.advanced(by: i).pointee)))')
    buffer = buffer.replace('memcpy(self.data?.advanced(by: Int(self._size)), bytes, Int(length))', 'if length > 0 { memcpy(self.data!.advanced(by: Int(self._size)), bytes, Int(length)) }')
    buffer = buffer.replace('memcpy(self.data?.advanced(by: Int(self._size)), buffer.data, Int(buffer._size))', 'if buffer._size > 0 { memcpy(self.data!.advanced(by: Int(self._size)), buffer.data!, Int(buffer._size)) }')
    (target / 'Buffer.swift').write_text(buffer)
    (target / 'Reader.swift').write_text((api / 'WalletResponseReader.swift').read_text().split('public extension WalletMTProto')[0])
    for name in ['DeserializeFunctionResponse.swift', 'FlashGiftCollections.swift']:
        (target / name).write_text((api / name).read_text())
    (target / 'Mosaic.swift').write_text((root / 'submodules/TelegramUI/Components/PeerInfo/PeerInfoVisualMediaPaneNode/Sources/FlashGiftMosaicLayout.swift').read_text())
    (target / 'Tests.swift').write_text((root / 'tools/flash/test-contract.swift').read_text())
    (target / 'ApiStub.swift').write_text('''public enum Api {
    public enum InputPeer {
        case inputPeerSelf
        public func serialize(_ buffer: Buffer, _ boxed: Bool) {
            if boxed { buffer.appendInt32(Int32(bitPattern: 0x7da07ec9)) }
        }
    }
    public static func parse(_ reader: BufferReader, signature: Int32) -> Any? { nil }
}
''')
    subprocess.run(['docker', 'run', '--rm', '-v', f'{target}:/test', '-w', '/test', 'swift:6.2', 'bash', '-c', 'swiftc -swift-version 5 *.swift -o /tmp/tests && /tmp/tests'], check=True)
