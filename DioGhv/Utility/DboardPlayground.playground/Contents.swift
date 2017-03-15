//: Playground - noun: a place where people can play

import UIKit
import Foundation

var s: String = "1"

let endIndex = s.index(before: s.endIndex)
s = s.substring(to: endIndex)
