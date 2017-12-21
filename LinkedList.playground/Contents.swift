//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, LinkedList"

public class Node<T> {
    public var value: T
    public var next: Node<T>?
    public weak var previous: Node<T>?
    init(value: T) {
        self.value = value
    }
}

public struct LinkedList<T>: CustomStringConvertible {
    private var head: Node<T>?
    private var tail: Node<T>?
    
    public var isEmpty: Bool {
        return tail == nil
    }
    
    public var first: Node<T>? {
        return head
    }
    
    public var last: Node<T>? {
        return tail
    }
    
    public mutating func append(_ value: T) {
        let newNode = Node.init(value: value)
        if let tailNode = tail {
            newNode.previous = tailNode
            tailNode.next = newNode
        }else {
            head = newNode
        }
        tail = newNode
    }
    
    public func nodeAt(_ index: Int) -> Node<T>? {
        if index >= 0 {
            var node = head
            var i = index
            while node != nil {
                if i == 0 {
                    return node
                }
                i -= 1
                node = node!.next
            }
        }
        return nil
    }
    
    public mutating func removeAll() {
        head = nil
        tail = nil
    }
    
    public mutating func remove(node: Node<T>) -> T {
        let prev = node.previous
        let next = node.next
        if let prev = prev {
            prev.next = next
        }else {
            head = next
        }
        next?.previous = prev
        if next == nil {
            tail = prev
        }
        node.previous = nil
        node.next = nil
        return node.value
    }
    public var description: String {
        var text = "["
        var node = head
        while node != nil {
            text += "\(node!.value)"
            node = node!.next
            if node != nil {
                text += ", "
            }
        }
        return text + "]"
    }
}
// TEST:
var dogBreeds = LinkedList<String>()
dogBreeds.append("Labrador")
dogBreeds.append("Bulldog")
dogBreeds.append("Beagle")
dogBreeds.append("Husky")
print(dogBreeds)
print(dogBreeds.nodeAt(2)?.value ?? "no value")

























