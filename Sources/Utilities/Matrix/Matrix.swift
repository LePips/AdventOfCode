// TODO: rename to Grid
// TODO: conform to Collection?

public class Matrix<Element: CustomStringConvertible> {

    public private(set) var rows: [[Element]]

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

    public subscript(i: Int) -> Element {
        rows[i / width][i % width]
    }

    public func firstLocation(where predicate: (Element) -> Bool) -> Coordinate<Int>? {
        guard let y = rows.firstIndex(where: { $0.contains(where: predicate) }),
              let x = rows[y].firstIndex(where: predicate) else { return nil }

        return (x, y)
    }

    public func transposed() -> Matrix<Element> {
        let newRows = (0 ..< width)
            .map {
                column($0)
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
                    .map { (x: $0.offset, y: row.offset) }
            }
            .flatMap { $0 }
    }
}

public extension Matrix {

    convenience init(width: Int, height: Int, repeating value: Element) {
        let rows = Array(repeating: Array(repeating: value, count: width), count: height)
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
