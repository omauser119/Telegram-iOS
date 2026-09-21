import Foundation

// A three-column mosaic: the leading expanded gift is 2x2; subsequent
// expanded gifts are 2x1, leaving compact gifts to fill the remaining cells.
func flashGiftMosaicFrames(expanded: [Bool], width: CGFloat, columns: Int, spacing: CGFloat, origin: CGPoint) -> [CGRect] {
    let columns = max(1, columns)
    let cell = max(1.0, (width - CGFloat(columns - 1) * spacing) / CGFloat(columns))
    var occupied = Set<Int>()
    var frames: [CGRect] = []
    for (index, large) in expanded.enumerated() {
        let spanX = large ? min(2, columns) : 1
        let spanY = large && index == 0 && columns >= 3 ? 2 : 1
        var position = 0
        while true {
            let row = position / columns
            let column = position % columns
            if column + spanX <= columns && (0..<spanY).allSatisfy({ dy in
                (0..<spanX).allSatisfy { dx in !occupied.contains((row + dy) * columns + column + dx) }
            }) {
                for dy in 0..<spanY {
                    for dx in 0..<spanX { occupied.insert((row + dy) * columns + column + dx) }
                }
                frames.append(CGRect(x: origin.x + CGFloat(column) * (cell + spacing), y: origin.y + CGFloat(row) * (cell + spacing), width: CGFloat(spanX) * cell + CGFloat(spanX - 1) * spacing, height: CGFloat(spanY) * cell + CGFloat(spanY - 1) * spacing))
                break
            }
            position += 1
        }
    }
    return frames
}
