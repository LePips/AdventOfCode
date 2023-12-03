struct Day1: Day {
    
    func part1() -> CustomStringConvertible? {
        let input = input().raw
        
        let p = input.count(of: "(")
        let n = input.count(of: ")")
        
        return p - n
    }
    
    func part2() -> CustomStringConvertible? {
        let input = input().raw
        
        let t = 1
        var l = 0
        
        for (i, c) in input.enumerated() {
            if c == ")" && l == 0 {
                return i + 1
            } else if c == "(" {
                l += 1
            } else if c == ")" {
                l -= 1
            }
        }
        
        return nil
    }
}
