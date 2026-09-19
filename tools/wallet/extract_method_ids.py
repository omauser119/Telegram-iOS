#!/usr/bin/env python3
"""Inspect wallet serializers in Telegram macOS 12.10.283233 (x86_64).

Read-only; outputs evidence, not an authoritative complete TL schema.
Swift large string LEA targets point 32 bytes before C-string contents.
"""
import argparse
import json
import re
import struct
import zipfile
from pathlib import Path


def extract(path):
    if zipfile.is_zipfile(path):
        with zipfile.ZipFile(path) as archive:
            name = next(n for n in archive.namelist() if n.endswith('/Contents/MacOS/Telegram'))
            data = archive.read(name)
    else:
        data = Path(path).read_bytes()
    if data[:4] == bytes.fromhex('cafebabe'):
        for i in range(struct.unpack_from('>I', data, 4)[0]):
            cpu, _, offset, size, _ = struct.unpack_from('>IIIII', data, 8 + i * 20)
            if cpu == 0x1000007:
                data = data[offset:offset + size]
                break
    if data[:4] != bytes.fromhex('cffaedfe'):
        raise ValueError('Expected x86_64 Mach-O or universal archive')
    # This build's __TEXT vmaddr-fileoff delta is constant. Limit scanning
    # to __text, using its actual Mach-O section boundaries.
    command_offset = 32
    text_offset = text_size = None
    for _ in range(struct.unpack_from('<I', data, 16)[0]):
        command, size = struct.unpack_from('<II', data, command_offset)
        if command == 0x19:
            nsects = struct.unpack_from('<I', data, command_offset + 64)[0]
            for i in range(nsects):
                section = command_offset + 72 + i * 80
                if data[section:section + 16].rstrip(b'\0') == b'__text':
                    text_size = struct.unpack_from('<Q', data, section + 40)[0]
                    text_offset = struct.unpack_from('<I', data, section + 48)[0]
        command_offset += size
    if text_offset is None:
        raise ValueError('Missing __text')
    names = {m.start() - 32: m.group().rstrip(b'\0').decode()
             for m in re.finditer(rb'(?:wallet|toncenter)\.[A-Za-z]+\x00', data)
             if b'passcodeCredentialManaged' not in m.group()}
    rows = []
    code = data[text_offset:text_offset + text_size]
    for match in re.finditer(rb'[\x48\x4c]\x8d[\x05\x0d\x15\x1d\x25\x2d\x35\x3d]', code):
        position = text_offset + match.start()
        target = position + 7 + struct.unpack_from('<i', data, position + 3)[0]
        if target not in names:
            continue
        start = data.rfind(b'\x55\x48\x89\xe5', max(text_offset, position - 8192), position)
        if start < 0:
            continue
        candidates = []
        for immediate in re.finditer(rb'\xc7(?:\x45.|\x85....)(....)', data[start:position], re.S):
            value = struct.unpack('<I', immediate.group(1))[0]
            if value > 0xffff and value != 0x1cb5c415:
                candidates.append({'id': f'0x{value:08x}', 'file_offset': hex(start + immediate.start())})
        rows.append({'method': names[target], 'function_offset': hex(start),
                     'string_reference_offset': hex(position), 'candidates': candidates,
                     'note': 'Verify serialization order; later constants can be nested types.'})
    return rows


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('binary_or_zip')
    args = parser.parse_args()
    print(json.dumps(extract(args.binary_or_zip), indent=2))
