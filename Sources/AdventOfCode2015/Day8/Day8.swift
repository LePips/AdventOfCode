struct Day8: Day {
    
    func f(_ s: String) -> Int {
        
        var t = 0
        
        let count = s.count
        var i = 0
        
        while i < count {
            let a = s[s.index(s.startIndex, offsetBy: i)]
            
            if a == "\\" {
                let b = s[s.index(s.startIndex, offsetBy: i + 1)]
                
                switch b {
                case "\"", "\\":
                    t += 1
                    i += 2
                case "x":
                    t += 1
                    i += 4
                default:
                    fatalError()
                }
            } else {
                t += 1
                i += 1
            }
        }
        
        return t
    }

    func part1() -> CustomStringConvertible? {
        
        let input = lines()
        
        let raw = input
            .map(\.count)
            .sum()
        
        let characters = input
            .map(f)
            .map { $0 - 2 }
            .sum()
        
        return raw - characters
    }

    func part2() -> CustomStringConvertible? {
        
        let input = lines()
        
        let raw = input
            .map(\.debugDescription)
            .map(\.count)
            .sum()
        
        let characters = input
            .map(\.count)
            .sum()
        
        return raw - characters
    }
}
