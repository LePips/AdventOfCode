import AdventOfCode2022

struct _AdventOfCode {
    
    static var years: [any Year] = [
        _AdventOfCode2022(),
    ]
    
    static func year(_ year: Int) -> any Year {
        Self.years.first(where: { $0.tag == year })!
    }
}
