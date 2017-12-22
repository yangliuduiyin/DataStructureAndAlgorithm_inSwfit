//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, Binary Search."
// Goal: Quickly find an element in an array.
// Let's say you have an array of numbers and you want to determine whether a specific number is in that array, and if so, at which index.
/**
 Here's how binary search works:
 
 * Split the array in half and determine whether the thing you're looking for, known as the search key, is in the left half or in the right half.
 * How do you determine in which half the search key is? This is why you sorted the array first, so you can do a simple < or > comparison.
 * If the search key is in the left half, you repeat the process there: split the left half into two even smaller pieces and look in which piece the search key must lie. (Likewise for when it's the right half.)
 * This repeats until the search key is found. If the array cannot be split up any further, you must regrettably conclude that the search key is not present in the array.
 */

// Here is a recursive implementation of binary search in Swift:


func binarySearch<T: Comparable>(_ a: [T], key: T, range: Range<Int>) -> Int? {
    if range.lowerBound >= range.upperBound {
        return nil
    }else {
        let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
        if a[midIndex] > key {
            return binarySearch(a, key: key, range: range.lowerBound ..< midIndex)
        }else if a[midIndex] < key {
            return binarySearch(a, key: key, range: midIndex + 1 ..< range.upperBound)
        }else {
            return midIndex // If we get here, then we've found the search key!
        }
        
    }
}

let numbers = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67]

binarySearch(numbers, key: 43, range: 0 ..< numbers.count)  // gives 13
// Iterative vs recursive
/**
 Binary search is recursive in nature because you apply the same logic over and over again to smaller and smaller subarrays. However, that does not mean you must implement binarySearch() as a recursive function. It's often more efficient to convert a recursive algorithm into an iterative version, using a simple loop instead of lots of recursive function calls.
 */
// Here is an iterative implementation of binary search in Swift:
func binarySearchIterative<T: Comparable>(_ a: [T], key: T) -> Int? {
    var lowerBound = 0
    var upperBound = a.count
    while lowerBound < upperBound {
        let midIndex = lowerBound + (upperBound - lowerBound) / 2
        if a[midIndex] == key {
            return midIndex
        } else if a[midIndex] < key {
            lowerBound = midIndex + 1
        } else {
            upperBound = midIndex
        }
    }
    return nil
}



















