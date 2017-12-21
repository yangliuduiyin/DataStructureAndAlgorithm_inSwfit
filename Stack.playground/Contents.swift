//: Playground - noun: a place where people can play

import UIKit

struct Stack<Element> {
    // 先测试通过某种类型,再将其改为泛型
    fileprivate var array: [Element] = []
    
    mutating func push(_ element: Element) {
        array.append(element)
    }
    mutating func pop() -> Element? {
        return array.popLast()
    }
    
   func peek() -> Element? {
        return array.last
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    var count: Int {
        return array.count
    }
}

var rwBookStack = Stack<String>()
rwBookStack.push("3D Games by Tutorials")
rwBookStack.push("tvOS Apprentice")
rwBookStack.push("iOS Apprentice")
rwBookStack.push("Swift Apprentice")
print(rwBookStack)

extension Stack: CustomStringConvertible {
    var description: String {
        let topDivider = "---Stack---\n"
        let bottomDivide = "\n--------------\n"
        let stackElements = array.map {
            "\($0)"
        }.reversed().joined(separator: "\n")
        return topDivider + stackElements + bottomDivide
    }
}

















