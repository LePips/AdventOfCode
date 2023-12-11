struct Day10: Day {

    func nextPipeLocations(from location: (x: Int, y: Int), input: Matrix<Character>) -> [(x: Int, y: Int)] {
        let x = location.x
        let y = location.y

        var t: [(Int, Int)] = []

        // can go north
        if y > 0 {
            switch input[x, y - 1] {
            case "7", "F", "|":
                t.append((x, y - 1))
            default: ()
            }
        }

        // can go south
        if y < input.height - 1 {
            switch input[x, y + 1] {
            case "L", "J", "|":
                t.append((x, y + 1))
            default: ()
            }
        }

        // can go west
        if location.x > 0 {
            switch input[x - 1, y] {
            case "L", "F", "-":
                t.append((x - 1, y))
            default: ()
            }
        }

        // can go east
        if location.x < input.width - 1 {
            switch input[x + 1, y] {
            case "J", "7", "-":
                t.append((x + 1, y))
            default: ()
            }
        }

        return t
    }

    func traverse(
        from location: (x: Int, y: Int),
        step: Int,
        in input: Matrix<Character>,
        steps: inout Matrix<Int>
    ) {

        steps[location.x, location.y] = step

        let nextPipes = nextPipeLocations(from: location, input: input)
            .filter { steps[$0.x, $0.y] == -1 }

        for pipe in nextPipes {
            traverse(
                from: pipe,
                step: step + 1,
                in: input,
                steps: &steps
            )
        }
    }

    func part1() -> CustomStringConvertible? {
        let input = matrix()

        var steps = Matrix(
            width: input.width,
            height: input.height,
            repeating: -1
        )

        // perform DFS exiting a direction, get cycle count - 2 incoming from the other
        let start = input.firstLocation(where: { $0 == "S" })!
        let startNextLocations = nextPipeLocations(from: start, input: input)

        steps[start.x, start.y] = 0
        traverse(from: startNextLocations[0], step: 1, in: input, steps: &steps)

        let t = steps[startNextLocations[1].x, startNextLocations[1].y]

        return (t + 2) / 2
    }

    func part2() -> CustomStringConvertible? {

//        let edgePipes: [Character] = ["|", "L", "J", "7", "F"]
        let startPipes: [Character] = ["L", "F"]
//        let endPipes: [Character] = ["J", "7"]

        let input = sampleMatrix()
            .rows
            .map { row in
                var i = 0
//                var t = 0
                var t: [Character] = []
                var isInEdge = false

                for c in row {
                    if c == "." && i % 2 == 1 {
                        t += "*"
                        continue
                    } else if c == "|" {
                        i += 1
                    } else if startPipes.contains(c) && i % 2 == 1 {}

                    t.append(c)
                }

                return t
            }
//            .sum()

        return Matrix(rows: input)
    }
}
