struct Day8: Day {
    
    func antinode(a: Coordinate, b: Coordinate) -> Coordinate? {
        let x = b.x + (b.x - a.x)
        let y = b.y + (b.y - a.y)
        
        return Coordinate(x: x, y: y)
    }

    func part1() -> CustomStringConvertible? {
        let m = matrix()
        
        return m.locations(where: { $0 != "." })
            .map { (m[$0], $0) }
            .grouping(by: \.0)
            .values
            .map { $0.map(\.1) }
            .map {
                let p = $0.permutations(ofCount: 2)
                    .compactMap { pi in
                        return antinode(a: pi[0], b: pi[1])
                    }
                    .filter { m.contains(c: $0) }
                
                return p
            }
            .flatMap(\.self)
            .uniqued()
            .asArray
            .count
    }
    
    func antinodeT(
        a: Coordinate,
        b: Coordinate,
        m: inout Matrix<Character>
    ) -> [Coordinate] {
        let x = b.x + (b.x - a.x)
        let y = b.y + (b.y - a.y)
        
        var t: [Coordinate] = [Coordinate(x: b.x, y: b.y)]
        var nc = Coordinate(x: x, y: y)
        
        while m.contains(c: nc) {
            t.append(nc)
            nc = Coordinate(x: nc.x + (b.x - a.x), y: nc.y + (b.y - a.y))
        }
        
        return t
    }

    func part2() -> CustomStringConvertible? {
        var m = matrix()
        
        return m.locations(where: { $0 != "." })
            .map { (m[$0], $0) }
            .grouping(by: \.0)
            .values
            .map { $0.map(\.1) }
            .map {
                $0.permutations(ofCount: 2)
                    .compactMap { pi in
                        return antinodeT(
                            a: pi[0],
                            b: pi[1],
                            m: &m
                        )
                    }
                    .flatMap(\.self)
            }
            .flatMap(\.self)
            .uniqued()
            .asArray
            .count
    }
}
