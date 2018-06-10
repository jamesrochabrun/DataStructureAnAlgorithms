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
 
Previously, you looked at a level-order traversal of a tree. With a few tweaks, you can make this algorithm work for binary trees as well. However, instead of re-implementing level-order traversal, you’ll look at 3 traversal algorithms for binary trees: in-order, pre-order, and post-order traversals.
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
        leftChild?.traversePreOrder(visit: visit)
        rightChild?.traversePreOrder(visit: visit)
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
        leftChild?.traversePostOrder(visit: visit)
        rightChild?.traversePostOrder(visit: visit)
        visit(value)
    }
}

newTree.traversePostOrder {
    print($0)
}

///Each one of these traversal algorithms has both a time and space complexity of O(n).


// Binary Search trees -

/*
 A binary search tree (or BST) is a data structure that facilitates fast lookup, addition, and removal operations. Each operation has an average time complexity of O(log n), which is considerably faster than linear data structures such as arrays and linked lists. A binary search tree achieves this performance by imposing two rules on the binary tree you saw in the previous chapter:
 • The value of a left child must be less than the value of its parent.
 • The value of a right child must be greater than or equal to the value of its parent.
 */

public struct BinarySearchTree<Element: Comparable> {
    public private(set) var root: BinaryNode<Element>?
    public init() {}
}

extension BinarySearchTree: CustomStringConvertible {

    public var description: String {
        return root?.description ?? "empty tree"
    }
}

/// Inserting elements

extension BinarySearchTree {
    
    public mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
    }
    
    private func insert(from node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element> {
        
        // 1  This is a recursive method, so it requires a base case for terminating recursion. If the current node is nil, you’ve found the insertion point and you return the new BinaryNode.
        guard let node = node else { return BinaryNode(value: value) }
        // 2 This if statement controls which way the next insert call should traverse. If the new value is less than the current value, you call insert on the left child. If the new value is greater than or equal to the current value, you’ll call insert on the right child.
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        // 3 Return the current node. This makes assignments of the form node = insert(from: node, value: value) possible as insert will either create node (if it was nil) or return node (it it was not nil).
        return node
    }
}

// example of building a BST
var bst = BinarySearchTree<Int>()
for i in 0..<5 {
    bst.insert(i)
}

print("BST \(bst)")

// That tree looks a bit unbalanced, but it does follow the rules. However, this tree layout has undesirable consequences. When working with trees, you always want to achieve a balanced format, check next chapter for this, for now just create a balanced tree


var exampleTree: BinarySearchTree<Int> {
    var bst = BinarySearchTree<Int>()
    bst.insert(3)
    bst.insert(1)
    bst.insert(4)
    bst.insert(0)
    bst.insert(2)
    bst.insert(5)
    return bst
}

// Finding elements
extension BinarySearchTree {
    
    public func contains(_ value: Element) -> Bool {
        
        guard let root = root else { return false }
        var found = false
        root.traverseInOrder {
            if $0 == value {
                found = true
            }
        }
        return found
    }
}

/// example:
print("contains? \(exampleTree.contains(5))")

// In-order traversal has a time complexity of O(n), thus this implementation of contains has the same time complexity as an exhaustive search through an unsorted array. However, you can do better.

// Optimizing "Contains"
extension BinarySearchTree {
    
    public func optimizedContains(_ value: Element) -> Bool {
        // 1 Start off by setting current to the root node.
        var current = root
        // 2 While current is not nil, check the current node’s value.
        while let node = current {
            // 3 If the value is equal to what you’re trying to find, return true.
            if node.value == value {
                return true
            }
            
            // 4 Otherwise, decide whether you’re going to check the left or the right child.
            if value < node.value {
                current = node.leftChild
            } else {
                current = node.rightChild
            }
        }
        return false
    }
}

// Removing elements

// When removing a node with two children, replace the node you removed with smallest node in its right subtree. Based on the rules of the BST, this is the leftmost node of the right subtree:

private extension BinaryNode {
    
    var min: BinaryNode {
        return leftChild?.min ?? self
    }
}

extension BinarySearchTree {
    
    public mutating func remove(_ value: Element) {
        root = remove(node: root, value: value)
    }
    
    private func remove(node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element>? {
        
        guard let node = node else { return nil }
        if value == node.value {
            
            // 1 In the case where the node is a leaf node, you simply return nil, thereby removing the current node.
            if node.leftChild == nil && node.rightChild == nil { return nil }
            
            // 2 If the node has no left child, you return node.rightChild to reconnect the right subtree.
            if node.leftChild == nil { return node.rightChild }
            
            // 3 If the node has no right child, you return node.leftChild to reconnect the left subtree.
            if node.rightChild == nil { return node.leftChild }
            
            // 4 This is the case where the node to be removed has both a left and right child. You replace the node’s value with the smallest value from the right subtree. You then call remove on the right child to remove this swapped value.
            node.value = node.rightChild!.min.value
            node.rightChild = remove(node: node.rightChild, value: node.value)
            
        } else if value < node.value {
            node.leftChild = remove(node: node.leftChild, value: value)
        } else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }
        return node
    }
}

/// Example removing a node:
var exTree = exampleTree
exTree.remove(3)

/// Remember - the performance of operations on a BST can degrade to O(n) if the tree becomes unbalanced.


























