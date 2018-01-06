//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, BinarySearchTree with Enum"

public enum BinarySearchTree<T: Comparable> {
    case Empty
    case Leaf(T) // has no children
    indirect case Node(BinarySearchTree, T, BinarySearchTree) // Has one or two children. This is marked indirect so that it can hold BinarySearchTree values. Without indirect you can't make recursive enums.
    // NOTE: 该二叉树中的节点没有对其父节点的引用。这不是一个主要的障碍，但会使某些操作更加繁琐。
    
    public var count: Int {
        switch self {
        case .Empty: return 0
        case .Leaf: return 1
        case let .Node(left, _, right): return left.count + 1 + right.count
        }
    }
    
    public var height: Int {
        switch self {
        case .Empty: return 0
        case .Leaf: return 1
        case let .Node(left, _ , right): return 1 + max(left.height, right.height)
        }
    }
    
    public func insert(newValue: T) -> BinarySearchTree {
        switch self {
        case .Empty:
            return .Leaf(newValue)
        case .Leaf(let value):
            if newValue < value {
                return .Node(.Leaf(newValue), value, .Empty)
            }else {
                return .Node(.Empty, value, .Leaf(newValue))
            }
        case .Node(let left, let value, let right):
            if newValue < value {
                return .Node(left.insert(newValue: newValue), value, right)
            }else {
                return .Node(left,  value, right.insert(newValue: newValue))
            }
        }
    }
    
    // MARK: - Search
    public func search(x: T) -> BinarySearchTree? {
        switch self {
        case .Empty:
            return nil
        case .Leaf(let y):
            return (x == y) ? self : nil
        case let .Node(left, y, right):
            if x < y {
                return left.search(x: x)
            }else if y < x {
                return right.search(x: x)
            }else {
                return self
            }
        }
    }
}

extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        switch self {
        case .Empty:
            return "."
        case .Leaf(let value):
            return "\(value)"
        case let .Node(left, value, right):
            return "(\(left.description) <- \(value) -> \(right.description))"
        }
    }
}
var tree = BinarySearchTree.Leaf(7)
tree = tree.insert(newValue: 2)
tree = tree.insert(newValue: 5)
tree = tree.insert(newValue: 10)
tree = tree.insert(newValue: 9)
tree = tree.insert(newValue: 1)

tree.search(x: 10)
tree.search(x: 1)
tree.search(x: 100) // inl

print(tree) // ((1 <- 2 -> 5) <- 7 -> (9 <- 10 -> .))

// MARK: - When the tree becomes unbalanced...
/**
 A binary search tree is balanced when its left and right subtrees contain the same number of nodes. In that case, the height of the tree is log(n), where n is the number of nodes. That is the ideal situation.
 
 If one branch is significantly longer than the other, searching becomes very slow. We end up checking more values than we need. In the worst case, the height of the tree can become n. Such a tree acts like a linked list than a binary search tree, with performance degrading to O(n). Not good!
 
 One way to make the binary search tree balanced is to insert the nodes in a totally random order. On average that should balance out the tree well, but it not guaranteed, nor is it always practical.
 
 The other solution is to use a self-balancing binary tree. This type of data structure adjusts the tree to keep it balanced after you insert or delete nodes. To see examples, check AVL tree and red-black tree.
 */












