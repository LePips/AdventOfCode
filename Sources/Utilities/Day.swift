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
}
