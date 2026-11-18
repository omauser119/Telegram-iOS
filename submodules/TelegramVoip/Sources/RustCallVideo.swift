#if os(iOS) && TGCALLS_RUST
import CoreVideo
import Foundation
import TgCallsRust

enum RustCallVideo {
    static func layers(presentation: Bool, conference: Bool) -> [VideoConfig] {
        let high = VideoConfig(width: 640, height: 384, fps: 15, bitrate: 600_000)
        let medium = VideoConfig(width: 320, height: 192, fps: 15, bitrate: 220_000)
        if conference { return [high] }
        if presentation { return [medium, high] }
        return [VideoConfig(width: 160, height: 96, fps: 15, bitrate: 70_000), medium, high]
    }

    static func prepare(_ frame: OngoingGroupCallContext.VideoFrameData, width: Int, height: Int) -> Data? {
        guard frame.width > 0, frame.height > 0, frame.width <= 4096, frame.height <= 4096 else { return nil }
        let ySize = width * height
        var result = Data(count: ySize * 3 / 2)
        let valid = result.withUnsafeMutableBytes { (destination: UnsafeMutableRawBufferPointer) -> Bool in
            switch frame.buffer {
            case let .i420(buffer):
                return buffer.y.withUnsafeBytes { (y: UnsafeRawBufferPointer) in
                    buffer.u.withUnsafeBytes { (u: UnsafeRawBufferPointer) in
                        buffer.v.withUnsafeBytes { (v: UnsafeRawBufferPointer) in
                            copy(y, stride: buffer.strideY, step: 1, iw: frame.width, ih: frame.height, into: destination, at: 0, ow: width, oh: height)
                            && copy(u, stride: buffer.strideU, step: 1, iw: frame.width / 2, ih: frame.height / 2, into: destination, at: ySize, ow: width / 2, oh: height / 2)
                            && copy(v, stride: buffer.strideV, step: 1, iw: frame.width / 2, ih: frame.height / 2, into: destination, at: ySize * 5 / 4, ow: width / 2, oh: height / 2)
                        }
                    }
                }
            case let .nv12(buffer):
                return buffer.y.withUnsafeBytes { (y: UnsafeRawBufferPointer) in
                    buffer.uv.withUnsafeBytes { (uv: UnsafeRawBufferPointer) in
                        copy(y, stride: buffer.strideY, step: 1, iw: frame.width, ih: frame.height, into: destination, at: 0, ow: width, oh: height)
                        && copyUV(uv, stride: buffer.strideUV, iw: frame.width, ih: frame.height, into: destination, ow: width, oh: height)
                    }
                }
            case let .native(buffer), let .argb(buffer), let .bgra(buffer):
                return copyPixelBuffer(buffer.pixelBuffer, to: destination, width: width, height: height)
            }
        }
        return valid ? result : nil
    }

    private static func copy(_ source: UnsafeRawBufferPointer, stride: Int, step: Int, iw: Int, ih: Int,
                             into destination: UnsafeMutableRawBufferPointer, at offset: Int, ow: Int, oh: Int) -> Bool {
        guard iw > 0, ih > 0, stride >= iw * step, stride <= source.count,
              (ih - 1) * stride + (iw - 1) * step < source.count else { return false }
        for y in 0..<oh {
            let row = y * ih / oh * stride
            for x in 0..<ow {
                destination[offset + y * ow + x] = source[row + x * iw / ow * step]
            }
        }
        return true
    }

    private static func copyUV(_ source: UnsafeRawBufferPointer, stride: Int, iw: Int, ih: Int,
                               into destination: UnsafeMutableRawBufferPointer, ow: Int, oh: Int) -> Bool {
        guard source.count >= 2 else { return false }
        let v = UnsafeRawBufferPointer(rebasing: source.dropFirst())
        return copy(source, stride: stride, step: 2, iw: iw / 2, ih: ih / 2, into: destination, at: ow * oh, ow: ow / 2, oh: oh / 2)
            && copy(v, stride: stride, step: 2, iw: iw / 2, ih: ih / 2, into: destination, at: ow * oh * 5 / 4, ow: ow / 2, oh: oh / 2)
    }

    private static func copyPixelBuffer(_ pixel: CVPixelBuffer, to destination: UnsafeMutableRawBufferPointer,
                                        width: Int, height: Int) -> Bool {
        let iw = CVPixelBufferGetWidth(pixel), ih = CVPixelBufferGetHeight(pixel)
        guard iw > 0, ih > 0, iw <= 4096, ih <= 4096, CVPixelBufferLockBaseAddress(pixel, .readOnly) == kCVReturnSuccess else { return false }
        defer { CVPixelBufferUnlockBaseAddress(pixel, .readOnly) }
        if CVPixelBufferGetPlaneCount(pixel) == 2,
           let y = CVPixelBufferGetBaseAddressOfPlane(pixel, 0), let uv = CVPixelBufferGetBaseAddressOfPlane(pixel, 1) {
            let yStride = CVPixelBufferGetBytesPerRowOfPlane(pixel, 0)
            let uvStride = CVPixelBufferGetBytesPerRowOfPlane(pixel, 1)
            return copy(UnsafeRawBufferPointer(start: y, count: yStride * CVPixelBufferGetHeightOfPlane(pixel, 0)),
                        stride: yStride, step: 1, iw: iw, ih: ih, into: destination, at: 0, ow: width, oh: height)
                && copyUV(UnsafeRawBufferPointer(start: uv, count: uvStride * CVPixelBufferGetHeightOfPlane(pixel, 1)),
                          stride: uvStride, iw: iw, ih: ih, into: destination, ow: width, oh: height)
        }
        let format = CVPixelBufferGetPixelFormatType(pixel)
        guard format == kCVPixelFormatType_32BGRA || format == kCVPixelFormatType_32ARGB,
              let address = CVPixelBufferGetBaseAddress(pixel) else { return false }
        let stride = CVPixelBufferGetBytesPerRow(pixel)
        guard stride >= iw * 4 else { return false }
        let bytes = UnsafeRawBufferPointer(start: address, count: stride * ih)
        let bgra = format == kCVPixelFormatType_32BGRA
        let ySize = width * height
        for y in 0..<height {
            for x in 0..<width {
                let at = y * ih / height * stride + x * iw / width * 4
                let r = Int(bytes[at + (bgra ? 2 : 1)])
                let g = Int(bytes[at + (bgra ? 1 : 2)])
                let b = Int(bytes[at + (bgra ? 0 : 3)])
                destination[y * width + x] = UInt8(clamping: 16 + (66 * r + 129 * g + 25 * b + 128) / 256)
                if y % 2 == 0 && x % 2 == 0 {
                    let chroma = (y / 2) * (width / 2) + x / 2
                    destination[ySize + chroma] = UInt8(clamping: 128 + (-38 * r - 74 * g + 112 * b + 128) / 256)
                    destination[ySize * 5 / 4 + chroma] = UInt8(clamping: 128 + (112 * r - 94 * g - 18 * b + 128) / 256)
                }
            }
        }
        return true
    }

    static func pixelBuffer(_ frame: TgCallsRust.VideoFrame) -> CVPixelBuffer? {
        let width = frame.width, height = frame.height
        guard (16...1280).contains(width), (16...720).contains(height), width % 2 == 0, height % 2 == 0,
              frame.i420.count == width * height * 3 / 2 else { return nil }
        var output: CVPixelBuffer?
        let attributes = [kCVPixelBufferIOSurfacePropertiesKey: [:]] as CFDictionary
        guard CVPixelBufferCreate(kCFAllocatorDefault, width, height, kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange, attributes, &output) == kCVReturnSuccess,
              let output, CVPixelBufferLockBaseAddress(output, []) == kCVReturnSuccess else { return nil }
        defer { CVPixelBufferUnlockBaseAddress(output, []) }
        guard let y = CVPixelBufferGetBaseAddressOfPlane(output, 0), let uv = CVPixelBufferGetBaseAddressOfPlane(output, 1) else { return nil }
        let yStride = CVPixelBufferGetBytesPerRowOfPlane(output, 0)
        let uvStride = CVPixelBufferGetBytesPerRowOfPlane(output, 1)
        let ySize = width * height
        frame.i420.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) in
            guard let base = bytes.baseAddress else { return }
            for row in 0..<height { y.advanced(by: row * yStride).copyMemory(from: base.advanced(by: row * width), byteCount: width) }
            let chroma = uv.assumingMemoryBound(to: UInt8.self)
            for row in 0..<height / 2 {
                for column in 0..<width / 2 {
                    let source = row * width / 2 + column
                    chroma[row * uvStride + 2 * column] = bytes[ySize + source]
                    chroma[row * uvStride + 2 * column + 1] = bytes[ySize * 5 / 4 + source]
                }
            }
        }
        return output
    }
}
#endif
