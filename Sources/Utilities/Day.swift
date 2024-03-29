public protocol Day {

    func input(_ file: String) -> Input

    func part1() -> CustomStringConvertible?
    func part2() -> CustomStringConvertible?
}

public extension Day {

    func input(_ file: String = #filePath) -> Input {
        Input(filePath: file.replacingOccurrences(of: ".swift", with: ".txt"))
    }

    func lines(_ file: String = #filePath) -> [String] {
        Input(filePath: file.replacingOccurrences(of: ".swift", with: ".txt"))
            .lines
    }

    func matrix(_ file: String = #filePath) -> Matrix<Character> {
        let input = Input(
            filePath: file.replacingOccurrences(
                of: ".swift",
                with: ".txt"
            )
        )
        .lines
        .map(\.asArray)

        return Matrix(rows: input)
    }

    func sampleInput(_ file: String = #filePath) -> Input {
        Input(
            filePath: file
                .split(separator: ".")[0]
                .appending("Sample")
                .appending(".txt")
        )
    }

    func sampleLines(_ file: String = #filePath) -> [String] {
        Input(
            filePath: file
                .split(separator: ".")[0]
                .appending("Sample")
                .appending(".txt")
        )
        .lines
    }

    func sampleMatrix(_ file: String = #filePath) -> Matrix<Character> {
        let input = Input(
            filePath: file
                .split(separator: ".")[0]
                .appending("Sample")
                .appending(".txt")
        )
        .lines
        .map(\.asArray)

        return Matrix(rows: input)
    }
}
