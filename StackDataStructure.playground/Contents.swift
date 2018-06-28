import UIKit

//Chapyter 4 Stacks

///The stack data structure is identical in concept to a physical stack of objects. When you add an item to a stack, you place it on top of the stack. When you remove an item from a stack, you always remove the topmost item.

/*
 There are only two essential operations for a stack: • push - adding an element to the top of the stack • pop - removing the top element of the stack
 This means you can only add or remove elements from one side of the data structure. In computer science, a stack is known as the LIFO (last in first out) data structure. Elements that are pushed in last are the first ones to be popped out.
 
 */

public struct Stack<Element> {
    
    private var storage: [Element] = []
    public init() {}
}

extension Stack: CustomStringConvertible {
    
    public var description: String {
        let topDivider = "----top----\n"
        let bottomDivider = "\n-----------"
        let stackElements = storage
            .map { "\($0)" }
            .reversed()
            .joined(separator: "\n")
        return topDivider + stackElements + bottomDivider
    }
    
    // Push
    public mutating func push(_ element: Element) {
        storage.append(element)
    }

    // Pop
    public mutating func pop() -> Element? {
        return storage.popLast()
    }
    
    // Non - essential operations
    public func peek() -> Element? {
        return storage.last
    }
    
    public var isEmpty: Bool {
        return peek() == nil
    }
}

/// Example
    var stack = Stack<Int>()
    stack.push(1)
    stack.push(2)
    stack.push(3)
    stack.push(4)
    print(stack)
    if let poppedElement = stack.pop() {
        assert(4 == poppedElement)
        print("Popped: \(poppedElement)")
    }

// Less is more - You might want to take an existing array and convert it to a stack so that the access order is guaranteed. Of course it would be possible to loop through the array elements and push each element. However, since you can write an initializer that just sets the underlying private storage.

extension Stack {
    
    public init(_ elements: [Element]) {
     storage = elements
    }
}

// You can go a step further and make your stack initializable from an array literal.

extension Stack: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
}

/*
 Conclussion
 
 Stacks are crucial to problems that search trees and graphs. Imagine finding your way through a maze. Each time you come to a decision point of left right or straight you can push all possible decisions onto your stack. When you hit a dead end, simply backtrack by popping from the stack and continuing until you escape or hit another dead end.
 
 */
