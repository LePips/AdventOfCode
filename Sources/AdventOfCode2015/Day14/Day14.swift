struct Day14: Day {
    
//    Vixen can fly 19 km/s for 7 seconds, but then must rest for 124 seconds.
//    Rudolph can fly 3 km/s for 15 seconds, but then must rest for 28 seconds.
//    Donner can fly 19 km/s for 9 seconds, but then must rest for 164 seconds.
//    Blitzen can fly 19 km/s for 9 seconds, but then must rest for 158 seconds.
//    Comet can fly 13 km/s for 7 seconds, but then must rest for 82 seconds.
//    Cupid can fly 25 km/s for 6 seconds, but then must rest for 145 seconds.
//    Dasher can fly 14 km/s for 3 seconds, but then must rest for 38 seconds.
//    Dancer can fly 3 km/s for 16 seconds, but then must rest for 37 seconds.
//    Prancer can fly 25 km/s for 6 seconds, but then must rest for 143 seconds.
    
    struct ReindeerState {
        
        let speed: Int
        let burstSeconds: Int
        let restSeconds: Int
        
        var distanceTravelled: Int {
            var t = 0
            var s = secondsTravelled
            
            while s > 0 {
                t += min(burstSeconds, s) * speed
                s -= burstSeconds
                s -= restSeconds
            }
            
            return t
        }
        
        var points = 0
        var secondsTravelled = 0
        
        mutating func step() {
            secondsTravelled += 1
        }
    }

    func part1() -> CustomStringConvertible? {
        
        let seconds = 2503
        let c = ReindeerState(speed: 14, burstSeconds: 10, restSeconds: 127, secondsTravelled: seconds)
        let d = ReindeerState(speed: 16, burstSeconds: 11, restSeconds: 162, secondsTravelled: seconds)
        
        return max(c.distanceTravelled, d.distanceTravelled)
    }

    func part2() -> CustomStringConvertible? {
        
        let seconds = 2503
        var reindeer: [ReindeerState] = [
            .init(speed: 19, burstSeconds: 7, restSeconds: 124),
            .init(speed: 3, burstSeconds: 15, restSeconds: 28),
            .init(speed: 19, burstSeconds: 9, restSeconds: 164),
            .init(speed: 19, burstSeconds: 9, restSeconds: 158),
            .init(speed: 13, burstSeconds: 7, restSeconds: 82),
            .init(speed: 25, burstSeconds: 6, restSeconds: 145),
            .init(speed: 14, burstSeconds: 3, restSeconds: 38),
            .init(speed: 3, burstSeconds: 16, restSeconds: 37),
            .init(speed: 25, burstSeconds: 6, restSeconds: 143)
        ]
        
        for _ in 0 ..< seconds {
            
            for ri in 0 ..< reindeer.count {
                reindeer[ri].step()
            }
            
            let maxDistance = reindeer.map { $0.distanceTravelled }.max()!
            
            for ri in 0 ..< reindeer.count {
                if reindeer[ri].distanceTravelled == maxDistance {
                    reindeer[ri].points += 1
                }
            }
        }
        
        return reindeer.max(by: { $0.points < $1.points })!.points
    }
}
