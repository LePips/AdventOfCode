struct Day6: Day {
    
    typealias Instruction = (i: String, xr: (Int, Int), yr: (Int, Int))
    
    func f(_ s: String) -> Instruction {
        let sl = s
            .split(on: " ")
            .map(String.init)
        let i: String
        
        if sl.count == 5 {
            i = sl[1]
        } else {
            i = "toggle"
        }
        
        let rs = sl.filter { $0.contains(",") }
            .map { $0.split(on: ",").compactMap { Int($0) } }
        
        let xr = (rs[0][0], rs[1][0])
        let yr = (rs[0][1], rs[1][1])
        
        return (i, xr, yr)
    }
    
    func p(_ m: inout Matrix<Bool>, _ i: Instruction) {
        
        let f: (Bool) -> Bool
        
        switch i.i {
        case "toggle":
            f = { !$0 }
        case "on":
            f = { _ in true }
        case "off":
            f = { _ in false }
        default:
            fatalError()
        }
        
        for x in i.xr.0 ... i.xr.1 {
            for y in i.yr.0 ... i.yr.1 {
                m[x, y] = f(m[x, y])
            }
        }
    }

    func part1() -> CustomStringConvertible? {
        var g = Matrix(
            width: 1000,
            height: 1000,
            repeating: false
        )
        
        lines()
            .map(f)
            .forEach {
                p(&g, $0)
            }
        
        return g.rows
            .map { $0.count(where: { $0 })}
            .sum()
    }
    
    func p(_ m: inout Matrix<Int>, _ i: Instruction) {
        
        let f: (Int) -> Int
        
        switch i.i {
        case "toggle":
            f = { $0 + 2 }
        case "on":
            f = { $0 + 1 }
        case "off":
            f = { max(0, $0 - 1) }
        default:
            fatalError()
        }
        
        for x in i.xr.0 ... i.xr.1 {
            for y in i.yr.0 ... i.yr.1 {
                m[x, y] = f(m[x, y])
            }
        }
    }

    func part2() -> CustomStringConvertible? {
        var g = Matrix(
            width: 1000,
            height: 1000,
            repeating: 0
        )
        
        lines()
            .map(f)
            .forEach {
                p(&g, $0)
            }
        
        return g.rows
            .map { $0.sum() }
            .sum()
    }
}
