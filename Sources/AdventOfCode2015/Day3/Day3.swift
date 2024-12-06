struct Day3: Day {

    func part1() -> CustomStringConvertible? {
        let moves = lines()[0]
            .asArray

        var t: Set<Coordinate> = []
        
        t.insert(.init(x: 0, y: 0))
        
        var x = 0
        var y = 0
        
        for move in moves {
            switch move {
            case "^":
                y += 1
            case "v": ()
                y -= 1
            case "<": ()
                x -= 1
            case ">": ()
                x += 1
            default: ()
            }
            
            t.insert(.init(x: x, y: y))
        }

        return t.count
    }

    func part2() -> CustomStringConvertible? {
        let moves = lines()[0]
            .asArray

        var t: Set<Coordinate> = []
        
        var sx = 0
        var sy = 0
        var rx = 0
        var ry = 0
        
        for move in moves.chunks(ofCount: 2) {
            
            let move = Array(move)
            
            switch move[0] {
            case "^":
                sy += 1
            case "v": ()
                sy -= 1
            case "<": ()
                sx -= 1
            case ">": ()
                sx += 1
            default: ()
            }
            
            switch move[1] {
            case "^":
                ry += 1
            case "v": ()
                ry -= 1
            case "<": ()
                rx -= 1
            case ">": ()
                rx += 1
            default: ()
            }
            
            t.insert(.init(x: sx, y: sy))
            t.insert(.init(x: rx, y: ry))
        }
        
        return t.count
    }
}
