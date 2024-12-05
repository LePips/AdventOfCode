struct Day13: Day {

    func part1() -> CustomStringConvertible? {
        let d = lines()
            .map { line in
                let regex = /(?<name>\w+) would (?<gain>\w+) (?<amount>\d+) happiness units by sitting next to (?<neighbor>\w+)/
                let match = try! regex.firstMatch(in: line)
                return match!.output
            }
        
        var people_s: Set<String> = []
        var relations: [String: Int] = [:]
        
        for i in d {
            people_s.insert(i.name.asString)
            people_s.insert(i.neighbor.asString)
            relations["\(i.name)-\(i.neighbor)"] = Int(i.amount)! * (i.gain == "gain" ? 1 : -1)
        }
        
        var people = Array(people_s)
        
        // part 2
        for p in people {
            relations["me-\(p)"] = 0
            relations["\(p)-me"] = 0
        }
        people.append("me")
        
        func f(_ order: [String]) -> Int {
            var h = 0
            
            for i in 0 ..< order.count {
                let p1 = order[i]
                let p2 = order[(i + 1) % order.count]
                h += relations["\(p1)-\(p2)"]!
                h += relations["\(p2)-\(p1)"]!
            }
            
            return h
        }
        
        let firstPerson = people.popLast()!
        let orders = people.permutations()
        var maxHappiness = 0
        
        for order in orders {
            maxHappiness = max(
                maxHappiness,
                f([firstPerson] + order)
            )
        }
        
        return maxHappiness
    }

    func part2() -> CustomStringConvertible? {
        nil
    }
}
