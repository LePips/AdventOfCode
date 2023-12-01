struct Day1: Day {
    
    func part1() -> CustomStringConvertible? {
        lines()
            .map { $0.filter(\.isNumber) }
            .map { Int("\($0.first!)\($0.last!)")! }
            .sum()
    }
    
    enum WrittenDigit: Int, CaseIterable {
        case one = 1
        case two = 2
        case three = 3
        case four = 4
        case five = 5
        case six = 6
        case seven = 7
        case eight = 8
        case nine = 9
        
        init(stringValue: String) {
            
            if let i = Int(stringValue) {
                self.init(rawValue: i)!
                return
            }
            
            switch stringValue {
            case "one": self.init(rawValue: 1)!
            case "two": self.init(rawValue: 2)!
            case "three": self.init(rawValue: 3)!
            case "four": self.init(rawValue: 4)!
            case "five": self.init(rawValue: 5)!
            case "six": self.init(rawValue: 6)!
            case "seven": self.init(rawValue: 7)!
            case "eight": self.init(rawValue: 8)!
            case "nine": self.init(rawValue: 9)!
            default: fatalError()
            }
        }
        
        static let totalRegex: String = {
            let cases = allCases
                .map { "\($0)" }
                .joined(separator: "|")
            
            return "(\(cases)|\\d)"
        }()
        
        static let totalRegexReverse: String = {
            let cases = allCases
                .map { "\($0)" }
                .map { $0.reversed }
                .joined(separator: "|")
            
            return "(\(cases)|\\d)"
        }()
    }
    
    func part2() -> CustomStringConvertible? {
        lines()
            .map {
                [
                    $0.firstMatch(for: WrittenDigit.totalRegex)!,
                    $0.reversed.firstMatch(for: WrittenDigit.totalRegexReverse)!.reversed
                ]
            }
            .map { [$0.first!, $0.last!].map(WrittenDigit.init(stringValue:)) }
            .map { Int("\($0[0].rawValue)\($0[1].rawValue)")! }
            .sum()
    }
}
