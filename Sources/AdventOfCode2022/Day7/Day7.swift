struct Day7: Day {
    
    class Inode {
        var name: String
        var isDirectory: Bool
        var size: Int
        
        init(name: String, isDirectory: Bool, size: Int = 0) {
            self.name = name
            self.isDirectory = isDirectory
            self.size = size
        }
    }
    
    // Makes system directory from input and returns the root node
    func makeSystemDirectory() -> Node<Inode> {
        let root: Node<Inode> = .init(value: .init(name: "/", isDirectory: true))
        var current: Node<Inode> = root
        
        input()
            .lines
            .removingFirst()
            .forEach { line in
                let parts = line.split(on: " ")
                
                if parts[0] == "$" {
                    if parts[1] == "cd" {
                        if parts[2] == ".." {
                            current = current.parent!
                        } else {
                            let newPathNode: Node<Inode> = Node(value: .init(name: parts[2].asString, isDirectory: true))
                            newPathNode.setParent(current)
                            current.addChild(newPathNode)
                            
                            current = newPathNode
                        }
                    }
                } else if parts[0] == "dir" {
                    // ignore
                } else {
                    let fileNode: Node<Inode> = Node(value: .init(name: parts[1].asString, isDirectory: false, size: parts[0].asString.asInt!))
                    current.addChild(fileNode)
                }
            }
        
        return root
    }
    
    func part1() -> CustomStringConvertible? {
        makeSystemDirectory()
            .directorySizes()
            .filter { $0 <= 100_000 }
            .sum()
    }
    
    func part2() -> CustomStringConvertible? {
        
        let root = makeSystemDirectory()
        let spaceTaken = 70_000_000 - root.size()
        let spaceDiff = 30_000_000 - spaceTaken
        
		return root
            .directorySizes()
            .filter { $0 >= spaceDiff }
            .min()
    }
}

extension Node<Day7.Inode> {
    
    func size() -> Int {
        
        if value.isDirectory {
            return children
                .map { $0.size() }
                .sum()
        } else {
            return value.size
        }
    }
    
    func directorySizes() -> [Int] {
        children
            .filter { $0.value.isDirectory }
            .reduce([size()]) { partialResult, node in
                partialResult
                    .appending(node.size())
                    .appending(node.children.filter { $0.value.isDirectory }.map { $0.directorySizes() }.flatMap { $0 })
            }
    }
}
