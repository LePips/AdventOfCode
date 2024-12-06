public struct Coordinate: Hashable {
    public let x: Int
    public let y: Int

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

public extension Coordinate {
    
    static func + (lhs: Coordinate, rhs: Coordinate) -> Coordinate {
        Coordinate(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func + (lhs: Coordinate, rhs: Direction) -> Coordinate {
        lhs + rhs.coordinate
    }
}

public struct CoordinateAndDirection: Hashable {
    
    public var coordinate: Coordinate
    public var direction: Direction
    
    public init(coordinate: Coordinate, direction: Direction) {
        self.coordinate = coordinate
        self.direction = direction
    }
}

public enum Direction: Hashable {
    
    case up
    case down
    case left
    case right
    
    public var coordinate: Coordinate {
        switch self {
        case .up:
            return Coordinate(x: 0, y: -1)
        case .down:
            return Coordinate(x: 0, y: 1)
        case .left:
            return Coordinate(x: -1, y: 0)
        case .right:
            return Coordinate(x: 1, y: 0)
        }
    }
    
    public var rotated90: Direction {
        switch self {
        case .up:
            return .right
        case .down:
            return .left
        case .left:
            return .up
        case .right:
            return .down
        }
    }
    
    public var rotated180: Direction {
        switch self {
        case .up:
            return .down
        case .down:
            return .up
        case .left:
            return .right
        case .right:
            return .left
        }
    }
    
    public var rotated270: Direction {
        switch self {
        case .up:
            return .left
        case .down:
            return .right
        case .left:
            return .down
        case .right:
            return .up
        }
    }
}

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

    func nextPrime() -> Self {
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
