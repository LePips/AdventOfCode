public extension Character {
    
    var asInt: Int? {
        Int(self.asString)
    }
    
    var asString: String {
        String(self)
    }
}
