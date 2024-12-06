struct Day16: Day {

    struct Key: Hashable {
        let c: Coordinate
        let d: Int
    }

    func f(
        _ c: Coordinate,
        _ g: Matrix<Character>,
        _ d: Int, // 0 north, clockwise
        _ e: inout Set<Key>
    ) {
        if c.x < 0 || c.x == g.width || c.y < 0 || c.y == g.height {
            return
        }

        let k = Key(c: c, d: d)
        guard !e.contains(k) else { return }

        e.insert(k)

        switch (g[c], d) {
        case (".", 0), ("|", 0):
            f(.init(x: c.x, y: c.y - 1), g, d, &e)
        case (".", 1), ("-", 1):
            f(.init(x: c.x + 1, y: c.y), g, d, &e)
        case (".", 2), ("|", 2):
            f(.init(x: c.x, y: c.y + 1), g, d, &e)
        case (".", 3), ("-", 3):
            f(.init(x: c.x - 1, y: c.y), g, d, &e)
        case ("|", 1), ("|", 3):
            f(.init(x: c.x, y: c.y - 1), g, 0, &e)
            f(.init(x: c.x, y: c.y + 1), g, 2, &e)
        case ("-", 0), ("-", 2):
            f(.init(x: c.x + 1, y: c.y), g, 1, &e)
            f(.init(x: c.x - 1, y: c.y), g, 3, &e)
        case ("/", 0), ("\\", 2):
            f(.init(x: c.x + 1, y: c.y), g, 1, &e)
        case ("/", 1), ("\\", 3):
            f(.init(x: c.x, y: c.y - 1), g, 0, &e)
        case ("/", 2), ("\\", 0):
            f(.init(x: c.x - 1, y: c.y), g, 3, &e)
        case ("/", 3), ("\\", 1):
            f(.init(x: c.x, y: c.y + 1), g, 2, &e)
        default:
            fatalError()
        }
    }

    func t(_ c: Coordinate, _ d: Int, _ g: Matrix<Character>) -> Int {
        var e: Set<Key> = []

        f(c, g, d, &e)

        return e.uniqued(on: { $0.c })
            .count
    }

    func part1() -> CustomStringConvertible? {
        t(.init(x: 0, y: 0), 1, matrix())
    }

    func part2() -> CustomStringConvertible? {
        let g = matrix()

        let top = (0 ..< g.width)
            .map { t(.init(x: $0, y: 0), 2, g) }

        let bottom = (0 ..< g.width)
            .map { t(.init(x: $0, y: g.height - 1), 0, g) }

        let leading = (0 ..< g.height)
            .map { t(.init(x: 0, y: $0), 1, g) }

        let trailing = (0 ..< g.height)
            .map { t(.init(x: g.width - 1, y: $0), 3, g) }

        return [top, bottom, leading, trailing]
            .flatMap { $0 }
            .max()!
    }
}
