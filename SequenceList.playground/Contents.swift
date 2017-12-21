//: Playground - noun: a place where people can play

import UIKit
// 算法与数据结构(一) 线性表的顺序存储与链式存储(Swift版)
var str = "Hello, SequenceList"

class SuquenceList {
    private var list = NSMutableArray()
    private var count = 0
    private var capcity = 0
    
    // 元素的个数:
    var length: Int {
        get {
            return count
        }
    }
}

// MARK: - 往顺序线性表中插入数据

extension SuquenceList {
    func insert(item: String, index: Int) -> Bool {
        if !checkIndex(index) {
            return false
        }
        var i = count
        while i > index {
            list[i] = list[i-1]
            i -= 1
        }
        list[index] = item
        count += 1
        return true
    }
    
    private func checkIndex(_ index: Int) -> Bool {
        return true
    }
}

// MARK: - 根据下标删除元素
extension SuquenceList {
    func removeItem(_ index: Int) -> Bool {
        if !checkIndex(index) {
            return false
        }
        for i in index..<count - 1 {
            list[i] = list[i+1]
        }
        count -= 1
        list.removeLastObject()
        return true
    }
}

// MARK: - 线性表的单链存储



















