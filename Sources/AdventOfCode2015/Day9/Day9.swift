struct Day9: Day {
    
    struct CityPair: Hashable {
        
        let x: Int
        let y: Int
    }
    
    func f(_ s: ([CityPair: Int], [Int]) -> Int) -> Int {
        let edges = lines()
            .map {
                let s = $0.split(on: " ")
                
                return (s[0].asString, s[2].asString, Int(s.last!)!)
            }
        
        let cities: [String: Int] = edges
            .reduce(into: Set<String>()) { pr, e in
                pr.insert(e.0)
                pr.insert(e.1)
            }
            .asArray
            .enumerated()
            .asArray
            .reduce(into: [:]) { pr, e in
                pr[e.element] = e.offset + 1
            }
        
        let distancePairs: [CityPair: Int] = edges
            .map {
                (
                    CityPair(
                        x: cities[$0.0]!,
                        y: cities[$0.1]!
                    ),
                    CityPair(
                        x: cities[$0.1]!,
                        y: cities[$0.0]!
                    ),
                    $0.2
                )
            }
            .reduce(into: [:]) { pr, e in
                pr[e.0] = e.2
                pr[e.1] = e.2
            }
        
        return s(distancePairs, cities.values.asArray)
    }
    
    func part1() -> CustomStringConvertible? {
        f { distancePairs, cities in
            func tsp(
                _ destinations: [Int],
                _ start: Int,
                _ visited: [Int],
                _ c: Int
            ) -> Int {
                
                var visited = visited
                visited.append(start)
                var destinations = destinations
                destinations.removeAll { $0 == start }
                
                guard destinations.isNotEmpty else {
                    return c
                }
                
                var m = Int.max
                
                for d in destinations {
                    
                    if !distancePairs.keys.contains(CityPair(x: start, y: d)) {
                        continue
                    }
                    
                    let t = tsp(
                        destinations,
                        d,
                        visited,
                        c + distancePairs[CityPair(x: start, y: d)]!
                    )
                    
                    m = min(m, t)
                }
                
                return m
            }
            
            var m = Int.max
            
            for c in cities {
                m = min(m, tsp(cities, c, .init(), 0))
            }
            
            return m
        }
    }

    func part2() -> CustomStringConvertible? {
        
        f { distancePairs, cities in
            func tsp(
                _ destinations: [Int],
                _ start: Int,
                _ visited: [Int],
                _ c: Int
            ) -> Int {
                
                var visited = visited
                visited.append(start)
                var destinations = destinations
                destinations.removeAll { $0 == start }
                
                guard destinations.isNotEmpty else {
                    return c
                }
                
                var m = Int.min
                
                for d in destinations {
                    
                    if !distancePairs.keys.contains(CityPair(x: start, y: d)) {
                        continue
                    }
                    
                    let t = tsp(
                        destinations,
                        d,
                        visited,
                        c + distancePairs[CityPair(x: start, y: d)]!
                    )
                    
                    m = max(m, t)
                }
                
                return m
            }
            
            var m = Int.min
            
            for c in cities {
                m = max(m, tsp(cities, c, .init(), 0))
            }
            
            return m
        }
    }
}
