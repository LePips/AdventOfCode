import Algorithms

struct Day5: Day {

    func mapToLocation(
        current: String = "seed",
        currentI: Int,
        destinationMap: inout [String: String],
        rangeMap: inout [String: [(ClosedRange<Int>, ClosedRange<Int>)]]
    ) -> Int {

        if current == "location" {
            return currentI
        }

        if let destRange = rangeMap[current]!.first(where: { ranges in ranges.1.contains(currentI) }) {
            let offI = currentI - destRange.1.lowerBound
            let destI = destRange.0.lowerBound + offI

            return mapToLocation(
                current: destinationMap[current]!,
                currentI: destI,
                destinationMap: &destinationMap,
                rangeMap: &rangeMap
            )
        } else {
            return mapToLocation(
                current: destinationMap[current]!,
                currentI: currentI,
                destinationMap: &destinationMap,
                rangeMap: &rangeMap
            )
        }
    }

    func mapRangesToLocations(
        current: String = "seed",
        currentR: Set<ClosedRange<Int>>,
        destinationMap: inout [String: String],
        rangeMap: inout [String: [(ClosedRange<Int>, ClosedRange<Int>)]]
    ) -> [ClosedRange<Int>] {

        if current == "location" {
            return currentR.asArray
        }

        let destRanges = rangeMap[current]!

        var t: Set<ClosedRange<Int>> = []

        outer: for range in currentR.sorted(using: \.lowerBound) {

            var range = range

            for destinationRange in destRanges {

                if range.lowerBound < destinationRange.1.lowerBound {
                    let length = Swift.min(
                        range.count,
                        destinationRange.1.lowerBound - range.lowerBound
                    )

                    t.insert(.init(start: range.lowerBound, length: length))

                    let newLength = range.count - length

                    // used up the range
                    if newLength <= 0 {
                        continue outer
                    }

                    range = .init(start: destinationRange.1.lowerBound, length: newLength)
                }

                if range.lowerBound < destinationRange.1.upperBound {
                    let length = Swift.min(
                        range.count,
                        destinationRange.1.upperBound - range.lowerBound + 1
                    )

                    // add overlapping range with mapping to destination
                    let offset = range.lowerBound - destinationRange.1.lowerBound

                    t.insert(.init(start: destinationRange.0.lowerBound + offset, length: length))

                    let newLength = range.count - length

                    // used up the range
                    if newLength <= 0 {
                        continue outer
                    }

                    range = .init(start: destinationRange.1.upperBound + 1, length: newLength)
                }
            }

            t.insert(range)
        }

        return mapRangesToLocations(
            current: destinationMap[current]!,
            currentR: t,
            destinationMap: &destinationMap,
            rangeMap: &rangeMap
        )
    }

    func part1() -> CustomStringConvertible? {

        var input = lines()
            .split(on: .empty)
            .map(\.asArray)

        let seeds = input.removeFirst()[0]
            .matches(for: "(\\d+)")
            .asInts

        let ranges = input
            .map { category in
                let title = category[0]
                    .split(on: "-")
                    .joined(separator: " ")
                    .split(on: " ")
                let source = title[0]
                let dest = title[2]

                return (source, dest, category.dropFirst())
            }
            .map { source, dest, ranges in
                let b = ranges
                    .map { $0.matches(for: "(\\d+)").asInts }
                    .map { ($0[0] ... $0[0] + $0[2] - 1, $0[1] ... $0[1] + $0[2] - 1) }

                return (source.asString, dest.asString, b)
            }

        var destinationMap = ranges
            .reduce(into: [:]) { partialResult, element in
                partialResult[element.0] = element.1
            }

        var rangeMap = ranges
            .reduce(into: [:]) { partialResult, element in
                partialResult[element.0] = element.2
            }

        return seeds
            .map { seed in
                mapToLocation(
                    currentI: seed,
                    destinationMap: &destinationMap,
                    rangeMap: &rangeMap
                )
            }
            .min()
    }

    func part2() -> CustomStringConvertible? {

        var input = lines()
            .split(on: .empty)
            .map(\.asArray)

        let seeds = input.removeFirst()[0]
            .matches(for: "(\\d+)")
            .asInts
            .chunks(ofCount: 2)
            .map(Array.init)
            .map { $0[0] ... $0[0] + $0[1] - 1 }
            .sorted(using: \.lowerBound)

        let ranges = input
            .map { category in
                let title = category[0]
                    .split(on: "-")
                    .joined(separator: " ")
                    .split(on: " ")
                let source = title[0]
                let dest = title[2]

                return (source, dest, category.dropFirst())
            }
            .map { source, dest, ranges in
                let b = ranges
                    .map { $0.matches(for: "(\\d+)").asInts }
                    .map { ($0[0] ... $0[0] + $0[2] - 1, $0[1] ... $0[1] + $0[2] - 1) }

                return (source.asString, dest.asString, b)
            }

        var destinationMap = ranges
            .reduce(into: [:]) { partialResult, element in
                partialResult[element.0] = element.1
            }

        var rangeMap = ranges
            .reduce(into: [:]) { partialResult, element in
                partialResult[element.0] = element.2.sorted(using: \.1.lowerBound)
            }

        return mapRangesToLocations(
            currentR: seeds.asSet,
            destinationMap: &destinationMap,
            rangeMap: &rangeMap
        )
        .sorted(using: \.lowerBound)
        .first!
        .lowerBound
    }
}
