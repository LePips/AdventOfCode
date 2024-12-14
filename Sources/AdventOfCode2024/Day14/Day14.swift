struct Day14: Day {
    
    struct Robot {
        var x: Int
        var y: Int
        
        let vx: Int
        let vy: Int
        
        mutating func step(w: Int, h: Int) {
            x += vx
            y += vy
            
            if x < 0 {
                x += w
            }
            
            if y < 0 {
                y += h
            }
            
            x %= w
            y %= h
        }
    }
    
    func parse(_ input: [String]) -> [Robot] {
        let r = /p\=(?<x>-?\d+),(?<y>-?\d+) v\=(?<vx>-?\d+),(?<vy>-?\d+)/
        
        return input
            .map { line in
                let m = line.firstMatch(of: r)!.output
                return Robot(x: m.x.asInt!, y: m.y.asInt!, vx: m.vx.asInt!, vy: m.vy.asInt!)
            }
    }
    
    func safetyFactor(from robots: [Robot], w: Int, h: Int) -> Int {
        let wm = w / 2
        let hm = h / 2
        
        let q1 = robots.filter { $0.x > wm && $0.y > hm }.count
        let q2 = robots.filter { $0.x < wm && $0.y > hm }.count
        let q3 = robots.filter { $0.x < wm && $0.y < hm }.count
        let q4 = robots.filter { $0.x > wm && $0.y < hm }.count
        
        return q1 * q2 * q3 * q4
    }

    func part1() -> CustomStringConvertible? {
        
        let w = 101
        let h = 103
        let s = 100
        
        var robots = parse(lines())
        
        for _ in 0 ..< s {
            robots = robots.map { r in
                var r = r
                r.step(w: w, h: h)
                return r
            }
        }
        
        return safetyFactor(from: robots, w: w, h: h)
    }
    
    func gridString(for robots: [Robot], w: Int, h: Int) -> String {
        var m = Matrix(width: w, height: h, repeating: ".")
        
        for r in robots {
            m[r.x, r.y] = "#"
        }
        
        return m.description.filter { $0 != " " }
    }

    func part2() -> CustomStringConvertible? {
        
        let w = 101
        let h = 103
        let s = 10000
        
        var robots = parse(lines())
        var c = robots
        var msf = safetyFactor(from: robots, w: w, h: h)
        var mi = 0
        
        for i in 1 ... s {
            robots = robots.map { r in
                var r = r
                r.step(w: w, h: h)
                return r
            }
            
            let sf = safetyFactor(from: robots, w: w, h: h)
            if sf < msf {
                msf = sf
                mi = i
            }
        }
        
        for _ in 1 ... mi {
            c = c.map { r in
                var r = r
                r.step(w: w, h: h)
                return r
            }
        }
        
        print(gridString(for: c, w: w, h: h))
        
        return mi
    }
}
