public class Node<Element> {

    public private(set) var children: [Node] = []
    public private(set) var parent: Node?
    public let value: Element
    public var data: [String: Any] = [:]

    public init(value: Element) {
        self.value = value
    }

    public func setParent(_ node: Node) {
        parent = node
    }

    public func addChild(_ node: Node) {
        children.append(node)
        node.parent = self
    }
}

extension Node: Equatable where Element: Equatable {
    
    public static func == (lhs: Node<Element>, rhs: Node<Element>) -> Bool {
        lhs.value == rhs.value
    }
}

extension Node: Hashable where Element: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
    
}
