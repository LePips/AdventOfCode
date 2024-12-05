struct Day1: Day {

    func part1() -> CustomStringConvertible? {
        let cs = lines()
            .map { $0.split(on: " ") }
        
        let l = cs.map { $0[0] }
            .map { Int($0)! }
            .sorted()
        
        let r = cs.map { $0[1] }
            .map { Int($0)! }
            .sorted()
        
        return zip(l, r)
            .map { abs($0 - $1)}
            .sum()
    }

    func part2() -> CustomStringConvertible? {
        let cs = lines()
            .map { $0.split(on: " ") }
        
        let l = cs.map { $0[0] }
            .map { Int($0)! }
            .sorted()
        
        let r = cs.map { $0[1] }
            .map { Int($0)! }
            .sorted()
        
        let ris = r.counted()
        
        return l.reduce(0) { partialResult, li in
            partialResult + (li * (ris[li] ?? 0))
        }
    }
}
