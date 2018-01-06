//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, BinarySearchTree!"
// MARK: - Index:
/**
 * 1.'Always sorted'property.
 Each left child is smaller than its parent node, and each right child is greater than its parent node. This is the key feature of a binary search tree.
 * 2. Inserting new nodes.
 * 3. Searching the tree.
 * 4. Traversing the tree.
      a. In-order: left child -> node -> right child
      b. Pre-order: node -> left -> right
      c. Post-order: left -> right -> node
 * 5. Deleting nodes.
 *
 
 
 */
// MARK: - solution 1 ---Class

public class BinarySearchTree<T: Comparable> {
    private (set) public var value: T
    private (set) public var parent: BinarySearchTree?
    private (set) public var left: BinarySearchTree?
    private (set) public var right: BinarySearchTree?
    
    init(value: T) {
        self.value = value
    }
    
    public var isRoot: Bool {
        return parent == nil
    }
    
    public var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    public var isLeftChild: Bool {
        return parent?.left === self
    }
    
    public var isRightChild: Bool {
        return parent?.right === self
    }
    
    public var hasLeftChild: Bool {
        return left != nil
    }
    
    public var hasRightChild: Bool {
        return right != nil
    }
    
    public var hasAnyChild: Bool {
        return hasLeftChild || hasRightChild
    }
    
    public var hasBothChild: Bool {
        return hasLeftChild && hasRightChild
    }
    
    public var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    
    public func insert(value: T) {
        if value < self.value {
            if let left = left {
                left.insert(value: value)
            }else {
                left = BinarySearchTree(value: value)
                left?.parent = self
            }
        }else {
            if let right = right {
                right.insert(value: value)
            }else {
                right = BinarySearchTree(value: value)
                right?.parent = self
            }
        }
    }
    
    public convenience init(array: [T]) {
        precondition(array.count > 0)
        self.init(value: array.first!)
        for v in array.dropFirst() {
            insert(value: v)
        }
    }
    
    public func search(value: T) -> BinarySearchTree? {
        if value < self.value {
            return left?.search(value: value)
        }else if value > self.value {
            return self.right?.search(value: value)
        }else {
            return self // found it.
        }
    }
    
    // MARK: - iterator
    public func searchByIterator(value: T) -> BinarySearchTree? {
        var node: BinarySearchTree? = self
        while let n = node {
            if value < n.value {
                node = n.left
            }else if value > n.value {
                node = n.right
            }else {
                return node
            }
        }
        return nil
    }
    
    // MARK: - Traversal:
    public func traversalInOrder(process: (T) -> Void) {
        left?.traversalInOrder(process: process)
        process(value)
        right?.traversalInOrder(process: process)
    }
    
    public func traversalPreOrder(process: (T) -> Void) {
        process(value)
        left?.traversalPreOrder(process: process)
        right?.traversalPreOrder(process: process)
    }
    
    public func traversalPostOrder(process: (T) -> Void) {
        left?.traversalPostOrder(process: process)
        right?.traversalPostOrder(process: process)
        process(value)
    }
}

extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        var s = ""
        if let left = left {
            s += "(\(left.description)) <- "
        }
        s += "\(value)"
        if let right = right {
            s += " -> (\(right.description)"
        }
        return s
    }
}

extension BinarySearchTree {
    // map : In-order
    public func map(formula: (T) -> T) -> [T] {
        var a = [T]()
        if let left = left {
            a += left.map(formula: formula)
        }
        a.append(value)
        if let right = right {
            a += right.map(formula: formula)
        }
        return a
    }
    
    public func toArray() -> [T] {
        return self.map(formula: {
            $0
        })
    }
}
let tree0 = BinarySearchTree<Int>(value: 7)
tree0.insert(value: 2)
tree0.insert(value: 5)
tree0.insert(value: 10)
tree0.insert(value: 9)
tree0.insert(value: 1)

let tree1 = BinarySearchTree(array: [7,2,5,10,9,1])

print(tree0) // ((1) <- 2 -> (5) <- 7 -> ((9) <- 10
tree0.search(value: 2)
tree0.search(value: 20) // nil

tree0.traversalInOrder {
    print($0)
    /**
     1
     2
     5
     7
     9
     10
     */
}
tree0.toArray() // [1,2,5,7,9,10]

// MARK: - deleting nodes
extension BinarySearchTree {
    // We can make the code more readable by defining some helper functions.
    private func reconnectParentToNode(node: BinarySearchTree?) {
        if let parent = parent {
            if isLeftChild {
                parent.left = node
            }else {
                parent.right = node
            }
        }
        node?.parent = parent
    }
    
    public func minimum() -> BinarySearchTree {
        var node = self
        while let next = node.left {
            node = next
        }
        return node
    }
    
    public func maximum() -> BinarySearchTree {
        var node = self
        while let next = node.right {
            node = next
        }
        return node
    }
    
    @discardableResult public func remove() -> BinarySearchTree? {
        let replacement: BinarySearchTree?
        // Replacement for current node can be either biggest one on the left or smallest one on the right, whichever is not nil.
        if let right = right {
            replacement = right.minimum()
        }else if let left = left {
            replacement = left.maximum()
        }else {
            replacement = nil
        }
        
        replacement?.remove()
        // Place the replacement on current node's position
        replacement?.right = right
        replacement?.left = left
        right?.parent = replacement
        left?.parent = replacement
        reconnectParentToNode(node: replacement)
        
        // The current node is no longer part of the tree, so clean it up.
        parent = nil
        left = nil
        right = nil
        return replacement
    }
    
    // MARK: - Depth and height
    public func height() -> Int {
        if isLeaf {
            return 0
        }else {
            return 1 + max(left?.height() ?? 0, right?.height() ?? 0)
        }
    }
    
    public func depth() -> Int {
        var node = self
        var edgs = 0
        while let parent = node.parent {
            node = parent
            edgs += 1
        }
        return edgs
    }
    
    // MARK: - Predecessor and successor
    // The predecessor() function returns the node whose value precedes the current value in sorted order:
    public func predecessor() -> BinarySearchTree? {
        if let left = left {
            return left.maximum()
        }else {
            var node = self
            while let parent = node.parent {
                if parent.value < value { return parent }
                node = parent
            }
            return nil
        }
    }
    
    public func successor() -> BinarySearchTree? {
        if let right = right {
            return right.minimum()
        }else {
            var node = self
            while let parent = node.parent {
                if parent.value > value { return parent }
                node = parent
            }
            return nil
        }
    }
    
    public func isBST(minValue: T, maxValue: T) -> Bool {
        if value < minValue || value > maxValue { return false }
        let leftBST = left?.isBST(minValue: minValue, maxValue: value) ?? true
        let rightBST = right?.isBST(minValue: value, maxValue: maxValue) ?? true
        return leftBST && rightBST
    }
}

tree0.height() // 2
tree0.depth() // 0
tree0.predecessor() // 5.
if let node9 = tree0.search(value: 9) {
    node9.depth() // returns 2
}
if let node1 = tree0.search(value: 1) {
    node1.isBST(minValue: Int.min, maxValue: Int.max) // true
    node1.insert(value: 100)
    tree0.search(value: 100) // nil
    tree0.isBST(minValue: Int.min, maxValue: Int.max) // false
    
}
tree0.search(value: 100) // nil


// MARK: - 使用枚举实现二叉搜索树
/**
 The difference is reference semantics versus value semantics. Making a change to the class-based tree will update that same instance in memory, but the enum-based tree is immutable -- any insertions or deletions will give you an entirely new copy of the tree. Which one is best, totally depends on what you want to use it for.
 */
// 区别在于引用语义与值语义。对基于类的树进行更改将更新内存中的相同实例，但基于枚举的树是不可变的 - 任何插入或删除操作都将为您提供树的全新副本。哪一个最好,完全取决于你使用它做什么。




























