struct Day5: Day {
    
    func process(_ update: [Int], dependencies: [Int: Set<Int>]) -> Bool {
        
        var seen: Set<Int> = []
        
        for u in update {
            seen.insert(u)
            
            guard let ins = dependencies[u] else { continue }
            
            if seen.contains(where: { ins.contains($0) }) {
                return false
            }
        }
        
        return true
    }
    
    // if X|Y, a Y|X in a reversed is also valid
    func fix(_ update: [Int], dependencies: [Int: Set<Int>]) -> [Int] {
        
        var update = update
        
        for i in 0 ..< update.count {
            for j in i + 1 ..< update.count {
                let current = update[i]
                let later = update[j]
                
                if let requiredDependents = dependencies[current],
                   requiredDependents.contains(later) {
                    update.swapAt(i, j)
                }
            }
        }
        
        return update
    }

    func part1() -> CustomStringConvertible? {
        
        let input = lines()
            .split(on: "")
        
        let orderingRegex = /(?<x>\d+)\|(?<y>\d+)/
        
        let orderings = input[0]
            .map { $0.firstMatch(of: orderingRegex)! }
            .map { ($0.output.x.asInt!, $0.output.y.asInt!) }
        
        let dependencies = orderings
            .reduce(into: [Int: Set<Int>]()) { partialResult, input in
                partialResult[input.0, default: []].insert(input.1)
            }
        
        let updates = input[1]
            .map { $0.split(on: ",") }
            .map { $0.map { $0.asInt! } }
        
        return updates
            .filter { process($0, dependencies: dependencies)}
            .map { $0[$0.count / 2] }  // get middle element
            .sum()
    }

    func part2() -> CustomStringConvertible? {
        
        let input = sampleLines()
            .split(on: "")
        
        let orderingRegex = /(?<x>\d+)\|(?<y>\d+)/
        
        let orderings = input[0]
            .map { $0.firstMatch(of: orderingRegex)! }
            .map { ($0.output.x.asInt!, $0.output.y.asInt!) }
        
        let dependencies = orderings
            .reduce(into: [Int: Set<Int>]()) { partialResult, input in
                partialResult[input.0, default: []].insert(input.1)
            }
        
        let updates = input[1]
            .map { $0.split(on: ",") }
            .map { $0.map { $0.asInt! } }
        
        return updates
            .filter { !process($0, dependencies: dependencies) }
            .map { fix($0, dependencies: dependencies) }
//            .map { $0[$0.count / 2] }  // get middle element
//            .sum()
    }
}
