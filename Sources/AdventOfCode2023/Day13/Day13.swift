struct Day13: Day {

    func f(_ grid: Matrix<Character>, _ smudges: Int) -> Int {
        var r = 0
        var n = 2
        let c = grid.columns

        while n <= grid.width {
            let fh = c[..<(n / 2)]
                .reversed()
            let sh = c[(n / 2) ... (n - 1)]
            let d = zip(fh, sh)
                .asArray
                .map { $0.0.differences(against: $0.1) }
                .sum()

            if d == smudges {
                r = n
            }

            n += 2
        }

        return r
    }

    func g(_ grid: Matrix<Character>, _ smudges: Int) -> Int {
        // vertical
        let a = f(grid, smudges)

        if a > 0 {
            return a / 2
        }

        let b = f(grid.yFlipped(), smudges)

        if b > 0 {
            return grid.width - b / 2
        }

        // horizontal
        let t = grid.transposed()

        let c = f(t, smudges)

        if c > 0 {
            return (c / 2) * 100
        }

        let d = f(t.yFlipped(), smudges)

        if d > 0 {
            return (grid.height - (d / 2)) * 100
        }

        fatalError()
    }

    func part1() -> CustomStringConvertible? {
        lines()
            .split(on: .empty)
            .map { Matrix(rows: $0.map(\.asArray)) }
            .map { g($0, 0) }
            .sum()
    }

    func part2() -> CustomStringConvertible? {
        lines()
            .split(on: .empty)
            .map { Matrix(rows: $0.map(\.asArray)) }
            .map { g($0, 1) }
            .sum()
    }
}
