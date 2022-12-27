public final class Input {
    
    public let raw: String
    
    public lazy var lines: Array<String> = {
        raw.components(separatedBy: .newlines)
            .trimmed()
    }()
    
    init(filePath: String) {
        guard let input = try? String(contentsOfFile: filePath) else { fatalError("Unable to get input") }
        
        self.raw = input
    }
}
