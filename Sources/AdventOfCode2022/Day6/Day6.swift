struct Day6: Day {
    
    func part1() -> CustomStringConvertible? {
        input()
            .lines[0]
            .windows(ofCount: 4)
            .enumerated()
            .first(where: { $0.element.asSet.count == 4 })
            .map { $0.offset + 4 }
    }
    
    func part2() -> CustomStringConvertible? {
        input()
            .lines[0]
            .windows(ofCount: 14)
            .enumerated()
            .first(where: { $0.element.asSet.count == 14 })
            .map { $0.offset + 14 }
    }
}
