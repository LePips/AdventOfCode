public class Node<Element> {

    public private(set) var children: [Node] = []
    public private(set) var parent: Node?
    public let value: Element

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
