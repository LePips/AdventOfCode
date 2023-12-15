struct Day15: Day {

    func f(_ s: Substring) -> Int {
        var t = 0

        for c in s {
            t += c.asciiValue!.asInt
            t *= 17
            t %= 256
        }

        return t
    }

    func part1() -> CustomStringConvertible? {
        lines()
            .first!
            .split(on: ",")
            .map(f(_:))
            .sum()
    }

    func p(_ l: [(label: Substring, f: Int)], _ b: Int) -> Int {
        l.enumerated()
            .map { b * ($0.offset + 1) * $0.element.f }
            .sum()
    }

    func part2() -> CustomStringConvertible? {

        var d = Array(repeating: [(label: Substring, f: Int)](), count: 256)

        let input = lines()
            .first!
            .split(on: ",")
            .map { k in
                if k.last! == "-" {
                    let s = k.split(on: "-")
                    return (label: s[0], op: -1)
                } else {
                    let s = k.split(on: "=")
                    return (label: s[0], op: s[1].asInt!)
                }
            }

        for k in input {

            let b = f(k.label)

            if k.op == -1 {
                if let i = d[b].firstIndex(where: { $0.label == k.label }) {
                    d[b].remove(at: i)
                }
            } else {
                if let i = d[b].firstIndex(where: { $0.label == k.label }) {
                    d[b][i] = (k.label, k.op)
                } else {
                    d[b].append((k.label, k.op))
                }
            }
        }

        return d.enumerated()
            .map { p($0.element, $0.offset + 1) }
            .sum()
    }
}
