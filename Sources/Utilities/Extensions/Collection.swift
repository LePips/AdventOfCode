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

    func grouped(by keyPath: KeyPath<Element, some Hashable>) -> [[Element]] {
        grouping(by: keyPath)
            .values
            .asArray
    }

    func grouping<Value: Hashable>(by keyPath: KeyPath<Element, Value>) -> [Value: [Element]] {
        Dictionary(grouping: self, by: { $0[keyPath: keyPath] })
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

    func split(on boundary: Element) -> [SubSequence] {
        split(omittingEmptySubsequences: true, whereSeparator: { $0 == boundary })
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
