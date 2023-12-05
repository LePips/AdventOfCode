struct Day3: Day {

    var priorities: [Character: Int] {
        var a: [Character: Int] = [:]

        String.alphabet
            .enumerated()
            .forEach { index, value in
                a[value] = index + 1
            }

        String.alphabet
            .uppercased()
            .enumerated()
            .forEach { index, value in
                a[value] = index + 27
            }

        return a
    }

    func part1() -> CustomStringConvertible? {
        input()
            .lines
            .map { $0.chunks(ofCount: $0.count / 2).asStrings }
            .map { $0.intersectingElements().first! }
            .map { priorities[$0]! }
            .sum()
    }

    func part2() -> CustomStringConvertible? {
        input()
            .lines
            .chunks(ofCount: 3)
            .map { $0.intersectingElements().first! }
            .map { priorities[$0]! }
            .sum()
    }
}
