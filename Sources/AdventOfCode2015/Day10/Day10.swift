struct Day10: Day {
    
    func split(_ s: String) -> [(n: Int, c: Int)] {
        
        let s = Array(s)
        
        var t: [(n: Int, c: Int)] = []
        var count = 0
        var cc = s[0]
        
        for c in s {
            if c == cc {
                count += 1
            } else {
                t.append((n: cc.asInt!, c: count))
                count = 1
                cc = c
            }
        }
        
        t.append((n: cc.asInt!, c: count))
        
        return t
    }
    
    func combine(_ t: (n: Int, c: Int)) -> String {
        "\(t.c)\(t.n)"
    }

    func part1() -> CustomStringConvertible? {
        var a = lines()
            .first!
        
        for _ in 0 ..< 40 {
            a = split(a)
                .map(combine(_:))
                .joined()
        }
        
        return a.count
    }

    func part2() -> CustomStringConvertible? {
        var a = lines()
            .first!
        
        for _ in 0 ..< 50 {
            a = split(a)
                .map(combine(_:))
                .joined()
        }
        
        return a.count
    }
}
