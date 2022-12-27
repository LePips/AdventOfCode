public extension String {
    
    static let alphabet = "abcdefghijklmnopqrstuvwxyz"
    
    static let empty = ""
    
    var asInt: Int {
        Int(self)!
    }
}

public extension Substring {
    
    var asString: String {
        String(self)
    }
}
