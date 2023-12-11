struct Day10: Day {

    func nextPipeLocations(from location: (x: Int, y: Int), input: Matrix<Character>) -> [(x: Int, y: Int)] {
        let x = location.x
        let y = location.y

        var t: [(Int, Int)] = []

        // can go north
        if y > 0 && ["|", "L", "J", "S"].contains(input[x, y]) {
            switch input[x, y - 1] {
            case "7", "F", "|":
                t.append((x, y - 1))
            default: ()
            }
        }

        // can go south
        if y < input.height - 1 && ["|", "7", "F", "S"].contains(input[x, y]) {
            switch input[x, y + 1] {
            case "L", "J", "|":
                t.append((x, y + 1))
            default: ()
            }
        }

        // can go west
        if location.x > 0 && ["-", "7", "J", "S"].contains(input[x, y]) {
            switch input[x - 1, y] {
            case "L", "F", "-":
                t.append((x - 1, y))
            default: ()
            }
        }

        // can go east
        if location.x < input.width - 1 && ["-", "L", "F", "S"].contains(input[x, y]) {
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

        // there will only ever be at most one non -1 pipe since we just
        // came in from one of them
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

    func stepThroughLoop(
        input: Matrix<Character>,
        startLocation: (x: Int, y: Int),
        steps: inout Matrix<Int>
    ) {
        steps[startLocation.x, startLocation.y] = 0
        traverse(from: startLocation, step: 1, in: input, steps: &steps)
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

        stepThroughLoop(input: input, startLocation: startNextLocations[0], steps: &steps)

        let t = steps[startNextLocations[1].x, startNextLocations[1].y]

        return (t + 2) / 2
    }

    func possiblePipe(from a: (x: Int, y: Int), to b: (x: Int, y: Int)) -> Set<Character> {
        if a.x == b.x {
            if a.y - b.y == 1 {
                return ["|", "L", "J"]
            } else {
                return ["|", "F", "7"]
            }
        } else {
            // a.y == b.y
            if a.x - b.x == 1 {
                return ["-", "7", "J"]
            } else {
                return ["-", "L", "F"]
            }
        }
    }

    func replacingStart(input: Matrix<Character>) -> Matrix<Character> {
        let start = input.firstLocation(where: { $0 == "S" })!
        let startNextLocations = nextPipeLocations(from: start, input: input)

        let replaceStart = startNextLocations
            .map { possiblePipe(from: (start.x, start.y), to: $0) }
            .reduce(into: ["-", "7", "J", "F", "L"].asSet) { partialResult, s in
                partialResult = partialResult.intersection(s)
            }
            .asArray[0]

        let new = input
        new[start.x, start.y] = replaceStart
        return new
    }

    func part2() -> CustomStringConvertible? {
        let input = matrix()

        var steps = Matrix(
            width: input.width,
            height: input.height,
            repeating: -1
        )

        let start = input.firstLocation(where: { $0 == "S" })!
        let startNextLocations = nextPipeLocations(from: start, input: input)

        stepThroughLoop(input: input, startLocation: startNextLocations[0], steps: &steps)

        // replace start with pipe type and replace pipes not in main loop with ground
        let replacedGrid = replacingStart(input: input)

        steps[start.x, start.y] = 0

        for i in 0 ..< steps.area {
            if steps[i] == -1 {
                replacedGrid[i] = "."
            }
        }

        let startPipes: [Character] = ["L", "F"]
        let endPipes: [Character] = ["J", "7"]

        let output = replacedGrid
            .rows
            .map { row in
                var i = 0
                var t = 0
                var edgeStartPipe: Character? = nil

                for c in row {
                    if c == "." && i % 2 == 1 {
                        t += 1
                    } else if c == "|" {
                        i += 1
                    } else if startPipes.contains(c) {
                        edgeStartPipe = c
                    } else if endPipes.contains(c) {
                        switch (edgeStartPipe, c) {
                        case ("L", "J"), ("F", "7"):
                            i += 2
                        case ("L", "7"), ("F", "J"):
                            i += 1
                        default: ()
                        }
                    }
                }

                return t
            }
            .sum()

        return output
    }
}
