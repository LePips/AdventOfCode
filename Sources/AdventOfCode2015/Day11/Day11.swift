struct Day11: Day {
    
    func firstRule(_ s: String) -> Bool {
        let a = s.windows(ofCount: 3)
            .map(Array.init)
            .contains { ss -> Bool in
                let a = (ss[0].asciiValue! + 1) == ss[1].asciiValue!
                let b = (ss[1].asciiValue! + 1) == ss[2].asciiValue!
                
                return a && b
            }
        
        return a
    }
    
    func secondRule(_ s: String) -> Bool {
        !s.contains { c in
            c == "i" ||
            c == "o" ||
            c == "l"
        }
    }
    
    func thirdRule(_ s: String) -> Bool {
        let count = s.count
        
        for i in 0 ..< count - 2 {
            
            let a = s[s.index(s.startIndex, offsetBy: i)]
            let b = s[s.index(s.startIndex, offsetBy: i + 1)]
            
            if a != b {
                continue
            }
            
            for j in i + 2 ..< count - 1 {
                let a = s[s.index(s.startIndex, offsetBy: j)]
                let b = s[s.index(s.startIndex, offsetBy: j + 1)]
                
                if a == b {
                    return true
                }
            }
        }
        
        return false
    }
    
    func increment(_ s: String) -> String {
        
        var s = Array(s)
        var i = s.count - 1
        
        while i >= 0 {
            let nc = increment(s[i])
            
            s[i] = nc.nc
            
            if !nc.carry {
                break
            }
            
            i -= 1
        }
        
        return String(s)
    }
    
    func increment(_ c: Character) -> (nc: Character, carry: Bool) {
        
        guard c != "z" else { return (nc: "a", carry: true) }
        
        return (nc: Character(asciiValue: c.asciiValue! + 1), carry: false)
    }
    
    func isValid(_ s: String) -> Bool {
        firstRule(s) && secondRule(s) && thirdRule(s)
    }

    func part1() -> CustomStringConvertible? {
        var s = lines()
            .first!
        
        while !isValid(s) {
            s = increment(s)
        }
        
        return s
    }

    func part2() -> CustomStringConvertible? {
        var s = increment("\(part1()!)")
        
        while !isValid(s) {
            s = increment(s)
        }
        
        return s
    }
}
