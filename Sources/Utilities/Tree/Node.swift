public class Node<Element> {
    
    private(set) public var children: [Node] = []
    private(set) public var parent: Node?
    public let value: Element
    
    public init(value: Element) {
        self.value = value
    }
    
    public func setParent(_ node: Node) {
        parent = node
    }
    
    public func addChild(_ node: Node) {
        children = children.appending(node)
    }
}
