struct Day7: Day {

    enum Hand: Int {
        case five
        case four
        case full
        case three
        case twoPair
        case onePair
        case high

        static let cards: [Character] = ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"]
        static let jokerCards: [Character] = ["A", "K", "Q", "T", "9", "8", "7", "6", "5", "4", "3", "2", "J"]

        static func compare(lhs: (Hand, String), rhs: (Hand, String), with cards: [Character]) -> Bool {
            let ls = lhs.1.asArray
            let rs = rhs.1.asArray

            if lhs.0.rawValue > rhs.0.rawValue {
                return true
            } else if lhs.0.rawValue == rhs.0.rawValue {
                for i in 0 ..< ls.count {
                    let a = cards.firstIndex(of: ls[i])!
                    let b = cards.firstIndex(of: rs[i])!

                    if a > b {
                        return true
                    } else if b > a {
                        return false
                    }
                }
            }

            return false
        }

        static func value(_ hand: String) -> (Hand, String) {
            let groupedHand = Dictionary(grouping: hand, by: { $0 })
                .values
                .sorted(using: \.count)
                .reversed()
                .asArray

            switch (groupedHand.count, groupedHand[0].count) {
            case (1, _):
                return (.five, hand)
            case (2, 4):
                return (.four, hand)
            case (2, 3):
                return (.full, hand)
            case (3, 3):
                return (.three, hand)
            case (3, 2):
                return (.twoPair, hand)
            case (4, _):
                return (.onePair, hand)
            case (5, _):
                return (.high, hand)
            default:
                fatalError()
            }
        }

        // Replace J with the most common most valuable card
        static func jokerValue(_ hand: String) -> (Hand, String) {

            var groups = Dictionary(grouping: hand, by: { $0 })

            guard let jokers = groups["J"], jokers.count < 5 else { return value(hand) }

            groups["J"] = nil

            let groupedHand = groups
                .values
                .sorted(using: \.count)
                .reversed()
                .asArray

            let b = Dictionary(grouping: groupedHand, by: { $0.count })

            let c = b
                .values
                .asArray
                .sorted(by: { $0[0].count > $1[0].count })[0] // most common cards
                .compactMap(\.first)
                .sorted(by: { jokerCards.firstIndex(of: $0)! < jokerCards.firstIndex(of: $1)! })[0].asString // most valuable card

            return value(hand.replacingOccurrences(of: "J", with: c))
        }
    }

    func part1() -> CustomStringConvertible? {
        lines()
            .map { $0.split(on: " ").asStrings }
            .map { ($0[0], $0[1].asInt!) }
            .map {
                let a = Hand.value($0.0)
                return (a, $0.1)
            }
            .sorted(by: { Hand.compare(lhs: $0.0, rhs: $1.0, with: Hand.cards) })
            .enumerated()
            .asArray
            .map { ($0.offset + 1) * $0.element.1 }
            .sum()
    }

    func part2() -> CustomStringConvertible? {
        lines()
            .map { $0.split(on: " ").asStrings }
            .map { ($0[0], $0[1].asInt!) }
            .map {
                let a = Hand.jokerValue($0.0)
                return ((a.0, $0.0), $0.1)
            }
            .sorted(by: { Hand.compare(lhs: $0.0, rhs: $1.0, with: Hand.jokerCards) })
            .enumerated()
            .asArray
            .map { ($0.offset + 1) * $0.element.1 }
            .sum()
    }
}
