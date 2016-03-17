//
// This is Roman Anufriev's playground for second Swift task.
//

// Artemiy explanation:

import Foundation

protocol RandomInstanceProtocol {
    static func randomInstance() -> Self
}

struct Animal: RandomInstanceProtocol {
    let nickName: String
    static func randomInstance() -> Animal {
        return Animal(nickName: "random nick name")
    }
}

//extension RandomInstanceProtocol {
//    static func randomArray(size: Int) -> [Self] {
//        return [Self.randomInstance(), Self.randomInstance()]
//    }
//}

//
//  Your task:
//  1. adopt this for Int, String, Float, Character
//  2. custom structure that adopts `RandomInstanceProtocol`
//

// my part:

extension RandomInstanceProtocol {
    static func makeArrayOfRandomInstances(size: Int) -> [Self] {
        var arr = [Self]()
        for _ in 1...size {
            arr.append(randomInstance())
        }
        return arr
    }
}

//----------
// Int
//----------
extension Int: RandomInstanceProtocol {
    
    static var lowerBound: Int = Int.min {
        willSet {
            if (newValue < Int.min) || (Int.max <= newValue) {
                assertionFailure("\(newValue) is out of range")
            } else {
                if (newValue >= upperBound) { upperBound = newValue + 1 }                
            }
        }
    }
    static var upperBound: Int = Int.max {
        willSet {
            if (newValue <= Int.min) || (Int.max < newValue) {
                assertionFailure("\(newValue) is out of range")
            } else {
                if (newValue <= lowerBound) { lowerBound = newValue - 1 }                
            }
        }
    }
    
    static func randomInstance() -> Int {
        var rand = Double(arc4random())
        let divisor = (Double(upperBound) - Double(lowerBound)) / Double(UInt32.max)
        rand = rand * divisor - abs(Double(lowerBound))
        return Int(rand)
    }
    
    static func randomInstanceWithCustomBounds(customLowerBound customLowerBound: Int = Int.lowerBound, customUpperBound: Int = Int.upperBound) -> Int {
        let oldLowerBound = Int.lowerBound
        let oldUpperBound = Int.upperBound
        
        Int.lowerBound = customLowerBound
        Int.upperBound = customUpperBound
        
        let rand = randomInstance()
        
        Int.lowerBound = oldLowerBound
        Int.upperBound = oldUpperBound
        
        return rand
    }
}

var testInt = Int.randomInstance()

Int.lowerBound = -30
Int.upperBound = 50
var testInt2 = Int.randomInstance()

var testInt3 = Int.randomInstanceWithCustomBounds(customLowerBound: 0, customUpperBound: 7)

testInt = Int.randomInstance()

var arrOfInts = Int.makeArrayOfRandomInstances(5)

//----------
// Float
//----------
extension Float: RandomInstanceProtocol {
    
    static var lowerBound: Float = Float(Int.min) {
        willSet {
            if (newValue <= -Float.infinity) || (Float.infinity < newValue) {
                assertionFailure("\(newValue) is out of range")
            } else {
                if (newValue >= upperBound) { upperBound = newValue + 1 }                
            }
        }
    }
    static var upperBound: Float = Float(Int.max) {
        willSet {
            if (newValue <= -Float.infinity) || (Float.infinity <= newValue) {
                assertionFailure("\(newValue) is out of range")
            } else {
                if (newValue <= lowerBound) { lowerBound = newValue - 1 }                
            }
        }
    }
    
    static func randomInstance() -> Float {
        let rand = Double(arc4random())
        let divisor = (Double(upperBound) - Double(lowerBound)) / Double(UInt32.max)
        // rand = rand * divisor - abs(Double(lowerBound)) - do not working =/
        return Float(rand * divisor) - abs(lowerBound)
    }
    
    static func randomInstanceWithCustomBounds(customLowerBound customLowerBound: Float = Float.lowerBound, customUpperBound: Float = Float.upperBound) -> Float {
        let oldLowerBound = Float.lowerBound
        let oldUpperBound = Float.upperBound
        
        Float.lowerBound = customLowerBound
        Float.upperBound = customUpperBound
        
        let rand = randomInstance()
        
        Float.lowerBound = oldLowerBound
        Float.upperBound = oldUpperBound
        
        return rand
    }
}

var testFloat = Float.randomInstance()

Float.lowerBound = -31.56
Float.upperBound = 55.99
var testFloat2 = Float.randomInstance()

var testFloat3 = Float.randomInstanceWithCustomBounds(customLowerBound: 0.3, customUpperBound: 7.5)

testFloat = Float.randomInstance()

var arrOfFloats = Float.makeArrayOfRandomInstances(5)

//---------------
// Character
//---------------

// was adopted from: https://medium.com/@skreutzb/random-swift-part-2-872276490de7#.u2bblr4rv
extension Character: RandomInstanceProtocol {
    static func randomInstance() -> Character {
        var decValue = 0  // ascii decimal value of a character
        let charType = Int(arc4random_uniform(4))
        
        switch charType {
        case 1:  // digit: random Int between 48 and 57
            decValue = Int(arc4random_uniform(10)) + 48
        case 2:  // uppercase letter
            decValue = Int(arc4random_uniform(26)) + 65
        case 3:  // lowercase letter
            decValue = Int(arc4random_uniform(26)) + 97
        default:  // space character
            decValue = 32
        }
        // get ASCII character from random decimal value
        return Character(UnicodeScalar(decValue))
    }
}

var testChar = Character.randomInstance()
testChar = Character.randomInstance()
testChar = Character.randomInstance()
testChar = Character.randomInstance()
testChar = Character.randomInstance()

var arrOfChars = Character.makeArrayOfRandomInstances(10)

//---------------
// String
//---------------
extension String: RandomInstanceProtocol {
    static var length = 15 {
        willSet {
            if (newValue < 0) || (newValue > Int.max) { assertionFailure("\(length) is out of range") }
        }
    }
    
    static func randomInstance() -> String {
        var text = ""
        for _ in 1...length {
            let randChar = Character.randomInstance()
            text = text + String(randChar)
        }
        return text
    }
    
    static func randomInstanceWithCustomLength(customLength: Int) -> String {
        let oldLength = String.length
        String.length = customLength
        
        let rand = randomInstance()
        
        String.length = oldLength
        return rand
    }
}

var testStr = String.randomInstance()
testStr = String.randomInstance()

var testStr2 = String.randomInstanceWithCustomLength(100)

var arrOfStrs = String.makeArrayOfRandomInstances(10)

//------------------
// Custom structure
//------------------
enum Genre: Int {
    case Biography, Detective, Documentary, Drama, Educational, Fantasy, Horror, Novel, Poetry, Scifi, Western, Other
}

struct Book: CustomStringConvertible {
    let title: String
    let author: String
    let genre: Genre
    
    var description: String {
        return "\"\(title)\"" + " written by " + author
    }
}

extension Book: RandomInstanceProtocol {
    static func randomInstance() -> Book {
        return Book(title: String.randomInstanceWithCustomLength(30), author: String.randomInstance(), genre: Genre(rawValue: Int.randomInstanceWithCustomBounds(customLowerBound: 0, customUpperBound: Genre.Other.rawValue))!)
    }
}

let randBook = Book.randomInstance()

var arrOfRandBooks = Book.makeArrayOfRandomInstances(5)

