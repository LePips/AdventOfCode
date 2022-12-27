struct Day4: Day {
    
    func part1() -> CustomStringConvertible? {
        input()
            .lines
            .map { $0.split(on: ",") }
            .map { ($0[0].split(on: "-").asInts, $0[1].split(on: "-").asInts) }
            .map { ($0.0[0]..<$0.0[1] + 1, $0.1[0]..<$0.1[1] + 1) }
            .map { $0.0.isSupersetOf($0.1) || $0.1.isSupersetOf($0.0) }
            .map { $0.asInt }
            .sum()
    }
    
    func part2() -> CustomStringConvertible? {
        input()
            .lines
            .map { $0.split(on: ",") }
            .map { ($0[0].split(on: "-").asInts, $0[1].split(on: "-").asInts) }
            .map { ($0.0[0]..<$0.0[1] + 1, $0.1[0]..<$0.1[1] + 1) }
            .map { $0.0.overlaps($0.1) }
            .map { $0.asInt }
            .sum()
    }
}
