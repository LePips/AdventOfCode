struct Day2: Day {
    
    // run the closure on the array with each element removed
    func runClosureOnModifiedArrays(_ array: [Int], closure: ([Int]) -> Bool) -> Bool {
        
        for i in 0 ..< array.count {
            
            var modifiedArray = array
            modifiedArray.remove(at: i)
            
            if closure(modifiedArray) {
                return true
            }
        }
        
        return false
    }
    
    func p(_ a: [Int]) -> Bool {
        
        var a = a
        
        // make have increasing
        if a[0] > a[1] {
            a = a.reversed()
        }
        
        var s: [Int] = [a.removeFirst()]
        
        while a.isNotEmpty {
            let ai = a.removeFirst()
            let sl = s.last!
            
            if ai <= sl {
                return false
            }
            
            if !(1 ... 3 ~= abs(ai - sl)) {
                return false
            }
            
            s.append(ai)
        }
        
        return true
    }

    func part1() -> CustomStringConvertible? {
        lines()
            .map { $0.split(on: " ") }
            .map { $0.compactMap { $0.asInt } }
            .filter { p($0) }
            .count
    }

    func part2() -> CustomStringConvertible? {
        lines()
            .map { $0.split(on: " ") }
            .map { $0.compactMap { $0.asInt } }
            .filter {
                runClosureOnModifiedArrays($0) { r in
                    p(r)
                }
            }
            .count
    }
}
