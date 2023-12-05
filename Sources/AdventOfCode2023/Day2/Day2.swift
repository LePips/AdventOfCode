struct Day2: Day {

    func colorSatisfies(_ i: Int, _ s: String) -> Bool {
        switch s {
        case "red":
            i <= 12
        case "green":
            i <= 13
        case "blue":
            i <= 14
        default: fatalError()
        }
    }

    func part1() -> CustomStringConvertible? {
        lines()
            .map { (game: $0.firstMatch(for: "Game (\\d+)")!, picks: $0.matches(for: "(\\d+ (?:green|blue|red),? ?;?)+")) }
            .map { (game: $0.game.split(on: " ")[1].asInt!, picks: $0.picks.map { $0.matches(for: "(\\d+ (?:green|blue|red))") }) }
            .map { (game: $0.game, picks: $0.picks.map { $0.map { $0.split(on: " ") } }) }
            .map { (game: $0.game, picks: $0.picks.map { $0.map { colorSatisfies($0[0].asInt!, $0[1].asString) } }) }
            .map { (game: $0.game, picks: $0.picks.map { $0.areAllTrue() }) }
            .filter { $0.picks.areAllTrue() }
            .map(\.game)
            .sum()
    }

    func part2() -> CustomStringConvertible? {
        lines()
            .map { $0.matches(for: "(\\d+ (?:green|blue|red),? ?;?)+") }
            .map { $0.map { $0.matches(for: "(\\d+ (?:green|blue|red))") } }
            .map { $0.flatMap { $0 } }
            .map { $0.map { $0.split(on: " ").asStrings } }
            .map { Dictionary(grouping: $0, by: { $0[1] }) }
            .map { $0.mapValues { $0.map { $0[0].asInt! } } }
            .map { $0.mapValues { $0.max()! } }
            .map { $0.map(\.value) }
            .map { $0.reduce(1, *) }
            .sum()
    }
}
