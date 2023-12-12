struct Day11: Day {

    func f(_ grid: Matrix<Character>, expand: Int) -> Int {
        let galaxies = grid.locations(where: { $0 == "#" })
            .map {
                var nx = $0.x
                var ny = $0.y

                for x in 0 ..< nx {
                    if grid.column(x).allEqual(".") {
                        nx += expand - 1
                    }
                }

                for y in 0 ..< ny {
                    if grid.row(y).allEqual(".") {
                        ny += expand - 1
                    }
                }

                return Coordinate(x: nx, y: ny)
            }

        return galaxies
            .enumerated()
            .map {
                var t: [(Coordinate<Int>, Coordinate<Int>)] = []

                for i in $0.offset + 1 ..< galaxies.count {
                    t.append(($0.element, galaxies[i]))
                }

                return t
            }
            .flatMap { $0 }
            .map(manhattanDistance)
            .sum()
    }

    func part1() -> CustomStringConvertible? {
        f(matrix(), expand: 2)
    }

    func part2() -> CustomStringConvertible? {
        f(matrix(), expand: 1_000_000)
    }
}
