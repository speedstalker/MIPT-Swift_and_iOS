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
var tmp: Float = -Float.infinity
var tmp2 = Double(tmp)

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











