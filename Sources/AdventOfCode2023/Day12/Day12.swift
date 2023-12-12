struct Day12: Day {

    struct Key: Hashable {
        let sh: Int
        let gs: Int
    }

    func f(
        _ s: [Character], // proposed string
        _ gs: [Int], // rest groups,
        _ memo: inout [Key: Int] // s: [gs: count]
    ) -> Int {

        if let c = memo[Key(sh: s.hashValue, gs: gs.hashValue)] {
            return c
        }

        if s.isEmpty && gs.isNotEmpty {
            memo[Key(sh: s.hashValue, gs: gs.hashValue)] = 0
            return 0
        }

        if gs.isEmpty {
            if s.contains("#") {
                memo[Key(sh: s.hashValue, gs: gs.hashValue)] = 0
                return 0
            } else {
                memo[Key(sh: s.hashValue, gs: gs.hashValue)] = 1
                return 1
            }
        }

        let g = gs[0]

        guard g <= s.count else { return 0 }

        // look ahead, if can make group, trim s and look for next group

        switch s[0] {
        case "?":
            let a = f(s[1...].asArray, gs, &memo) // turn to .
            var ns = s
            ns[0] = "#"
            let b = f(ns, gs, &memo)

            memo[Key(sh: s.hashValue, gs: gs.hashValue)] = a + b
            return a + b
        case "#":
            if s.count > g {
                let p = s[...g]

                if p.last! == "#" {
                    memo[Key(sh: s.hashValue, gs: gs.hashValue)] = 0
                    return 0
                } else {
                    if p[..<g].replacing("?", with: "#").allEqual("#") {
                        let a = f(s[(g + 1)...].trimmingPrefix(while: { $0 == "." }).asArray, gs.removingFirst(), &memo)
                        memo[Key(sh: s.hashValue, gs: gs.hashValue)] = a
                        return a
                    } else {
                        memo[Key(sh: s.hashValue, gs: gs.hashValue)] = 0
                        return 0
                    }
                }
            } else {
                if s.replacing("?", with: "#").allEqual("#") {
                    let a = f(s[g...].trimmingPrefix(while: { $0 == "." }).asArray, gs.removingFirst(), &memo)
                    memo[Key(sh: s.hashValue, gs: gs.hashValue)] = a
                    return a
                } else {
                    memo[Key(sh: s.hashValue, gs: gs.hashValue)] = 0
                    return 0
                }
            }
        case ".":
            let a = f(s[1...].trimmingPrefix(while: { $0 == "." }).asArray, gs, &memo)
            memo[Key(sh: s.hashValue, gs: gs.hashValue)] = a
            return a
        default:
            fatalError()
        }
    }

    func part1() -> CustomStringConvertible? {
        var memo: [Key: Int] = [:]
        return lines()
            .map { $0.split(on: " ") }
            .map { ($0[0].asArray, $0[1].split(on: ",").asInts) }
            .map { f($0.0, $0.1, &memo) }
            .sum()
    }

    func part2() -> CustomStringConvertible? {
        var memo: [Key: Int] = [:]
        return lines()
            .map { $0.split(on: " ") }
            .map { ($0[0].asArray.multiplied(by: 5, separator: "?"), $0[1].split(on: ",").asInts.multiplied(by: 5)) }
            .map { f($0.0.trimmingPrefix(while: { $0 == "." }).asArray, $0.1, &memo) }
            .sum()
    }
}
