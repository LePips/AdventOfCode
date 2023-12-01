struct Day9: Day {
    
    class Knot {
        
        var next: Knot?
        
        var coordinate: Coordinate
        
        var visited = Set<Coordinate>()
        
        init(coordinate: Coordinate) {
            self.coordinate = coordinate
            
            self.visited.insert(coordinate)
        }
        
        func move(to newCoordinate: Coordinate) {
            
            if next == nil {
                print("Last moving to: \(newCoordinate)")
            }
            
            if let next, !newCoordinate.isNextTo(other: next.coordinate) {
                next.move(to: coordinate)
            }
            
            visited.insert(newCoordinate)
            coordinate = newCoordinate
        }
    }
    
    struct Coordinate: Hashable {
        
        let x: Int
        let y: Int
        
        func applying(move: String, distance: Int) -> Coordinate {
            switch move {
            case "U":
                return .init(x: x, y: y + distance)
            case "D":
                return .init(x: x, y: y - distance)
            case "L":
                return .init(x: x - distance, y: y)
            case "R":
                return .init(x: x + distance, y: y)
            default:
                fatalError()
            }
        }
        
        func isNextTo(other: Coordinate) -> Bool {
            (x - 1 ... x + 1).contains(other.x) &&
            (y - 1 ... y + 1).contains(other.y)
        }
    }
    
    func headCoordinates() -> [Coordinate] {
        input()
            .lines
            .map { $0.split(on: " ") }
            .reduce([Coordinate(x: 0, y: 0)]) { partialResult, move in
                partialResult.appending((1...move[1].asInt!).map { partialResult.last!.applying(move: move[0].asString, distance: $0) })
            }
    }
    
    func part1() -> CustomStringConvertible? {
        
        let head = Knot(coordinate: .init(x: 0, y: 0))
        let tail = Knot(coordinate: .init(x: 0, y: 0))
        head.next = tail
        
        headCoordinates()
            .forEach { head.move(to: $0) }
        
        return tail.visited.count
    }
    
    func part2() -> CustomStringConvertible? {
        
        let head = Knot(coordinate: .init(x: 0, y: 0))
        var tail: Knot!
        
        (1...9)
            .map { _ in Knot(coordinate: .init(x: 0, y: 0)) }
            .windows(ofCount: 2)
            .forEach { slice in
                slice[slice.startIndex].next = slice[slice.endIndex - 1]
                
                if slice.endIndex == 9 {
                    tail = slice[slice.endIndex - 1]
                } else if slice.startIndex == 0 {
                    head.next = slice[slice.startIndex]
                }
            }
        
        headCoordinates()
            .forEach { head.move(to: $0) }
        
        return tail.visited.count
    }
}
