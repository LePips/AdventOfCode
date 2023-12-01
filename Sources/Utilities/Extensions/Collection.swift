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
        let sorted = sorted()
        
        return Array(sorted[(count - amount)..<count])
    }
}

public extension Collection where Element: Equatable {
    
    func split(on boundary: Element) -> Array<SubSequence> {
        split(omittingEmptySubsequences: true, whereSeparator: { $0 == boundary })
    }
}

public extension Collection where Element: Hashable {
    
    var asSet: Set<Element> {
        Set(self)
    }
}

public extension Collection where Element == Int {
    
    func sum() -> Int {
        reduce(0, +)
    }
}

public extension Collection where Element: StringProtocol {
    
    var asInts: Array<Int> {
        compactMap { Int($0) }
    }
    
    var asStrings: Array<String> {
        compactMap { String($0) }
    }
}

public extension Collection where Element: Collection, Element.Element: Hashable {
    
    func intersectingElements() -> Set<Element.Element> {
        guard let f = first else { return [] }
        var final = Set(f)
        dropFirst().forEach { final.formIntersection($0) }
        return final
    }
}
