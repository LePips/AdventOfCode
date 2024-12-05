struct Day4: Day {

    func part1() -> CustomStringConvertible? {
        
        let m = matrix()
        let dis = [
            Coordinate(x: -1, y: 0),
            Coordinate(x: 1, y: 0),
            Coordinate(x: 0, y: -1),
            Coordinate(x: 0, y: 1),
            Coordinate(x: -1, y: -1),
            Coordinate(x: 1, y: 1),
            Coordinate(x: -1, y: 1),
            Coordinate(x: 1, y: -1),
        ]
        let xs = m
            .locations(where: { $0 == "X" })
        
        func search(_ c: Coordinate<Int>, _ w: String, _ di: Coordinate<Int>) -> Bool {
        
            guard w.isNotEmpty else {
                return true
            }
            
            var w = w
            let ci = w.removeFirst()
            
            let nc = Coordinate(x: c.x + di.x, y: c.y + di.y)
            guard m.contains(c: nc) else { return false }
            guard m[nc] == ci else { return false }
            
            return search(nc, w, di)
        }
        
        return xs
            .map { x in
                dis.map { di in
                    search(x, "MAS", di)
                }
                .filter { $0 }
                .count
            }
            .sum()
    }

    func part2() -> CustomStringConvertible? {
        
        let m = matrix()
        let dis = [
            Coordinate(x: -1, y: -1),
            Coordinate(x: 1, y: 1),
            Coordinate(x: -1, y: 1),
            Coordinate(x: 1, y: -1),
        ]
        let xs = m
            .locations(where: { $0 == "A" })
        
        func search(_ c: Coordinate<Int>) -> Bool {
            let points = dis.map { Coordinate(x: c.x + $0.x, y: c.y + $0.y) }
            
            guard points.allSatisfy({ m.contains(c: $0) }) else { return false }
            guard points.count(where: { m[$0] == "M" }) == 2 else { return false }
            guard points.count(where: { m[$0] == "S" }) == 2 else { return false }
            
            // Ms on top
            if m[Coordinate(x: c.x - 1, y: c.y - 1)] == "M", m[Coordinate(x: c.x + 1, y: c.y - 1)] == "M" {
                return true
            }
            
            // Ms on bottom
            if m[Coordinate(x: c.x - 1, y: c.y + 1)] == "M", m[Coordinate(x: c.x + 1, y: c.y + 1)] == "M" {
                return true
            }
            
            // Ms on left
            if m[Coordinate(x: c.x - 1, y: c.y - 1)] == "M", m[Coordinate(x: c.x - 1, y: c.y + 1)] == "M" {
                return true
            }
            
            // Ms on right
            if m[Coordinate(x: c.x + 1, y: c.y - 1)] == "M", m[Coordinate(x: c.x + 1, y: c.y + 1)] == "M" {
                return true
            }
            
            return false
        }
        
        return xs
            .filter(search)
            .count
    }
}
