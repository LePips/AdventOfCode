// TODO: rename to Grid
// TODO: conform to Collection?

public struct Matrix<Element: CustomStringConvertible> {

    public private(set) var rows: [[Element]]

    public var columns: [[Element]] {
        (0 ..< width)
            .map {
                column($0)
            }
    }

    public var isEmpty: Bool {
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

    mutating public func insert(row: [Element], at y: Int) {
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

    public subscript(c: Coordinate) -> Element {
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

    public func firstLocation(where predicate: (Element) -> Bool) -> Coordinate? {
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

    public func locations(where predicate: (Element) -> Bool) -> [Coordinate] {
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
    
    public func contains(c: Coordinate) -> Bool {
        c.x >= 0 && c.y >= 0
            && c.x < width && c.y < height
    }
    
    public func count(where predicate: (Element) -> Bool) -> Int {
        rows
            .map { $0.count(where: predicate) }
            .sum()
    }
    
    public func map<T>(_ transform: (Element) -> T) -> Matrix<T> {
        Matrix<T>(rows: rows.map { $0.map(transform) })
    }
}

public extension Matrix {

    init(width: Int, height: Int, repeating value: Element) {
        let rows = Array(repeating: Array(repeating: value, count: width), count: height)
        self.init(rows: rows)
    }

    init(columns: [[Element]]) {

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
    
    func min() -> Element? {
        rows
            .compactMap { $0.min() }
            .min()
    }
}

public extension Matrix where Element: Equatable {
    
    func firstLocation(of element: Element) -> Coordinate? {
        firstLocation(where: { $0 == element })
    }
    
    func locations(of element: Element) -> [Coordinate] {
        locations(where: { $0 == element })
    }
    
    func count(of element: Element) -> Int {
        count(where: { $0 == element })
    }
}

public extension Matrix where Element: Hashable {
    
    func counts() -> [Element: Int] {
        rows
            .flatMap { $0 }
            .counted()
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

extension Matrix where Element == Int {

    public func _inverted2D() -> Matrix<Double>? {
        guard width == 2 && height == 2 else {
            fatalError("Attempted to inverse a non-2x2 matrix")
        }
        
        let determinant = rows[0][0] * rows[1][1] - rows[0][1] * rows[1][0]
        
        guard determinant != 0 else { return nil }
        
        let dDeterminant = Double(determinant)
        
        let r1 = [Double(rows[1][1]) / dDeterminant, Double(-rows[0][1]) / dDeterminant]
        let r2 = [Double(-rows[1][0]) / dDeterminant, Double(rows[0][0]) / dDeterminant]
        
        return Matrix<Double>(rows: [r1, r2])
    }
    
    public func _multiplyScalar(_ scalar: Int) -> Matrix<Int> {
        map { $0 * scalar }
    }
    
    public func _multiply(_ other: Matrix<Element>) -> Matrix<Element>? {
        guard width == other.height else {
            fatalError("Attempted to multiply two matrices with incompatible dimensions")
        }
        
        let newRows = (0 ..< height)
            .map { y in
                (0 ..< other.width)
                    .map { x in
                        (0 ..< width)
                            .map { i in
                                rows[y][i] * other.rows[i][x]
                            }
                            .sum()
                    }
            }
        
        return Matrix<Element>(rows: newRows)
    }
}

extension Matrix where Element == Double {
    
    public func _multiply(_ other: Matrix<Double>) -> Matrix<Double>? {
        guard width == other.height else {
            fatalError("Attempted to multiply two matrices with incompatible dimensions")
        }
        
        let newRows = (0 ..< height)
            .map { y in
                (0 ..< other.width)
                    .map { x in
                        (0 ..< width)
                            .map { i in
                                rows[y][i] * other.rows[i][x]
                            }
                            .sum()
                    }
            }
        
        return Matrix<Double>(rows: newRows)
    }
}
