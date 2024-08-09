struct Day12: Day {

    func part1() -> CustomStringConvertible? {
        lines()
            .first!
            .matches(for: "(-?\\b\\d+\\b)")
            .compactMap(Int.init)
            .sum()
    }
    
    func f(_ j: AnyJSON) -> Int {
        
        switch j {
        case .object(let o):
            if o.values.contains(where: { $0 == .string("red") }) {
                return 0
            } else {
                return o.values
                    .map(f)
                    .sum()
            }
        case .array(let a):
            return a.map(f)
                .sum()
        case .number(let n):
            return Int(n)
        default:
            return 0
        }
    }

    func part2() -> CustomStringConvertible? {
        
        let s = lines()
            .first!
            .data(using: .utf8)!
        
        let d = JSONDecoder()
        let j = try! d.decode(AnyJSON.self, from: s)
        
        return f(j)
    }
}
