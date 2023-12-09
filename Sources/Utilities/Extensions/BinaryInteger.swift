@inlinable
public func pow<T: BinaryInteger>(_ x: T, _ y: T) -> T {
    T(pow(Float(x), Float(y)))
}

@inlinable
public func gcd<T: BinaryInteger>(_ x: T, _ n: T...) -> T {
    n.reduce(x, _gcd(_:_:))
}

@inlinable
func _gcd<T: BinaryInteger>(_ x: T, _ y: T) -> T {
    if x == 0 {
        return y
    }

    return T(_gcd(y.magnitude % x.magnitude, x.magnitude))
}

@inlinable
public func lcm<T: BinaryInteger>(_ x: T, _ n: T...) -> T {
    n.reduce(x, _lcm(_:_:))
}

@inlinable
func _lcm<T: BinaryInteger>(_ x: T, _ y: T) -> T {
    let z = _gcd(x, y)

    guard z != 0 else { return 0 }

    return x * (y / z)
}

public extension BinaryInteger {

    var isPrime: Bool {
        guard self != 2 else { return true }
        guard self > 2, self % 2 != 0 else { return false }

        return !stride(from: 3, through: Self(sqrt(Double(self))), by: 2)
            .contains { self % $0 == 0 }
    }

    func nextPrime() -> Self {
        var n = self + 1

        while !n.isPrime {
            n += 1
        }

        return n
    }
}
