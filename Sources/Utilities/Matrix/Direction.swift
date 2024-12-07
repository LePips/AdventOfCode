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
