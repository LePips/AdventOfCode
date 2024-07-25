struct Day4: Day {

    func part1() -> CustomStringConvertible? {
        let input = lines()[0]
        
        var t = -1
        var c = ""
        
        while !c.starts(with: "00000") {
            t += 1
            let n = input + "\(t)"
            c = n.data(using: .utf8)!
                .md5String
        }
        
        return t
    }

    func part2() -> CustomStringConvertible? {
        let input = lines()[0]
        
        var t = -1
        var c = ""
        
        while !c.starts(with: "000000") {
            t += 1
            let n = input + "\(t)"
            c = n.data(using: .utf8)!
                .md5String
        }
        
        return t
    }
}
