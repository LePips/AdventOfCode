struct Day7: Day {
    
    func f(_ a: Int, _ c: [Int], concat: Bool) -> Bool {
        guard c.count > 1 else {
            return c[0] == a
        }
        
        var c = c
        let l = c.removeLast()
        
        if a > l, f(a - l, c, concat: concat) {
            return true
        }
        
        if a.isMultiple(of: l), f(a / l, c, concat: concat) {
            return true
        }
        
        if concat {
            let goalDigits = String(a)
            let lastDigits = String(l)
            
            if goalDigits.count > lastDigits.count, goalDigits.hasSuffix(lastDigits) {
                
                let newGoal = Int(goalDigits.dropLast(lastDigits.count))!
                
                return f(newGoal, c, concat: concat)
            }
        }
        
        return false
    }
    
    func parse(lines: [String]) -> [(a: Int, c: [Int])] {
        lines
            .map { $0.split(on: " ")}
            .map { e in
                var a = e[0]
                a.removeLast()
                
                let c = e[1...]
                    .compactMap(\.asInt)
                
                return (a: a.asInt!, c: c)
            }
    }

    func part1() -> CustomStringConvertible? {
        parse(lines: lines())
            .filter { f($0.a, $0.c, concat: false) }
            .map(\.a)
            .sum()
    }

    func part2() -> CustomStringConvertible? {
        parse(lines: lines())
            .filter { f($0.a, $0.c, concat: true) }
            .map(\.a)
            .sum()
    }
}
