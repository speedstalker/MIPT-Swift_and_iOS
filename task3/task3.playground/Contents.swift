import Foundation

let asdf: AnyObject = Int(10)
asdf as! Int

protocol DictionaryCoding {
    init(dictionary: [String : AnyObject]) throws
    var dictionary: [String : AnyObject] { get }
}

//----------
// Person
//----------
struct Person: CustomStringConvertible {
    // As for the ! optionals:
    // http://stackoverflow.hex1.ru/questions/32850974/failable-initializers-for-classes-in-swift-2?rq=1
    //
    // If I remove '!' from parameter names, I still get an error: "Return from initializer without initializing all stored properties", despite the fact, that I have latest Xcode version =(
    var firstName:  String!
    var secondName: String!
    var age:        Int!
    
    enum NameOfProperties: String {
        case firstName, secondName, age
        
        // in order to iterate through enum:
        // http://stackoverflow.com/questions/24007461/how-to-enumerate-an-enum-with-string-type/24137319#24137319
        static let allValues = [Person.NameOfProperties.firstName,
                                Person.NameOfProperties.secondName,
                                Person.NameOfProperties.age]
    }
    
    var description: String {
        return firstName + " " + secondName + ", " + "\(age)" + " years old"
    }
}

enum KeywordsErrors: ErrorType {
    case NoValueForKey(String)
    case TypeCheckFailure(expectedType: Any.Type, receivedType: Any.Type)
}

extension Person: DictionaryCoding {
    
    init(dictionary: [String : AnyObject]) throws {
        
        for nameOfProperty in Person.NameOfProperties.allValues {
            
            if let propertyValue = dictionary[nameOfProperty.rawValue] {
                switch nameOfProperty {
                
                case Person.NameOfProperties.firstName:
                    if let propertyValueAsString = propertyValue as? String {
                        self.firstName = propertyValueAsString
                    } else {
                        throw KeywordsErrors.TypeCheckFailure(expectedType: String.self, receivedType: propertyValue.dynamicType)
                    }
                
                case Person.NameOfProperties.secondName:
                    if let propertyValueAsString = propertyValue as? String {
                        self.secondName = propertyValueAsString
                    } else {
                        throw KeywordsErrors.TypeCheckFailure(expectedType: String.self, receivedType: propertyValue.dynamicType)
                    }
                
                case Person.NameOfProperties.age:
                    if let propertyValueAsInt = propertyValue as? Int {
                        self.age = propertyValueAsInt
                    } else {
                        throw KeywordsErrors.TypeCheckFailure(expectedType: Int.self, receivedType: propertyValue.dynamicType)
                    }
                }
            } else {
                throw KeywordsErrors.NoValueForKey(nameOfProperty.rawValue)
            }
        }
    }
    
    var dictionary: [String : AnyObject] {
        return [Person.NameOfProperties.firstName.rawValue : self.firstName,
                Person.NameOfProperties.secondName.rawValue : self.secondName,
                Person.NameOfProperties.age.rawValue : self.age]
    }
}





var dict = ["firstName" : "Roman", "secondName" : "Anufriev", "age" : 21]
let Roman = try! Person(dictionary: dict)

let clone = try! Person(dictionary: Roman.dictionary)

print ("I am \(Roman.description).")
print ("My info: \(Roman.dictionary).")





let wrongDict1 = ["firstName" : "Roman", "secondName" : "Anufriev"]

do {
    let notPerson = try Person(dictionary: wrongDict1)
} catch KeywordsErrors.NoValueForKey(let message) {
    print ("no value for key \"\(message)\"")
} catch KeywordsErrors.TypeCheckFailure(let expectedType, let receivedType) {
    print ("Expected type \(expectedType), got \(receivedType)")
} catch {
    print ("Error info: \(error)")
}


let wrongDict2 = ["firstName" : "Roman", "secondName" : "Anufriev", "age" : "42"]

do {
    let notPerson = try Person(dictionary: wrongDict2)
} catch KeywordsErrors.NoValueForKey(let message) {
    print ("no value for \"\(message)\"")
} catch KeywordsErrors.TypeCheckFailure(let expectedType, let receivedType) {
    print ("Expected type \(expectedType), got \(receivedType)")
} catch {
    print ("Error info: \(error)")
}
