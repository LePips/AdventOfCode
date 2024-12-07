struct Day1: Day {

    func part1() -> CustomStringConvertible? {
        input()
            .lines
            .split(on: .empty)
            .map { $0.asInts.sum() }
            .max()
    }

    func part2() -> CustomStringConvertible? {
        input()
            .lines
            .split(on: .empty)
            .map { $0.asInts.sum() }
            .max(count: 3)
            .sum()
    }
}
