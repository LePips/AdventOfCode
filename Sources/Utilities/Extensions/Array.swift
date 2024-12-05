public extension Array {

    func multiplied(by amount: Int, separator: Element? = nil) -> Self {
        guard amount > 1 else { return self }

        if let separator {
            return self + [separator] + multiplied(by: amount - 1, separator: separator)
        } else {
            return self + multiplied(by: amount - 1, separator: separator)
        }
    }

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

    // TODO: change to preconditions
    func poppingLast(_ k: Int = 1) -> Self {
        guard k >= 1 else { fatalError("Array.poppingLast: k must be >= 1") }
        var copy = self

        return (0 ..< k)
            .compactMap { _ in copy.popLast() }
    }

    func removingFirst(_ k: Int = 1) -> Self {
        guard k >= 1 else { fatalError("Array.removingFirst: k must be >= 1") }
        var copy = self
        copy.removeFirst(k)
        return copy
    }

    func removingLast(_ k: Int = 1) -> Self {
        guard k >= 1 else { fatalError("Array.removingLast: k must be >= 1") }
        var copy = self
        copy.removeLast(Swift.min(k, count - 1))
        return copy
    }
}

public extension [String] {

    func trimmed() -> Self {
        var copy = self
        copy.trim(while: { $0.isEmpty })
        return copy
    }
}

public extension Array where Element: RandomAccessCollection, Element: Equatable {
    
    func split(on: Element) -> [[Element]] {
        var result: [[Element]] = []
        var current: [Element] = []
        
        for element in self {
            if element == on {
                result.append(current)
                current = []
            } else {
                current.append(element)
            }
        }
        
        result.append(current)
        
        return result
    }
}
