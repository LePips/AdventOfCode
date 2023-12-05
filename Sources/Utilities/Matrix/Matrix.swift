public class Matrix<Value> {

    public let raw_rows: [[Value]]

    public var area: Int {
        width * height
    }

    public var height: Int {
        raw_rows.count
    }

    public var width: Int {
        raw_rows[0].count
    }

    public init(rows: [[Value]]) {
        self.raw_rows = rows
    }

    public func column(_ i: Int) -> [Value] {
        raw_rows
            .reduce([]) { partialResult, row in
                partialResult.appending(row[i])
            }
    }

    public func row(_ i: Int) -> [Value] {
        raw_rows[i]
    }

    public func value(at i: Int) -> Value {
        raw_rows[i / width][i % width]
    }

    public func value(i: Int, j: Int) -> Value {
        raw_rows[i][j]
    }
}
