//: Playground - noun: a place where people can play

import UIKit

/*
 A linked list is a chain of nodes. Nodes have two responsibilities:
1. Hold a value.
2. Hold a reference to the next node. A nil value represents the end of the list.
 */

public class Node<Value> {
    
    public var value: Value
    public var next: Node?
    
    public init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible {
    
    public var description: String {
        guard let next = next else { return "\(value)" }
        return "\(value) -> " + String(describing: next) + " "
    }
}

/// ---Example of creating and linking nodes---

let node1 = Node(value: 1)
let node2 = Node(value: 2)
let node3 = Node(value: 3)

node1.next = node2
node2.next = node3

print(node1)


/// Creating a Linked list:

/*
A linked list has the concept of a head and tail,
which refers to the first and last nodes of the list respectively:
*/

public struct LinkedList<Value> {
    
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init() {}
    
    public var isEmpty: Bool {
        return head == nil
    }
}

extension LinkedList: CustomStringConvertible {
    
    public var description: String {
        guard let head = head else { return "Empty list" }
        return String(describing: head)
    }
    
    /// Adding values to the list
    
    /*
     There are three ways to add values to a linked list, each having their own unique performance characteristics:
     */
    
    // Push - Adding a value at the front of the list is known as a push operation. This is also known as head-first insertion.
    public mutating func push(_ value: Value) {
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    // Append - This is meant to add a value at the end of the list, and is known as tail-end insertion.
    public mutating func append(_ value: Value) {
        // 1
        guard !isEmpty else {
            push(value)
            return
        }
        // 2
        tail!.next = Node(value: value)
        // 3
        tail = tail!.next
    }
    
    // Insert After - This operation inserts a value at a particular place in the list, and requires two steps:
    
        /// 1. Finding a particular node in the list.
        /// 2. Inserting the new node.
    
    public func node(at index: Int) -> Node<Value>? {
        // a.- You create a new reference to head and keep track of the current number of traversals.
        var currentNode = head
        var currentIndex = 0
        // b.- Using a while loop, you move the reference down the list until you’ve reached the desired index. Empty lists or out-of-bounds indexes will result in a nil return value.
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        return currentNode
    }
    
    // a.- discardableResult lets callers ignore the return value of this method without the compiler jumping up and down warning you about it.
    @discardableResult
    public mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        
        // b.- In the case where this method is called with the tail node, you’ll call the functionally equivalent append method. This will take care of updating tail.
        guard tail !== node else {
            append(value)
            return tail!
        }
        // c.- Otherwise, you simply link up the new node with the rest of the list and return the new node.
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
}

/// ---Example of Push---

var list = LinkedList<Int>()
list.push(1)
list.push(2)
list.push(3)

print(list)

/// ---Example of Append---

var list1 = LinkedList<Int>()
list1.append(1)
list1.append(2)
list1.append(3)
print(list1)

/// ---Example of Insert at---
print("Before inserting \(list1)")
var middleNode = list1.node(at: 1)!
for _ in 1...2 {
    middleNode = list1.insert(8, after: middleNode)
}
print("After inserting \(list1)")












