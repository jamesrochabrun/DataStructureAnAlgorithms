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
}

/// ---Example of Push---

var list = LinkedList<Int>()
list.push(3)
list.push(2)
list.push(1)

print(list)










