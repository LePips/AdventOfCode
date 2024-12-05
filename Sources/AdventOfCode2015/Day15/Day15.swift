struct Day15: Day {
    
    struct Ingredient {
        let name: String
        let capacity: Int
        let durability: Int
        let flavor: Int
        let texture: Int
        let calories: Int
    }

    func calculateScore(ingredients: [Ingredient], amounts: [Int]) -> Int {
        let capacity = max(0, zip(ingredients, amounts)
            .map { $0.capacity * $1 }
            .sum())
        
        let durability = max(0, zip(ingredients, amounts)
            .map { $0.durability * $1 }
            .sum())
        
        let flavor = max(0, zip(ingredients, amounts)
            .map { $0.flavor * $1 }
            .sum())
        
        let texture = max(0, zip(ingredients, amounts)
            .map { $0.texture * $1 }
            .sum())
        
        return capacity * durability * flavor * texture
    }
    
    func calculateCalories(_ ingredients: [Ingredient], amounts: [Int]) -> Int {
        zip(ingredients, amounts)
            .map { $0.calories * $1 }
            .sum()
    }

    func findBestRecipe(ingredients: [Ingredient], calories: Int? = nil) -> (maxScore: Int, bestAmounts: [Int]) {
        var maxScore = 0
        var bestAmounts = Array(repeating: 0, count: ingredients.count)
        
        for a in 0 ... 100 {
            for b in 0 ... (100 - a) {
                for c in 0 ... (100 - a - b) {
                    let d = 100 - a - b - c
                    let currentAmounts = [a, b, c, d]
                    let currentScore = calculateScore(ingredients: ingredients, amounts: currentAmounts)
                    let currentCalories = calculateCalories(ingredients, amounts: currentAmounts)
                    
                    let matchesCalories = calories == nil ? true : currentCalories == calories
                    
                    if currentScore > maxScore, matchesCalories {
                        maxScore = currentScore
                        bestAmounts = currentAmounts
                    }
                }
            }
        }
        
        return (maxScore, bestAmounts)
    }
    
    func parse(lines: [String]) -> [Ingredient] {
        let pattern = /(?<name>\w+): capacity (?<capacity>-?\d+), durability (?<durability>-?\d+), flavor (?<flavor>-?\d+), texture (?<texture>-?\d+), calories (?<calories>-?\d+)/
        
        return lines
            .map { $0.firstMatch(of: pattern) }
            .map { o in
                guard let output = o?.output else { fatalError() }
                
                return Ingredient(
                    name: output.name.asString,
                    capacity: output.capacity.asInt!,
                    durability: output.durability.asInt!,
                    flavor: output.flavor.asInt!,
                    texture: output.texture.asInt!,
                    calories: output.calories.asInt!
                )
            }
        
    }

    func part1() -> CustomStringConvertible? {
        findBestRecipe(ingredients: parse(lines: lines()))
            .maxScore
    }

    func part2() -> CustomStringConvertible? {
        findBestRecipe(ingredients: parse(lines: lines()), calories: 500)
            .maxScore
    }
}
