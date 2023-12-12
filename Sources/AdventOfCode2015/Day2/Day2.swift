struct Day2: Day {

    // 2*l*w + 2*w*h + 2*h*l
    func part1() -> CustomStringConvertible? {
        let sides = lines()
            .map { $0.split(on: "x").asInts }

        return sides
            .map { sides in
                [
                    sides[0] * sides[1],
                    sides[0] * sides[2],
                    sides[1] * sides[2],
                ]
            }
            .map { areas in
                (areas.min()!, areas)
            }
            .map {
                $0.0 + $0.1.sum() * 2
            }
            .sum()
    }

    func part2() -> CustomStringConvertible? {
        let sides = lines()
            .map { $0.split(on: "x").asInts }

        return sides
            .map { sides in
                sides.product() + sides.min(count: 2).sum() * 2
            }
            .sum()
    }
}
