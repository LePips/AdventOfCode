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

@inlinable
public func manhattanDistance<T: BinaryInteger>(x1: T, y1: T, x2: T, y2: T) -> T {
    T((x1 - x2).magnitude + T(y1 - y2).magnitude)
}

@inlinable
public func manhattanDistance(_ a: Coordinate, _ b: Coordinate) -> Int {
    Int((a.x - b.x).magnitude + Int(a.y - b.y).magnitude)
}

public extension BinaryInteger {
    
    var asInt: Int {
        Int(self)
    }
}

public extension Int {
    
    var digits: [Int] {
        String(self).compactMap { Int(String($0)) }
    }
    
    var digitString: String {
        String(self)
    }
    
    var asDouble: Double {
        Double(self)
    }

    var asInt: Int {
        Int(self)
    }

    var isEven: Bool {
        (self & 1) == 0
    }

    var isOdd: Bool {
        !isEven
    }

    var isPrime: Bool {
        guard self != 2 else { return true }
        guard self > 2, self % 2 != 0 else { return false }

        return !stride(from: 3, through: Self(sqrt(Double(self))), by: 2)
            .contains { self % $0 == 0 }
    }

    func nextPrime() -> Int {
        var n: Self = if isEven {
            self + 1
        } else {
            self + 2
        }

        while !n.isPrime {
            n += 2
        }

        return n
    }
}
