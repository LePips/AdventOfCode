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
    
    func poppingLast(_ k: Int) -> Self {
        var copy = self
        
        return (0..<k)
            .compactMap { _ in copy.popLast() }
    }
    
    func removingFirst(_ k: Int = 1) -> Self {
        var copy = self
        copy.removeFirst(Swift.min(k, count - 1))
        return copy
    }
    
    func removingLast(_ k: Int = 1) -> Self {
        var copy = self
        copy.removeLast(Swift.min(k, count - 1))
        return copy
    }
}
