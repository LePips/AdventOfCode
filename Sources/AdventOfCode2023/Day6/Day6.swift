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
        
        let time = lines[0]
        let distance = lines[1]
        
        var t = 0
        
        for i in 1 ..< time - 1 {
            if i * (time - i) > distance {
                return time - 2 * i + 1
            }
        }
        
        return t
    }
}
