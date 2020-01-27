import org.graalvm.compiler.graph.Node;

public class Tree {
    static class Node {
        int value;
        Node left;
        Node right;

        Node(int v) {
            value = v;
            left = null;
            right = null;
        }
    }
    Node root;

    Tree(int v) {
        root = new Node(v);
    }
}
