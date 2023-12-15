struct Day14: Day {

    func columnLoad(_ c: [Character]) -> Int {
        c.reversed()
            .enumerated()
            .reduce(0) { partialResult, e in
                if e.element == "O" {
                    return partialResult + e.offset + 1
                }
                return partialResult
            }
    }

    func tilt(_ c: [Character]) -> [Character] {

        var c = c
        var s = 0

        for i in 0 ..< c.count {
            switch c[i] {
            case "#":
                s = i + 1
            case "O":
                c.swapAt(i, s)
                s += 1
            default: ()
            }
        }

        return c
    }

    func cycle(_ grid: Matrix<Character>) -> Matrix<Character> {
        var t = grid

        // north
        let nc = t.columns
            .map(tilt(_:))

        t = Matrix(columns: nc)

        // west, south, east
        for _ in 0 ..< 3 {
            // perform rotation
            let nr = t.columns
                .map { $0.reversed().asArray }

            t = Matrix(rows: nr)

            // tilt
            let nc = t.columns
                .map(tilt(_:))

            t = Matrix(columns: nc)
        }

        // rotate to north

        let nr = t
            .columns
            .map { $0.reversed().asArray }

        t = Matrix(rows: nr)

        return t
    }

    func part1() -> CustomStringConvertible? {
        sampleMatrix()
            .columns
            .map(tilt(_:))
            .map(columnLoad(_:))
            .sum()
    }

    func gridLoad(_ grid: Matrix<Character>) -> Int {
        grid.columns
            .map(columnLoad(_:))
            .sum()
    }

    func part2() -> CustomStringConvertible? {
        var t = sampleMatrix()
        var d: Set<Int> = []
        var a: [Int] = []

        let k = 1_000_000_000

        for i in 1 ... k {

            let nt = cycle(t)

            if d.contains(nt.columns.hashValue) {
                return a[k % i]
            } else {

                t = nt

                d.insert(nt.columns.hashValue)

                let nw = gridLoad(nt)
                a.append(nw)

                print("Cycle: \(i), load: \(nw)")
            }
        }

        return -1
    }
}
