public extension Character {

    var asInt: Int? {
        asString.asInt
    }

    var asString: String {
        String(self)
    }
    
    init(asciiValue: UInt8) {
        self.init(UnicodeScalar(asciiValue))
    }
}
