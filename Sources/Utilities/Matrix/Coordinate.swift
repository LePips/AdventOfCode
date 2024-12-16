public struct Coordinate: Hashable {
    public let x: Int
    public let y: Int
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    public var nonDiagonalNeighbors: [Coordinate] {
        [
            Coordinate(x: x, y: y - 1),
            Coordinate(x: x, y: y + 1),
            Coordinate(x: x - 1, y: y),
            Coordinate(x: x + 1, y: y)
        ]
    }
    
    public var neighbors: [Coordinate] {
        [
            Coordinate(x: x - 1, y: y - 1),
            Coordinate(x: x, y: y - 1),
            Coordinate(x: x + 1, y: y - 1),
            Coordinate(x: x - 1, y: y),
            Coordinate(x: x + 1, y: y),
            Coordinate(x: x - 1, y: y + 1),
            Coordinate(x: x, y: y + 1),
            Coordinate(x: x + 1, y: y + 1)
        ]
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

extension Coordinate: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        "(\(x), \(y))"
    }
}
