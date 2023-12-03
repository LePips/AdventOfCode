struct Day3: Day {
    
    func part1() -> CustomStringConvertible? {
		let lines = input()
            .lines
        
        let numbers = lines
            .enumerated()
            .map { (x: $0.element.rangeMatches(for: "(\\d+)"), y: $0.offset) }
            .map { location in
                location.x.map { (xRange: $0.1, y: location.y, value: $0.0.asInt!) }
            }
            .flatMap { $0 }
        
        return numbers
            .compactMap { (xRange: ClosedRange<Int>, y: Int, value: Int) -> Int? in
                let hasSymbol = lines[Swift.max(0, y - 1) ... Swift.min(lines[0].count - 1, y + 1)]
                    .map(\.asArray)
                    .map { $0[Swift.max(0, xRange.lowerBound - 1) ... Swift.min(lines[0].count - 1, xRange.upperBound)] }
                    .map(\.asArray)
                    .flatMap { $0 }
                    .contains(where: { !$0.isNumber && $0 != "." })
                
                guard hasSymbol else { return nil }
                
                return value
            }
            .sum()
    }
    
    func part2() -> CustomStringConvertible? {
        let lines = input()
            .lines
        
        let gears = lines
            .enumerated()
            .map { (x: $0.element.rangeMatches(for: "(\\*)"), y: $0.offset) }
            .map { location in
                location.x.map { (x: $0.1.lowerBound, y: location.y) }
            }
            .flatMap { $0 }
        
        let numbers = lines
            .enumerated()
            .map { (x: $0.element.rangeMatches(for: "(\\d+)"), y: $0.offset) }
            .map { location in
                location.x.map { (xRange: $0.1, y: location.y, value: $0.0.asInt!) }
            }
            .flatMap { $0 }
        
        let gearRatios = gears
            .map { gear -> (x: ClosedRange<Int>, y: ClosedRange<Int>) in
                (
                    x: Swift.max(0, gear.x - 1) ... Swift.min(lines[0].count - 1, gear.x + 1),
                    y: Swift.max(0, gear.y - 1) ... Swift.min(lines[0].count - 1, gear.y + 1)
                )
            }
            .map { frame in
                numbers.filter { (xRange: ClosedRange<Int>, y: Int, value: Int) in
                    frame.x.intersects(xRange) && frame.y.contains(y)
                }
            }
            .filter { $0.count == 2 }
            .map { $0.map(\.value) }
            .map { $0.reduce(1, *) }
            .sum()
        
        return gearRatios
    }
}
