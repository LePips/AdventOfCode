public extension Array {

    func appending(_ element: Element) -> Self {
        self + [element]
    }

    func appending(_ element: Element, if condition: Bool) -> Self {
        if condition {
            return self + [element]
        } else {
            return self
        }
    }

    func appending(_ contents: [Element]) -> Self {
        self + contents
    }

    func prepending(_ element: Element) -> Self {
        [element] + self
    }

    func poppingLast(_ k: Int = 1) -> Self {
        guard k >= 1 else { fatalError("Array.poppingLast: k must be >= 1") }
        var copy = self

        return (0 ..< k)
            .compactMap { _ in copy.popLast() }
    }

    func removingFirst(_ k: Int = 1) -> Self {
        guard k >= 1 else { fatalError("Array.removingFirst: k must be >= 1") }
        var copy = self
        copy.removeFirst(Swift.max(0, Swift.min(k, count - 1)))
        return copy
    }

    func removingLast(_ k: Int = 1) -> Self {
        guard k >= 1 else { fatalError("Array.removingLast: k must be >= 1") }
        var copy = self
        copy.removeLast(Swift.min(k, count - 1))
        return copy
    }
}

public extension [Bool] {

    func areAllTrue() -> Bool {
        allSatisfy { $0 }
    }

    func areAllFalse() -> Bool {
        allSatisfy { !$0 }
    }
}

public extension [String] {

    func trimmed() -> Self {
        var copy = self
        copy.trim(while: { $0.isEmpty })
        return copy
    }
}
