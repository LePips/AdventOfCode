struct Day5: Day {
    
    func f(_ s: String) -> Bool {
        
        var v = 0
        var d = false
        
        if String.vowels.contains(s.first!) {
            v += 1
        }
        
        for i in s.windows(ofCount: 2) {
            let w = String(i)
            
            if ["ab", "cd", "pq", "xy"].contains(w) {
                return false
            }
            
            if String.vowels.contains(w[w.index(after: w.startIndex)]) {
                v += 1
            }
            
            if w[w.startIndex] == w[w.index(after: w.startIndex)] {
                d = true
            }
        }
        
        return v >= 3 && d
    }

    func part1() -> CustomStringConvertible? {
        lines()
            .filter(f)
            .count
    }
    
    func hasNonOverlappingPair(_ s: String) -> Bool {
        
        let count = s.count
        
        for i in 0 ..< count - 2 {
            
            let a = s[s.index(s.startIndex, offsetBy: i)]
            let b = s[s.index(s.startIndex, offsetBy: i + 1)]
            let p = "\(a)\(b)"
            
            for j in i + 2 ..< count - 1 {
                let a = s[s.index(s.startIndex, offsetBy: j)]
                let b = s[s.index(s.startIndex, offsetBy: j + 1)]
                let op = "\(a)\(b)"
                
                if p == op {
                    return true
                }
            }
        }
        
        return false
    }
    
    func hasBoundaryTriple(_ s: String) -> Bool {
        
        for t in s.windows(ofCount: 3) {
            if t.first == t.last {
                return true
            }
        }
        
        return false
    }

    func part2() -> CustomStringConvertible? {
        lines()
            .filter(hasNonOverlappingPair(_:))
            .filter(hasBoundaryTriple(_:))
            .count
    }
}
