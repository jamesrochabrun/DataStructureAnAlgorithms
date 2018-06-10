//: Playground - noun: a place where people can play

import UIKit


// Chapter 6 Trees.

// Creating a Tree
public class TreeNode<T> {
    
    public var value: T
    public var children: [TreeNode] = []
    
    public init(_ value: T) {
        self.value = value
    }
    
    public func add(_ child: TreeNode) {
        children.append(child)
    }
}

/// Example of creating a tree
let beverages = TreeNode("Beverages")
let hot = TreeNode("hot")
let cold = TreeNode("cold")

beverages.add(hot)
beverages.add(cold)

print(beverages.children.count)


//Traversal algorithms

/// depth-first traversal -  technique that starts at the root and visits nodes as deep as it can before backtracking.

extension TreeNode {
    public func forEachDepthFirst(visit: (TreeNode) -> Void) {
        visit(self)
        children.forEach { $0.forEachDepthFirst(visit: visit) }
    }
}

func makeBeverageTree() -> TreeNode<String> {
    
    let tree = TreeNode("Beverages")
    let hot = TreeNode("hot")
    let cold = TreeNode("cold")
    let tea = TreeNode("tea")
    let coffee = TreeNode("coffee")
    let chocolate = TreeNode("cocoa")
    let blackTea = TreeNode("black")
    let greenTea = TreeNode("green")
    let chaiTea = TreeNode("chai")
    let soda = TreeNode("soda")
    let milk = TreeNode("milk")
    let gingerAle = TreeNode("ginger ale")
    let bitterLemon = TreeNode("bitter lemon")
    
    tree.add(hot)
    tree.add(cold)
    
    hot.add(tea)
    hot.add(coffee)
    hot.add(chocolate)
    
    cold.add(soda)
    cold.add(milk)
    
    tea.add(blackTea)
    tea.add(greenTea)
    tea.add(chaiTea)
    
    soda.add(gingerAle)
    soda.add(bitterLemon)
    
    return tree
}

/// Example of depth-first traversal

let beverageTree = makeBeverageTree()
beverageTree.forEachDepthFirst { print($0.value) }


// level-order traversal - technique that visits each node of the tree based on the depth of the nodes.

//extension TreeNode {
//    public func forEachLevelOrder(visit: (TreeNode) -> Void) {
//        visit(self)
//        var queue = Queue<TreeNode>()
//        children.forEach {
//            queue.enqu
//        }
//    }
//}

// search -


// Binary trees -  A binary tree is a tree where each node has at most two children, often referred to as the left and right children.

public class BinaryNode<Element> {
    
    public var value: Element
    public var leftChild: BinaryNode?
    public var rightChild: BinaryNode?
    
    public init(value: Element) {
        self.value = value
    }
    
    // Helper
    public func addChilds(left: BinaryNode?, right: BinaryNode?) {
        self.leftChild = left
        self.rightChild = right
    }
}

var tree: BinaryNode<Int> {
    
    let zero = BinaryNode(value: 0)
    let one = BinaryNode(value: 1)
    let five = BinaryNode(value: 5)
    let seven = BinaryNode(value: 7)
    let eight = BinaryNode(value: 8)
    let nine = BinaryNode(value: 9)

    seven.leftChild = one
    one.leftChild = zero
    one.rightChild = five
    
    seven.rightChild = nine
    nine.leftChild = eight
    return seven
}

/// Building a diagram: Building a mental model of a data structure can be quite helpful in learning how it works. To that end, you’ll implement a reusable algorithm that helps visualize a binary tree in the console.

extension BinaryNode: CustomStringConvertible {
    
    public var description: String {
        return diagram(for: self)
    }
    private func diagram(for node: BinaryNode?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
        guard let node = node else {
            return root + "nil\n"
        }
        if node.leftChild == nil && node.rightChild == nil {
            return root + "\(node.value)\n"
        }
        return diagram(for: node.rightChild,
                       top + " ", top + "┌──", top + "│ ")
    }
}

/// Prinitng a diagram
print(tree)

/* Traversal algorithms:
 
Previously, you looked at a level-order traversal of a tree. With a few tweaks, you can make this algorithm work for binary trees as well. However, instead of re-implementing level-order traversal, you’ll look at three traversal algorithms for binary trees: in-order, pre-order, and post-order traversals.
*/

// In-order traversal:

"""
• If the current node has a left child, recursively visit this child first.
• Then visit the node itself.
• If the current node has a right child, recursively visit this child.
"""

extension BinaryNode {
    
    public func traverseInOrder(visit: (Element) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }
}

/// Following the rules laid out above, you first traverse to the leftmost node before visiting the value. You then traverse to the rightmost node.
///You may have noticed that this prints the example tree in ascending order. If the tree nodes are structured in a certain way, in-order traversal visits them in ascending order

//tree.traverseInOrder { print($0) }


// Pre-order traversal: Pre-order traversal always visits the current node first, then recursively visits the left and right child

extension BinaryNode {
    
    public func traversePreOrder(visit: (Element) -> Void) {
        visit(value)
        leftChild?.traverseInOrder(visit: visit)
        rightChild?.traverseInOrder(visit: visit)
    }
}

var newTree: BinaryNode<Int> {
    
    let five = BinaryNode(value: 5)
    let three = BinaryNode(value: 3)
    let four = BinaryNode(value: 4)
    let seven = BinaryNode(value: 7)
    let nine = BinaryNode(value: 9)
    let eight = BinaryNode(value: 8)
    let fourteen = BinaryNode(value: 14)
    let sixteen = BinaryNode(value: 16)
    let fifthteen  = BinaryNode(value: 15)

    five.addChilds(left: three, right: fourteen)
    three.addChilds(left: four, right: nine)
    four.addChilds(left: seven, right: eight)
    fourteen.addChilds(left: sixteen, right: fifthteen)
    
    return five
}

// Post-order traversal: only visits the current node after the left and right child have been visited recursively.
//In other words, given any node, you’ll visit its children before visiting itself. An interesting consequence of this is that the root node is always visited last.

extension BinaryNode {
    
    public func traversePostOrder(visit: (Element) -> Void) {
        leftChild?.traversePreOrder(visit: visit)
        rightChild?.traversePostOrder(visit: visit)
        visit(value)
    }
}

newTree.traversePostOrder {
    print($0)
}

///Each one of these traversal algorithms has both a time and space complexity of O(n).














