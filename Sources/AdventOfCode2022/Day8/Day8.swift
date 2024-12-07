struct Day8: Day {

    func visible(with eyeline: ArraySlice<Int>, value: Int) -> Bool {
        eyeline.allSatisfy { $0 < value }
    }

    func visibleTreeCount(along eyeline: ArraySlice<Int>, value: Int) -> Int {
        visibleTreeCount(along: eyeline.asArray, value: value)
    }

    func visibleTreeCount(along eyeline: ReversedCollection<ArraySlice<Int>>, value: Int) -> Int {
        visibleTreeCount(along: eyeline.asArray, value: value)
    }

    func visibleTreeCount(along eyeline: [Int], value: Int) -> Int {
        var a: Int = 0

        for tree in eyeline {
            if tree >= value {
                a += 1
                break
            } else {
                a += 1
            }
        }

        return a
    }

    func part1() -> CustomStringConvertible? {
        let matrix = matrix()
            .map(\.asInt!)

        return (0 ..< matrix.area)
            .map { matrix[$0] }
            .enumerated()
            .reduce(0) { partialResult, pair in
                let rowI = pair.offset / matrix.width
                let columnJ = pair.offset % matrix.width

                let row = matrix.row(rowI)
                let column = matrix.column(columnJ)

                let visible = visible(with: row[0 ..< columnJ], value: pair.element) ||
                    visible(with: row[columnJ + 1 ..< matrix.width], value: pair.element) ||
                    visible(with: column[0 ..< rowI], value: pair.element) ||
                    visible(with: column[rowI + 1 ..< matrix.height], value: pair.element)

                return partialResult + visible.asInt
            }
    }

    func part2() -> CustomStringConvertible? {
        let matrix = matrix()
            .map(\.asInt!)

        let t = (0 ..< matrix.area)
            .map { matrix[$0] }
            .enumerated()
            .map { pair in

                let rowI = pair.offset / matrix.width
                let columnJ = pair.offset % matrix.width

                let row = matrix.row(rowI)
                let column = matrix.column(columnJ)

                return visibleTreeCount(along: row[0 ..< columnJ].reversed(), value: pair.element) *
                    visibleTreeCount(along: row[columnJ + 1 ..< matrix.width], value: pair.element) *
                    visibleTreeCount(along: column[0 ..< rowI].reversed(), value: pair.element) *
                    visibleTreeCount(along: column[rowI + 1 ..< matrix.height], value: pair.element)
            }
        
        return t.max()!
    }
}
