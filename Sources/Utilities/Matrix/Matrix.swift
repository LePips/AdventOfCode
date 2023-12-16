// TODO: rename to Grid
// TODO: conform to Collection?

public class Matrix<Element: CustomStringConvertible> {

    public private(set) var rows: [[Element]]

    public var columns: [[Element]] {
        (0 ..< width)
            .map {
                column($0)
            }
    }

    var isEmpty: Bool {
        area == 0
    }

    public var area: Int {
        width * height
    }

    public var height: Int {
        rows.count
    }

    public var width: Int {
        rows[0].count
    }

    public init(rows: [[Element]]) {
        self.rows = rows
    }

    public func column(_ x: Int) -> [Element] {
        rows
            .reduce([]) { partialResult, row in
                partialResult.appending(row[x])
            }
    }

    public func row(_ y: Int) -> [Element] {
        rows[y]
    }

    public func insert(row: [Element], at y: Int) {
        assert(row.count == width)

        rows.insert(row, at: y)
    }

    public subscript(x: Int, y: Int) -> Element {
        get {
            rows[y][x]
        }
        set(newValue) {
            rows[y][x] = newValue
        }
    }

    public subscript(c: Coordinate<Int>) -> Element {
        get {
            rows[c.y][c.x]
        }
        set(newValue) {
            rows[c.y][c.x] = newValue
        }
    }

    public subscript(i: Int) -> Element {
        get {
            rows[i / width][i % width]
        }
        set(newValue) {
            rows[i / width][i % width] = newValue
        }
    }

    public func firstLocation(where predicate: (Element) -> Bool) -> Coordinate<Int>? {
        guard let y = rows.firstIndex(where: { $0.contains(where: predicate) }),
              let x = rows[y].firstIndex(where: predicate) else { return nil }

        return .init(x: x, y: y)
    }

    public func transposed() -> Matrix<Element> {
        let newRows = (0 ..< width)
            .map {
                column($0)
            }

        return Matrix(rows: newRows)
    }

    public func yFlipped() -> Matrix<Element> {
        let columns = (0 ..< width)
            .map {
                column($0)
            }
            .reversed()
            .asArray

        let newRows = (0 ..< height)
            .map { i in
                columns.map { $0[i] }
            }

        return Matrix(rows: newRows)
    }

    public func locations(where predicate: (Element) -> Bool) -> [Coordinate<Int>] {
        rows
            .map { $0.enumerated() } // x
            .map { $0.filter { predicate($0.element) } }
            .enumerated() // y
            .map { row in
                row
                    .element
                    .map { Coordinate(x: $0.offset, y: row.offset) }
            }
            .flatMap { $0 }
    }
}

public extension Matrix {

    convenience init(width: Int, height: Int, repeating value: Element) {
        let rows = Array(repeating: Array(repeating: value, count: width), count: height)
        self.init(rows: rows)
    }

    convenience init(columns: [[Element]]) {

        guard let f = columns.first else {
            self.init(rows: [])
            return
        }

        var rows: [[Element]] = []

        for i in 0 ..< f.count {
            var t: [Element] = []

            for column in columns {
                t.append(column[i])
            }

            rows.append(t)
        }

        self.init(rows: rows)
    }
}

public extension Matrix where Element: Comparable {

    func max() -> Element? {
        rows
            .compactMap { $0.max() }
            .max()
    }
}

extension Matrix: CustomStringConvertible {

    public var description: String {
        var r = "\n[\n"

        for row in rows {
            for i in 0 ..< row.count - 1 {
                r.append(row[i].description)
                r.append(" ")
            }

            r.append(row.last!.description)

            r.append("\n")
        }

        r.append("]")

        return r
    }
}
