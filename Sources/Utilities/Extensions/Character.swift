public extension Character {
    
    var asInt: Int? {
        asString.asInt
    }
    
    var asString: String {
        String(self)
    }
}
