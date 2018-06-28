import UIKit

// Chapter 5 Queues

/*
 Queues use FIFO or first-in-first-out ordering, meaning the first element that was enqueued will be the first to get dequeued. Queues are handy when you need to maintain the order of your elements to process later.
 */

// Common operations

public protocol Queue {
    
    associatedtype Element
    /// enqueue: Insert an element at the back of the queue. Returns true if the operation was successful.
    mutating func enqueue(_ element: Element) -> Bool
    /// dequeue: Remove the element at the front of the queue and return it.
    mutating func dequeue() -> Element?
    /// isEmpty: Check if the queue is empty.
    var isEmpty: Bool { get }
    // peek: Return the element at the front of the queue without removing it
    var peek: Element? { get }
}

/// Notice that the queue only cares about removal from the front, and insertion at the back. You don’t really need to know what the contents are in between. If you did, you would probably just use an array.

// Array-based implementation

///Here you’ve defined a generic QueueArray struct that adopts the Queue protocol. Note that the associated type Element is inferred by the type parameter T.
public struct QueueArray<T>: Queue {
    
    private var array: [T] = []
    public init() {}
    
    // Using the features of Array, you get the following for free:
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var peek: T? {
        return array.first
    }
    
    /// Regardless of the size of the array, enqueueing an element is an O(1) operation. This is because the array has empty space at the back.
    public mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    
    //If the queue is empty, dequeue simply returns nil. If not, it removes the element from the front of the array and returns it.
    public mutating func dequeue() -> T? {
        return isEmpty ? nil : array.removeFirst()
    }
    /// Removing an element from the front of the queue is an O(n) operation. To dequeue, you remove the element from the beginning of the array. This is always a linear time operation, because it requires all the remaining elements in the array to be shifted in memory.
}


/// Example:

var queue = QueueArray<String>()
queue.enqueue("Ray")
queue.enqueue("Brian")
queue.enqueue("Eric")
queue.dequeue()
queue
queue.peek

///This code puts Ray, Brian and Eric in the queue, then removes Ray and peeks at Brian
//but doesn’t remove him.

/// ShortComings: remove an item at the beginnning of the array its a 0(n) operation, adding elements in to the array can end in created extra no needed space as result of the double sizing of the array to store new elements.

// Doubly linked list implementation


