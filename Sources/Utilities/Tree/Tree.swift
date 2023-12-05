public class Tree<Element> {

    public let root: Node<Element>

    public init(root: Node<Element>) {
        self.root = root
    }

    public init(value: Element) {
        self.root = .init(value: value)
    }
}
