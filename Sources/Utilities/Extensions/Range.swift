public extension Range {
    
    func isSupersetOf(_ other: Self) -> Bool {
        other.clamped(to: self) == other
    }
}
