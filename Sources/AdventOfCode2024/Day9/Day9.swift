struct Day9: Day {
    
    func parse(_ input: Matrix<Character>) -> Matrix<Int> {
        input.map { $0.asInt ?? 100 }
    }

    func part1() -> CustomStringConvertible? {
        let m = parse(matrix())
        // end trail coordinates per coordinate
        var mi = m.map { _ in Set<Coordinate>() }
    
        // insert end of trail coordinates,
        // traverse further if necessary
        func t(_ c: Coordinate) {
    
            guard m[c] != 9 else {
                mi[c].insert(c)
                return
            }
    
            guard mi[c].isEmpty else { return }
    
            let neighbors = c.nonDiagonalNeighbors
                .filter(m.contains(c:))
                .filter {
                    m[$0] == m[c] + 1
                }
    
            for n in neighbors {
                if mi[n].isEmpty {
                    t(n)
                }
                
                mi[c] = mi[c].union(mi[n])
            }
        }
    
        let ths = m.locations(of: 0)
    
        for th in ths {
            t(th)
        }
    
        return ths.map { mi[$0].count }
            .sum()
    }

    func part2() -> CustomStringConvertible? {
        let m = parse(matrix())
        // number of trails at each coordinate
        var mi = m.map { _ in 0 }
        
        func t(_ c: Coordinate) -> Int {
            
            guard m[c] != 9 else {
                mi[c] = 1
                return 1
            }
            guard mi[c] == 0 else { return mi[c] }
            
            let neighbors = c.nonDiagonalNeighbors
                .filter(m.contains(c:))
                .filter {
                    m[$0] == m[c] + 1
                }
            
            var a = 0
            
            for n in neighbors {
                if mi[n] == 0 {
                    a += t(n)
                } else {
                    a += mi[n]
                }
            }
            
            mi[c] = a
            
            return a
        }
        
        return m.locations(of: 0)
            .map { t($0) }
            .sum()
    }
}
