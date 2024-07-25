struct Day7: Day {
    
    class Node: Hashable {
        
        let key: String
        let operation: Operation
        
        init(_ key: String, _ o: Operation) {
            self.key = key
            self.operation = o
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(key)
        }
        
        static func ==(lhs: Node, rhs: Node) -> Bool {
            lhs.key == rhs.key
        }
    }
    
    indirect enum Operation: Hashable {
        
        case not(String)
        case lshift(String, UInt16)
        case rshift(String, UInt16)
        case and(String, String)
        case or(String, String)
        case identity(String)
        case identityN(UInt16)
        
        func resolve(_ g: [String: Operation], _ m: inout [Operation: UInt16]) -> UInt16 {
            
            if let mv = m[self] {
                return mv
            }
            
            let v = switch self {
            case .not(let node):
                ~g[node]!.resolve(g, &m)
            case .lshift(let node, let int):
                g[node]!.resolve(g, &m) << int
            case .rshift(let node, let int):
                g[node]!.resolve(g, &m) >> int
            case .and(let node, let node2):
                g[node]!.resolve(g, &m) & g[node2]!.resolve(g, &m)
            case .or(let node, let node2):
                g[node]!.resolve(g, &m) | g[node2]!.resolve(g, &m)
            case .identity(let node):
                g[node]!.resolve(g, &m)
            case .identityN(let int):
                int
            }
            
            m[self] = v
            
            return v
        }
    }

    func part1() -> CustomStringConvertible? {
        
        let ins = lines()
            .map { $0.split(separator: "->")
                    .map(\.asString)
                    .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            }
        
        var g: [String: Operation] = [:]
        
        for i in ins {

            let a = i[0]
            let b = i[1]

            if a.matches(for: "NOT (.*)").isNotEmpty {
                let p = a.split(on: " ").last!.asString
                g[b] = .not(p)
            } else if a.matches(for: "(.*) LSHIFT (.*)").isNotEmpty {
                let ps = a.split(on: " ").asStrings
                g[b] = .lshift(ps[0], UInt16(ps[2])!)
            } else if a.matches(for: "(.*) RSHIFT (.*)").isNotEmpty {
                let ps = a.split(on: " ").asStrings
                g[b] = .rshift(ps[0], UInt16(ps[2])!)
            } else if a.matches(for: "(.*) AND (.*)").isNotEmpty {
                let ps = a.split(on: " ").asStrings
                g[b] = .and(ps[0], ps[2])
                
                if let n = UInt16(ps[0]) {
                    g[ps[0]] = .identityN(n)
                } else if let n = UInt16(ps[2]) {
                    g[ps[0]] = .identityN(n)
                }
            } else if a.matches(for: "(.*) OR (.*)").isNotEmpty {
                let ps = a.split(on: " ").asStrings
                g[b] = .or(ps[0], ps[2])
                
                if let n = UInt16(ps[0]) {
                    g[ps[0]] = .identityN(n)
                } else if let n = UInt16(ps[2]) {
                    g[ps[0]] = .identityN(n)
                }
            } else {
                if let n = UInt16(a) {
                    g[b] = .identityN(n)
                } else {
                    g[b] = .identity(a)
                }
            }
        }
        
        var m: [Operation: UInt16] = [:]
        
        return g["a"]!.resolve(g, &m)
    }

    // same as part 1, but with "1674 -> b" replaced
    // with part 1 output
    func part2() -> CustomStringConvertible? {
        nil
    }
}
