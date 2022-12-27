public extension Bool {
    
    var asInt: Int {
        if self {
            return 1
        } else {
            return 0
        }
    }
}
