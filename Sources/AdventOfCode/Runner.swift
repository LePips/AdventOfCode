import Foundation
import Utilities

struct AdventRunner {
    
    let day: any Day
    
    func run() {
        
        part1()
        part2()
    }
    
    private func part1() {
        let startTime = Date()
        
        guard let output = day.part1() else {
            print("Part 1: not implemented\n")
            return
        }
        
        let endTime = Date()
        
        let runtime = endTime.timeIntervalSince(startTime)
        
        let message = message(
            part: 1,
            output: output,
            runtime: runtime
        )
        
        print(message)
    }
    
    private func part2() {
        let startTime = Date()
        
        guard let output = day.part2() else {
            print("Part 2: not implemented\n")
            return
        }
        
        let endTime = Date()
        
        let runtime = endTime.timeIntervalSince(startTime)
        
        let message = message(
            part: 2,
            output: output,
            runtime: runtime
        )
        
        print(message)
    }
    
    private func message(
        part: Int,
        output: CustomStringConvertible,
        runtime: TimeInterval
    ) -> String{
        """
        Part \(part): \(output)
        -- runtime: \(runtime)\n
        """
    }
}
