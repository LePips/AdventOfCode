struct Day3: Day {

    func part1() -> CustomStringConvertible? {
        lines()
            .map {
                $0.matches(of: /mul\((?<l>\d+),(?<r>\d+)\)/)
                .map {
                    $0.output.l.asInt! * $0.output.r.asInt!
                }
                .sum()
            }
            .sum()
    }

    func part2() -> CustomStringConvertible? {
        
        var t = 0
        var de = true
        let r = /mul\((?<l>\d+),(?<r>\d+)\)|(?<d>do\(\))|(?<dn>don't\(\))/
        
        for l in lines() {
            let m = l.matches(of: r)
            
            for mi in m {
                if let _ = mi.output.d {
                    de = true
                } else if let _ = mi.output.dn {
                    de = false
                } else {
                    guard de else { continue }
                    
                    t += mi.output.l!.asInt! * mi.output.r!.asInt!
                }
            }
        }
        
        return t
    }
}
