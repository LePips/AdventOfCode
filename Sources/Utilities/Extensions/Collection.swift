public extension Collection {

    var asArray: [Element] {
        Array(self)
    }

    var isNotEmpty: Bool {
        !isEmpty
    }

    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

public extension Collection where Element: Comparable {

    func max(_ amount: Int = 1) -> [Element] {
        sorted()[(count - amount) ..< count]
            .asArray
    }
}

public extension Collection where Element: Equatable {

    func split(on boundary: Element) -> [SubSequence] {
        split(omittingEmptySubsequences: true, whereSeparator: { $0 == boundary })
    }
}

public extension Collection where Element: Collection, Element.Element: Hashable {

    /// Find the intersecting elements between Collection elements
    func intersectingElements() -> Set<Element.Element> {
        guard let f = first else { return [] }
        var final = Set(f)
        dropFirst().forEach { final.formIntersection($0) }
        return final
    }
}

public extension Collection<ClosedRange<Int>> {

    /// Assumes that ranges in `self` and `other` are non-overlapping
    func combined(with other: some Collection<ClosedRange<Int>>) -> [ClosedRange<Int>] {
        let sorted = sorted(using: \.lowerBound)
        let other = other.sorted(using: \.lowerBound)

        var t: Set<ClosedRange<Int>> = []

        for range in sorted {

            // make mutable
            var range = range

            for otherRange in other {

                // not overlapping
                if range.upperBound < otherRange.lowerBound {
                    t.insert(range)
                    break
                }

                if range.lowerBound < otherRange.lowerBound && range.upperBound >= otherRange.lowerBound {
                    let l = range.lowerBound ... otherRange.lowerBound - range.lowerBound - 1
                    t.insert(l)
                    range = otherRange.lowerBound - range.lowerBound ... range.upperBound
                }

                if otherRange.lowerBound >= range.lowerBound {
                    let upperBound = Swift.min(range.upperBound, otherRange.upperBound)
                    let remainingBound = Swift.max(range.upperBound, otherRange.upperBound)
                    let l = range.lowerBound ... upperBound
                    t.insert(l)
                    range = upperBound + 1 ... remainingBound
                }
            }
        }

        return t.sorted(using: \.lowerBound)
    }
}
