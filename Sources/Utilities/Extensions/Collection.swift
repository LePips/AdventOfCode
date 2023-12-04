public extension Collection {
    
    var asArray: Array<Element> {
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
    
    func split(on boundary: Element) -> Array<SubSequence> {
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
