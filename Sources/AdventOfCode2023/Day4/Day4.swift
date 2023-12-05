struct Day4: Day {

    func part1() -> CustomStringConvertible? {
        lines()
            .map { $0.split(on: ":")[1].split(on: "|").asStrings }
            .map { $0.map { $0.matches(for: "\\d+").asInts.asSet } }
            .map { $0.intersectingElements() }
            .map(\.count)
            .map { pow(2, $0 - 1) }
            .sum()
    }

    func part2() -> CustomStringConvertible? {

        let lines = lines()
        var cards = Array(repeating: 1, count: lines.count)

        let wins = lines
            .map { $0.split(on: ":")[1].split(on: "|").asStrings }
            .map { $0.map { $0.matches(for: "\\d+").asInts.asSet } }
            .map { $0.intersectingElements() }
            .map(\.count)

        for (i, win) in wins.enumerated() {
            let f = cards[i]

            for j in 0 ..< win {
                cards[i + j + 1] += 1 * f
            }
        }

        return cards.sum()
    }
}
