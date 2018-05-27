//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
print("\(str) and Hello Andrei")

var array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 1, 1, 1, 1]

// Map
array.map { print($0) }

// Creating a new array where each element is incremented by 100
let by100 = array.map { $0 + 100 }
by100.map { print($0) }

// Filter elements equal to 1
let equalTo = array.filter { return $0 == 1 }
equalTo.map { print($0) }
