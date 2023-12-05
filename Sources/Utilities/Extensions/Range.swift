public extension ClosedRange {

    func intersects(_ other: Self) -> Bool {
        contains(other.lowerBound) || other.contains(lowerBound)
    }
}

public extension ClosedRange where Bound == Int {

    init(start: Int, length: Int) {
        precondition(length > 0)

        self.init(
            uncheckedBounds: (
                lower: start,
                upper: start + length - 1
            )
        )
    }
}

public extension NSRange {

    var asClosedRange: ClosedRange<Int> {
        lowerBound ... upperBound - 1
    }
}

public extension Range {

    func isSupersetOf(_ other: Self) -> Bool {
        other.clamped(to: self) == other
    }

    func intersects(_ other: Self) -> Bool {
        contains(other.lowerBound) || other.contains(lowerBound)
    }
}
