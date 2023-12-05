struct Day1: Day {

    func part1() -> CustomStringConvertible? {
        input()
            .lines
            .split(on: .empty)
            .map { $0.asInts.sum() }
            .max()[0]
    }

    func part2() -> CustomStringConvertible? {
        input()
            .lines
            .split(on: .empty)
            .map { $0.asInts.sum() }
            .max(3)
            .sum()
    }
}
