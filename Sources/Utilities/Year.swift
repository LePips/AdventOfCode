public protocol Year {

    var days: [any Day] { get }
    var tag: Int { get }

    init()
}

public extension Year {

    func day(_ day: Int) -> any Day {
        guard day >= 1 && day <= 25 else { fatalError("Wrong advent date") }
        return days[day - 1]
    }
}
