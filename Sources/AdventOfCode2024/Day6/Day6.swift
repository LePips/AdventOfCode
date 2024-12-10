struct Day6: Day {
    
    func traverse(_ m: Matrix<Character>, _ start: Coordinate) -> Int {
        
        var seen: Set<Coordinate> = [start]
        var c = start
        var d: Direction = .up
        
        while m.contains(c: c) {
            seen.insert(c)
            let nc = c + d
            
            guard m.contains(c: nc) else { break }
            
            if m[nc] == "#" {
                d = d.rotated90
            } else {
                c = nc
            }
        }
        
        return seen.count
    }

    func part1() -> CustomStringConvertible? {
        
        var m = matrix()
        let start = m.firstLocation(of: "^")!
        m[start] = "."
        
        return traverse(m, start)
    }
    
    // test with obstruction, return true if caused a loop, false if made out
    func obstruct(_ m: Matrix<Character>, _ start: Coordinate, _ obstruction: Coordinate) -> (Bool, Int) {
        
        var d: Direction = .up
        var seen: Set<CoordinateAndDirection> = [.init(coordinate: start, direction: d)]
        var c = start
        
        while m.contains(c: c) {
            let nc = c + d
            let ncd = CoordinateAndDirection(coordinate: nc, direction: d)
            
            guard m.contains(c: nc) else { break }
            
            if m[nc] == "#" || nc == obstruction {
                d = d.rotated90
            } else {
                if seen.contains(ncd) {
                    return (true, seen.count)
                }
                
                seen.insert(ncd)
                c = nc
            }
        }
        
        return (false, seen.count)
    }

    func part2() -> CustomStringConvertible? {
        
        var m = matrix()
        let start = m.firstLocation(of: "^")!
        m[start] = "."
        
        var t = 0
        
        for y in 0 ..< m.height {
            for x in 0 ..< m.width where m[x, y] == "." {
                if obstruct(m, start, Coordinate(x: x, y: y)).0 {
                    t += 1
                }
            }
        }
        
        return t
    }
}
