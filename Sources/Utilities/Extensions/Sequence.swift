public extension Sequence {

    var asArray: [Element] {
        Array(self)
    }

    func sorted(using keyPath: KeyPath<Element, some Comparable>) -> [Element] {
        sorted(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })
    }
}

public extension Sequence where Element: Hashable {

    var asSet: Set<Element> {
        Set(self)
    }
}

public extension Sequence<Int> {

    func product() -> Int {
        reduce(1, *)
    }

    func sum() -> Int {
        reduce(0, +)
    }
}

public extension Sequence where Element: StringProtocol {

    var asInts: [Int] {
        compactMap { Int($0) }
    }

    var asStrings: [String] {
        compactMap { String($0) }
    }
}
