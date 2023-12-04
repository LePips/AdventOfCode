extension Sequence {
    
    var asArray: [Element] {
        Array(self)
    }
}

public extension Sequence where Element: Hashable {
    
    var asSet: Set<Element> {
        Set(self)
    }
}

public extension Sequence where Element == Int {
    
    func product() -> Int {
        reduce(1, *)
    }
    
    func sum() -> Int {
        reduce(0, +)
    }
}

public extension Sequence where Element: StringProtocol {
    
    var asInts: Array<Int> {
        compactMap { Int($0) }
    }
    
    var asStrings: Array<String> {
        compactMap { String($0) }
    }
}
