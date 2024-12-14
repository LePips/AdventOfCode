struct Day11: Day {
    
    func blink(stoneCounts: [Int: Int]) -> [Int: Int] {
        var newStones: [Int: Int] = [:]
        
        for (s, c) in stoneCounts {
            if s == 0 {
                newStones[1, default: 0] += c
            } else if "\(s)".count.isEven {
                let ss = Array("\(s)")
                let l = String(ss[0 ..< ss.count / 2]).asInt!
                let r = String(ss[ss.count / 2 ..< ss.count]).asInt!
                
                newStones[l, default: 0] += c
                newStones[r, default: 0] += c
            } else {
                newStones[s * 2024, default: 0] += c
            }
        }
        
        return newStones
    }

    func part1() -> CustomStringConvertible? {
        
        var stones = lines()[0]
            .split(on: " ")
            .map { $0.asInt!}
            .counted()
        
        for _ in 0 ..< 25 {
            stones = blink(stoneCounts: stones)
        }
        
        return stones.values.sum()
    }

    func part2() -> CustomStringConvertible? {
        
        var stones = lines()[0]
            .split(on: " ")
            .map { $0.asInt!}
            .counted()
        
        for _ in 0 ..< 75 {
            stones = blink(stoneCounts: stones)
        }
        
        return stones.values.sum()
    }
}
