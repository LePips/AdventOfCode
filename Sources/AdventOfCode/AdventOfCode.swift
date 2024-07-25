import AdventOfCode2015
import AdventOfCode2022
import AdventOfCode2023

enum _AdventOfCode {

    static var years: [any Year] = [
        _AdventOfCode2015(),
        _AdventOfCode2022(),
        _AdventOfCode2023(),
    ]

    static func year(_ year: Int) -> any Year {
        years.first(where: { $0.tag == year })!
    }
}
