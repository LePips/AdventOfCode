struct Day6: Day {

    func part1() -> CustomStringConvertible? {
        let lines = lines()
            .map {
                $0.matches(for: "(\\d+)")
                    .asInts
            }
        
        return zip(lines[0], lines[1])
            .asArray
            .map { race in
                
                var t = 0
                
                for i in 1 ..< race.0 - 1 {
                    if i * (race.0 - i) > race.1 {
                        t += 1
                    }
                }
                
                return t
            }
            .product()
    }

    func part2() -> CustomStringConvertible? {
        let lines = lines()
            .compactMap {
                $0.matches(for: "(\\d+)")
                    .joined(separator: "")
                    .asInt
            }
        
        var t = 0
        
        for i in 1 ..< lines[0] - 1 {
            if i * (lines[0] - i) > lines[1] {
                t += 1
            }
        }
        
        return t
    }
}
