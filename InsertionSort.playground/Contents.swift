//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, InsertionSort"
// [8|,3,5,4,6]
// Insertion sort is a stable sort
/**
 The worst-case and average case performance of insertion sort is O(n^2). That's because there are two nested loops in this function. Other sort algorithms, such as quicksort and merge sort, have O(n log n) performance, which is faster on large inputs.
 */
func insertedSort(_ array: [Int]) -> [Int] {
    var a = array
    for x in 1..<array.count {
        var y = x
        while y > 0 && a[y] < a[y-1] {
            a.swapAt(y-1, y)
            y -= 1
        }
        
    }
    return a
}

let b = insertedSort([8,3,5,4,6])
print(b)

// [8|,3,5,4,6]
func insertionSort<T>(_ array: [T], _ isOrderedBefore: (T,T) -> Bool) -> [T] {
    var a = array
    for x in 1..<a.count {
        var y = x
        let temp = a[y]
        while y > 0 && isOrderedBefore(temp, a[y-1]) {
            a[y] = a[y-1]
            y -= 1
        }
        a[y] = temp
    }
    return a
}
let numbers = [10,-1,3,9,2,27,8,5,1,3,0,26]
let c = insertionSort(numbers, <)
let d = insertionSort(numbers, >)











