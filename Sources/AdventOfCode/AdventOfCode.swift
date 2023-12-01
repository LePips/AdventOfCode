import AdventOfCode2022
import AdventOfCode2023

struct _AdventOfCode {
    
    static var years: [any Year] = [
        _AdventOfCode2022(),
        _AdventOfCode2023(),
    ]
    
    static func year(_ year: Int) -> any Year {
        Self.years.first(where: { $0.tag == year })!
    }
}
