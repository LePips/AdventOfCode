struct Day13: Day {
    
    func parse(_ input: [String]) -> [(((x1: Int, y1: Int), (x2: Int, y2: Int)), (x: Int, y: Int))] {
        
        let r = /.*X\+(?<X>\d+), Y\+(?<Y>\d+)/
        let p = /.*X=(?<X>\d+), Y=(?<Y>\d+)/
        
        return input.split(on: "")
            .map { slice in
                let a = slice[slice.startIndex].firstMatch(of: r)!
                let b = slice[slice.startIndex.advanced(by: 1)].firstMatch(of: r)!
                let p = slice[slice.startIndex.advanced(by: 2)].firstMatch(of: p)!
                
                let m = ((a.output.X.asInt!, a.output.Y.asInt!), (b.output.X.asInt!, b.output.Y.asInt!))
                let x = (p.output.X.asInt!, p.output.Y.asInt!)
                
                return (m, x)
            }
    }

    func part1() -> CustomStringConvertible? {
        parse(lines())
            .compactMap { (m, x) -> Int in
                
                var t = Int.max
                
                for i in 0 ..< 101 {
                    let tx = x.0 - i * m.0.0
                    let ty = x.1 - i * m.0.1
                    
                    if tx % m.1.0 == 0, ty % m.1.1 == 0 {
                        let b = tx / m.1.0
                        
                        if b >= 0, b * m.1.1 == ty {
                            t = min(t, 3 * i + b)
                        }
                    }
                }
                
                if t != Int.max {
                    return t
                } else {
                    return 0
                }
            }
            .sum()
    }

    func part2() -> CustomStringConvertible? {
        parse(lines())
            .compactMap { (m, x) -> Int in
                
                let A = (x: m.0.0, y: m.0.1)
                let B = (x: m.1.0, y: m.1.1)
                let P = (x: x.0 + 10000000000000, y: x.1 + 10000000000000)
                
                let a = (P.x * B.y - P.y * B.x) / (B.y * A.x - B.x * A.y)
                let b = (P.x * A.y - P.y * A.x) / (A.y * B.x - B.y * A.x)

                if A.x * a + B.x * b == P.x && A.y * a + B.y * b == P.y {
                    return 3 * a + b
                } else {
                    return 0
                }
            }
            .sum()
    }
}
