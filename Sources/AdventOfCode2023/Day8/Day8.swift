struct Day8: Day {

    func part1() -> CustomStringConvertible? {
        let lines = lines()
            .split(on: .empty)

        let instructions = lines[0][0].asArray
        let map = lines[1]
            .map { $0.split(on: "=").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) } }
            .map { ($0[0], $0[1].matches(for: "([A-Z]{3})")) }
            .reduce(into: [:]) {
                $0[$1.0] = $1.1
            }

        var s = -1
        var c = "AAA"

        while true {
            if c == "ZZZ" {
                break
            }

            s += 1
            let d = instructions[s % instructions.count]

            if d == "L" {
                c = map[c]![0]
            } else {
                c = map[c]![1]
            }
        }

        return s + 1
    }

    func part2() -> CustomStringConvertible? {
        let lines = lines()
            .split(on: .empty)

        let instructions = lines[0][0].asArray
        let map = lines[1]
            .map { $0.split(on: "=").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) } }
            .map {
                ($0[0], $0[1].matches(for: "([A-Z|0-9]{3})"))
            }
            .reduce(into: [:]) {
                $0[$1.0] = $1.1
            }

        func steps(_ start: String) -> Int {
            var s = -1
            var c = start

            while true {
                if c.last! == "Z" {
                    break
                }

                s += 1
                let d = instructions[s % instructions.count]

                if d == "L" {
                    c = map[c]![0]
                } else {
                    c = map[c]![1]
                }
            }

            return s + 1
        }

        let lcm = map
            .keys
            .filter { $0.last! == "A" }
            .map(steps(_:))
            .leastCommonMultiple()

        return lcm
    }
}
