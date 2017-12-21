public struct Queue<T> {

    fileprivate var list = LinkedList<T>()
    
    public mutating func enqueue(_ element: T) {
        list.append(element)
    }
    
    public mutating func dequeue() -> T? {
        guard !list.isEmpty, let element = list.first else {
            return nil
        }
        list.remove(element)
        return element.value
    }
    public func peek() -> T? {
        return list.first?.value
    }
    
    public var isEmpty: Bool {
        return list.isEmpty
    }
}

extension Queue: CustomStringConvertible {
    public var description: String {
        return list.description
    }
}

var queue = Queue<Int>()
queue.enqueue(10)
queue.enqueue(3)
queue.enqueue(20)  // [10,3,20]
queue.dequeue() // [3,20]
print(queue) // [10,3,20]








