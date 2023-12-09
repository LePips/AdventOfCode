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

// These are defined on Int because the type checker
// is unable to infer in many `map`/composition instances
public extension Sequence<Int> {

    func product() -> Element {
        reduce(1, *)
    }

    func sum() -> Element {
        reduce(0, +)
    }
}

public extension Sequence where Element: BinaryInteger {

    func differences() -> [Element] {
        var t: [Element] = []

        var iter = makeIterator()
        var a = iter.next()
        var b = iter.next()

        while let _ = b {
            t.append(b! - a!)
            a = b
            b = iter.next()
        }

        return t
    }

    func gcd() -> Element {
        reduce(0, _gcd(_:_:))
    }

    func lcm() -> Element {
        reduce(1, _lcm(_:_:))
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
