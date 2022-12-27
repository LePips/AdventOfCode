struct Day5: Day {
    
    func stacks() -> [Int: [Character]] {
        [
            1: "RNPG".asArray(),
            2: "TJBLCSVH".asArray(),
            3: "TDBMNL".asArray(),
            4: "RVPSB".asArray(),
            5: "GCQSWMVH".asArray(),
            6: "WQSCDBJ".asArray(),
            7: "FQL".asArray(),
            8: "WMHTDLFV".asArray(),
            9: "LPBVMJF".asArray()
        ]
    }
    
    func part1() -> CustomStringConvertible? {
        
        var stacks = stacks()
        
        input()
            .lines
            .map { $0.split(on: " ").asInts }
            .forEach { nums in
                stacks[nums[2]] = stacks[nums[2]]!.appending(stacks[nums[1]]!.poppingLast(nums[0]))
                stacks[nums[1]] = stacks[nums[1]]!.removingLast(nums[0])
            }
        
        return stacks
            .keys
            .sorted()
            .compactMap { stacks[$0]!.last?.asString }
            .joined()
    }
    
    func part2() -> CustomStringConvertible? {
		
        var stacks = stacks()
        
        input()
            .lines
            .map { $0.split(on: " ").asInts }
            .forEach { nums in
                stacks[nums[2]] = stacks[nums[2]]!.appending(stacks[nums[1]]!.poppingLast(nums[0]).reversed())
                stacks[nums[1]] = stacks[nums[1]]!.removingLast(nums[0])
            }
        
        return stacks
            .keys
            .sorted()
            .compactMap { stacks[$0]!.last?.asString }
            .joined()
    }
}
