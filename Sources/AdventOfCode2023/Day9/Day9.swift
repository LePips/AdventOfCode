struct Day9: Day {

    func f(_ n: [Int]) -> Int {

        if n.allEqual(0) {
            return 0
        }

        return f(n.differences()) + n.last!
    }

    func part1() -> CustomStringConvertible? {
        lines()
            .map { $0.split(separator: " ").asInts }
            .map(f(_:))
            .sum()
    }

    func part2() -> CustomStringConvertible? {
        lines()
            .map { $0.split(separator: " ").asInts }
            .map { f($0.reversed()) }
            .sum()
    }
}
