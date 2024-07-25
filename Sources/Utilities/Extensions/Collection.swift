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

    func count(where condition: (Element) -> Bool) -> Int {
        var t = 0

        for e in self {
            if condition(e) {
                t += 1
            }
        }

        return t
    }

    func grouped(by keyPath: KeyPath<Element, some Hashable>) -> [[Element]] {
        grouping(by: keyPath)
            .values
            .asArray
    }

    func grouping<Value: Hashable>(by keyPath: KeyPath<Element, Value>) -> [Value: [Element]] {
        Dictionary(grouping: self, by: { $0[keyPath: keyPath] })
    }
    
    func max(using keyPath: KeyPath<Element, some Comparable>) -> Element? {
        self.max(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })
    }
    
    func min(using keyPath: KeyPath<Element, some Comparable>) -> Element? {
        self.min(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })
    }
    
    func filter<Value: Equatable>(by keyPath: KeyPath<Element, Value>, against other: [Element]) -> [Element] {
        filter { x in
            other.contains(where: { x[keyPath: keyPath] == $0[keyPath: keyPath] })
        }
    }
}

public extension Collection where Element: Comparable {

    // TODO: move to swift-algorithms implementation
    func max(_ amount: Int = 1) -> [Element] {
        sorted()[(count - amount)...]
            .asArray
    }
}

public extension Collection where Element: Equatable {

    func differences(against other: some Collection<Element>) -> Int {
        let z = zip(self, other).asArray
        var t = Swift.max(count, other.count) - z.count

        t += z.count(where: { $0 != $1 })

        return t
    }

    func split(on boundary: Element) -> [SubSequence] {
        split(omittingEmptySubsequences: true, whereSeparator: { $0 == boundary })
    }
    
    func filter(against other: [Element]) -> [Element] {
        filter { x in
            other.contains(where: { x == $0 })
        }
    }
}

public extension Collection where Element: Hashable {

    func grouped() -> [[Element]] {
        grouping(by: \.self)
            .values
            .asArray
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
