struct Day18: Day {
    
    func f(_ g: Matrix<String>, _ i: Int) {
        let r = g.rows[i]
        var c = false
        var l = "."
        
        for j in 0 ..< r.count {
            switch (r[j], c) {
            case ("#", true):
                if l == "." {
                    c = false
                }
            case ("#", false):
                c = true
                l = "#"
            case (".", true):
                g[j, i] = "#"
                l = "."
            case (".", false):
                l = "."
            default:
                fatalError()
            }
        }
    }

    func part1() -> CustomStringConvertible? {
        
        let coordinates = lines()
            .map { $0.split(on: " ") }
            .reduce(into: [Coordinate(x: 0, y: 0)]) { partialResult, input in
                let s = input[1].asInt!
                
                var t: [Coordinate<Int>] = [partialResult.last!]
                
                switch input[0] {
                case "U":
                    for _ in 0 ..< s {
                        t.append(Coordinate(x: t.last!.x, y: t.last!.y - 1))
                    }
                case "R":
                    for _ in 0 ..< s {
                        t.append(Coordinate(x: t.last!.x + 1, y: t.last!.y))
                    }
                case "D":
                    for _ in 0 ..< s {
                        t.append(Coordinate(x: t.last!.x, y: t.last!.y + 1))
                    }
                case "L":
                    for _ in 0 ..< s {
                        t.append(Coordinate(x: t.last!.x - 1, y: t.last!.y))
                    }
                default:
                    fatalError()
                }
                
                partialResult.append(contentsOf: t)
            }
            .asSet
        
        let minX = coordinates.min(using: \.x)!
        let maxX = coordinates.max(using: \.x)!
        let minY = coordinates.min(using: \.y)!
        let maxY = coordinates.max(using: \.y)!
        
        let rows = Array(repeating: Array(repeating: ".", count: maxX.x + 1), count: maxY.y + 1)
        let g = Matrix(rows: rows)
        
        for coordinate in coordinates {
            g[coordinate] = "#"
        }
        
        for i in 0 ..< g.rows.count {
            f(g, i)
        }
        
        return g
            .rows
            .map { $0.count(where: { $0 == "#" }) }
            .sum()
    }

    func part2() -> CustomStringConvertible? {
        nil
    }
}
