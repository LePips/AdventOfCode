struct Day2: Day {
    
    enum RockPaperScissor {
        
        case rock
        case paper
        case scissor
        
        func beats(other: RockPaperScissor) -> Bool {
            switch self {
            case .rock:
                return other == .scissor
            case .paper:
                return other == .rock
            case .scissor:
                return other == .paper
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
                return .paper
            case .paper:
                return .scissor
            case .scissor:
                return .rock
            }
        }
        
        /// Value that would lose against the current value
        var losingValue: RockPaperScissor {
            switch self {
            case .rock:
                return .scissor
            case .paper:
                return .rock
            case .scissor:
                return .paper
            }
        }
        
        var shapeScore: Int {
            switch self {
            case .rock:
                return 1
            case .paper:
                return 2
            case .scissor:
                return 3
            }
        }
        
        static func value(for value: String) -> RockPaperScissor {
            switch value {
            case "A", "X":
                return .rock
            case "B", "Y":
                return .paper
            case "C", "Z":
                return .scissor
            default:
                fatalError()
            }
        }
        
        static func part_2_value(for value: String, desiredResult: String) -> RockPaperScissor {
            switch desiredResult {
            case "X":
                return Self.value(for: value).losingValue
            case "Y":
                return Self.value(for: value)
            case "Z":
                return Self.value(for: value).winningValue
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
