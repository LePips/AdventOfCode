public extension String {
    
    static let alphabet = "abcdefghijklmnopqrstuvwxyz"
    
    static let empty = ""
    
    var asInt: Int {
        Int(self)!
    }
}

public extension Substring {
    
    var asInt: Int? {
        Int(self.asString)
    }
    
    var asString: String {
        String(self)
    }
}

extension Array<String> {
    
    func trimmed() -> Self {
        var copy = self
        copy.trim(while: { $0.isEmpty })
        return copy
    }
}
