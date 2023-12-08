public func pow(_ x: Int, _ y: Int) -> Int {
    Int(pow(Float(x), Float(y)))
}

public func gcd(_ x: Int, _ y: Int) -> Int {
    if x == 0 {
        return y
    }

    return gcd(y % x, x)
}

public extension Int {

    var isPrime: Bool {
        guard self != 2 else { return true }
        guard self > 2, self % 2 != 0 else { return false }

        return !stride(from: 3, through: Int(sqrt(Double(self))), by: 2)
            .contains { self % $0 == 0 }
    }

    func nextPrime() -> Int {
        var n = self + 1

        while !n.isPrime {
            n += 1
        }

        return n
    }
}
