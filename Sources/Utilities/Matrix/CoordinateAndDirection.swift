public struct CoordinateAndDirection: Hashable {
    
    public var coordinate: Coordinate
    public var direction: Direction
    
    public init(coordinate: Coordinate, direction: Direction) {
        self.coordinate = coordinate
        self.direction = direction
    }
}
