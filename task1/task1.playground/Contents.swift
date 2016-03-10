//
// This is Roman Anufriev's playground for first Swift task.
//
// Here I implement structure 'Book' with different properties.
// You can collect books into 'personalLibraries'.
//

//----------
enum Price: CustomStringConvertible {
    case Free
    case ActualPrice(Double)
    
    var description: String {
        switch self {
        case .Free:
            return "free"
        case .ActualPrice(let amountOfBucks):
            return String(amountOfBucks)
        }
    }
}

let free = Price.Free
let fifteenBucks = Price.ActualPrice(15.23)

//----------
protocol OnlineAvailable: CustomStringConvertible {
    var price: Price? { get set }
    var downloadLink: String? { get set }
}

//----------
enum Genre: String, CustomStringConvertible {
    case Biography, Detective, Documentary, Drama, Educational, Fantasy, Horror, Novel, Poetry, Scifi, Western, Other
    
    var description: String {
        return self.rawValue.lowercaseString
    }
}

let dramaGenre = Genre.Drama
print(dramaGenre)

//----------
struct Book: OnlineAvailable, CustomStringConvertible {
    let title: String
    let author: String
    let genre: Genre
    
    var price: Price?
    var downloadLink: String?
    
    var description: String {
        return "\"\(title)\"" + " written by " + author
    }
}

let favouriteBook = Book(title: "Three Comrades", author: "Erich Maria Remarque", genre: .Novel, price: fifteenBucks, downloadLink: "http://www.amazon.com/Three-Comrades-Erich-Maria-Remarque/dp/0449912426/")

let goodTutorial = Book(title: "The Swift Programming Language", author: "Chris Lattner & Apple Inc.", genre: .Educational, price: .Free, downloadLink: "https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/index.html")

print("My favourite book is \(favouriteBook).", terminator: " ")
print("The genre of this book is \(favouriteBook.genre).")
print("You can buy it on Amazon (\(favouriteBook.downloadLink)) for \(favouriteBook.price)$.")

//----------
struct personalLibrary: CustomStringConvertible {
    let ownerName: String
    
    var books: [Book]
    var numberOfBooks: Int {
        return books.count
    }
    
    var description: String {
        var pluralEnding: String
        if numberOfBooks < 2 {
            pluralEnding = ""
        } else {
            pluralEnding = "s"
        }
        return "This is " + ownerName + "'s personal library. Here you can find " + String(numberOfBooks) + " book" + pluralEnding + "."
    }
}

var myBooks: [Book] = [favouriteBook, goodTutorial]
var myLibrary = personalLibrary(ownerName: "Roman Anufriev", books: myBooks)
print(myLibrary)
print("The \(myLibrary.books[1].genre) book I am currently reading is \(myLibrary.books[1])")
print("Apple did a great job making this book downloadable for \(myLibrary.books[1].price) on \(myLibrary.books[1].downloadLink).")









