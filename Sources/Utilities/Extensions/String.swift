public extension String {
    
    static let alphabet = "abcdefghijklmnopqrstuvwxyz"
    
    static let empty = ""
    
    var asInt: Int? {
        Int(self)
    }
    
    func matches(for regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
            
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            fatalError("Invalid regex: \(error.localizedDescription)")
        }
    }
    
    func firstMatch(for regex: String) -> String? {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            guard let result = regex.firstMatch(in: self, range: NSRange(self.startIndex..., in: self)) else { return nil }
            return String(self[Range(result.range, in: self)!])
        } catch let error {
            fatalError("Invalid regex: \(error.localizedDescription)")
        }
    }
    
    var reversed: String {
        String(reversed())
    }
}

public extension Substring {
    
    var asInt: Int? {
        asString.asInt
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
