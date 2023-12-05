struct Day2: Day {

    enum RockPaperScissor {

        case rock
        case paper
        case scissor

        func beats(other: RockPaperScissor) -> Bool {
            switch self {
            case .rock:
                other == .scissor
            case .paper:
                other == .rock
            case .scissor:
                other == .paper
            }
        }

        func draw(other: RockPaperScissor) -> Bool {
            self == other
        }

        func gameScore(against other: RockPaperScissor) -> Int {

            if self == other {
                return 3
            }

            return beats(other: other) ? 6 : 0
        }

        /// Value that would win against the current value
        var winningValue: RockPaperScissor {
            switch self {
            case .rock:
                .paper
            case .paper:
                .scissor
            case .scissor:
                .rock
            }
        }

        /// Value that would lose against the current value
        var losingValue: RockPaperScissor {
            switch self {
            case .rock:
                .scissor
            case .paper:
                .rock
            case .scissor:
                .paper
            }
        }

        var shapeScore: Int {
            switch self {
            case .rock:
                1
            case .paper:
                2
            case .scissor:
                3
            }
        }

        static func value(for value: String) -> RockPaperScissor {
            switch value {
            case "A", "X":
                .rock
            case "B", "Y":
                .paper
            case "C", "Z":
                .scissor
            default:
                fatalError()
            }
        }

        static func part_2_value(for value: String, desiredResult: String) -> RockPaperScissor {
            switch desiredResult {
            case "X":
                Self.value(for: value).losingValue
            case "Y":
                Self.value(for: value)
            case "Z":
                Self.value(for: value).winningValue
            default:
                fatalError()
            }
        }
    }

    func part1() -> CustomStringConvertible? {
        input()
            .lines
            .map { $0.split(on: " ").asStrings }
            .map { (RockPaperScissor.value(for: $0[0]), RockPaperScissor.value(for: $0[1])) }
            .map { $0.1.gameScore(against: $0.0) + $0.1.shapeScore }
            .sum()
    }

    func part2() -> CustomStringConvertible? {
        input()
            .lines
            .map { $0.split(on: " ").asStrings }
            .map { (RockPaperScissor.value(for: $0[0]), RockPaperScissor.part_2_value(for: $0[0], desiredResult: $0[1])) }
            .map { $0.1.gameScore(against: $0.0) + $0.1.shapeScore }
            .sum()
    }
}
