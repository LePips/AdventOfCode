import Foundation
import Utilities

struct AdventRunner {

    func run(year: Int, day: Int) {

        print(header(year: year, day: day))

        let day = _AdventOfCode
            .year(year)
            .day(day)

        part1(of: day)
        part2(of: day)
    }

    private func part1(of day: any Day) {
        let startTime = Date()

        guard let output = day.part1() else {
            print("Part 1: not implemented\n")
            return
        }

        let endTime = Date()

        let runtime = endTime.timeIntervalSince(startTime)

        let message = message(
            part: 1,
            output: output,
            runtime: runtime
        )

        print(message)
    }

    private func part2(of day: any Day) {
        let startTime = Date()

        guard let output = day.part2() else {
            print("Part 2: not implemented\n")
            return
        }

        let endTime = Date()

        let runtime = endTime.timeIntervalSince(startTime)

        let message = message(
            part: 2,
            output: output,
            runtime: runtime
        )

        print(message)
    }

    private func header(
        year: Int,
        day: Int
    ) -> String {
        """
        \(year) - Day \(day)\n
        """
    }

    private func message(
        part: Int,
        output: CustomStringConvertible,
        runtime: TimeInterval
    ) -> String {
        """
        Part \(part): \(output)
        -- runtime: \(runtime)\n
        """
    }
}
