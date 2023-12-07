public extension ClosedRange {}

public extension ClosedRange where Bound: Strideable, Bound.Stride == Int {

    func contains(_ other: some Collection<Bound>) -> Bool {
        guard var current = other.first, contains(current) else { return false }
        guard other.count > 1 else { return true }

        var currentIndex = other.startIndex

        for _ in 1 ..< other.count {
            currentIndex = other.index(after: currentIndex)
            current = current.advanced(by: 1)

            if !contains(current) || other[currentIndex] != current {
                return false
            }
        }

        return true
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

    /// Returns subranges of self that do or don't overlap against another range
    func ranges(against other: ClosedRange) -> (nonOverlapping: [Self], overlapping: [Self]) {

        var nonOverlapping: [Self] = []
        var overlapping: [Self] = []

        var current = self

        if lowerBound < other.lowerBound {
            let length = Swift.min(
                current.count,
                other.lowerBound - lowerBound
            )

            let preNonOverlapping = ClosedRange(start: current.lowerBound, length: length)

            nonOverlapping.append(preNonOverlapping)

            let newLength = current.count - length

            if newLength <= 0 {
                return (nonOverlapping, overlapping)
            } else {
                current = .init(start: other.lowerBound, length: newLength)
            }
        }

        if current.lowerBound < other.upperBound {
            let length = Swift.min(
                current.count,
                other.upperBound - current.lowerBound + 1
            )

            let overlappingRange = ClosedRange(start: other.lowerBound, length: length)

            overlapping.append(overlappingRange)

            let newLength = current.count - length

            if newLength <= 0 {
                return (nonOverlapping, overlapping)
            } else {
                current = .init(start: other.upperBound, length: newLength)
            }
        }

        nonOverlapping.append(current)

        return (nonOverlapping, overlapping)
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
}
