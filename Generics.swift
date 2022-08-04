// struct Queue<Element> {
//     private var elements: [Element]

    
//     init(_ elements: [Element]){
//         self.elements = elements
//     }
    
//     mutating func enqueue(_ element: Element) {
//         elements.append(element)
//     }
    
//     @discardableResult
//     mutating func dequeue() -> Element? {
//         guard !elements.isEmpty else {
//             return nil
//         }
//         return elements.remove(at: 0)
//     }
// }

// extension Queue: CustomStringConvertible {
//     var description: String {
//         elements.map({"\($0)"}).joined(separator: " ")
//     }
// }

// extension Queue: ExpressibleByArrayLiteral {
//     init(arrayLiteral elements: Element...) {
//         self.elements = elements
// }
// }

// var queue = Queue<Int>()
// queue.enqueue(0)
// queue.enqueue(3)
// queue.dequeue()
// print(queue)

// var queue2 = Queue<String>(["3", "46", "45", "3"])
// print(queue2)


struct Stack<Element> {
    private var elements: [Element] = []

    init(_ elements: [Element]) {
        self.elements = elements
    }
    mutating func push(_ element: Element) {
        elements.append(element)
    }
    @discardableResult
    mutating func pop() -> Element {
        elements.removeLast()
    }
    
}

extension Stack: CustomStringConvertible {
    var description: String {
        elements.map({"\($0)"}).joined(separator: " ")
    }
}
extension Stack: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.elements = elements
    }
}

struct Book {
    let bookName: String
}
extension Book: CustomStringConvertible {
    var description: String {
        return bookName
    }
}

var books = [
    Book(bookName: "book1"),
    Book(bookName: "book2"),
    Book(bookName: "book3")
]

var bookStack = Stack<Book>(books)
var secondBookStack = [books]
bookStack.push(Book(bookName: "newBook"))
print(bookStack)
bookStack.pop()
print(bookStack)




import Foundation
struct Person {
    let name = "Ganesh"
    var message: String {
        print("the message is")
        return "hi"
    }
    let hideMessage = false
}

let person = Person()
// func printMessage(_ message: String) {
//     if !person.hideMessage {
//         print(message)
//     }
// }
func printMessage(_ message: @autoclosure () -> String) {
    
    if !person.hideMessage {
        print(message())
    }
}

printMessage(person.message)


// var closure: (()->Void)?

// func getCode(completion: @escaping (()->Void)) {
//     // let code = "15171"
//     closure = completion
// }

// getCode() {
    
// }


// let queue = DispatchQueue(label: "String", attributes: .concurrent)

// func getInfo(closure: @escaping (String)-> Void) -> String {
//     let info = "this is a closure example"
//             queue.async {
//                 closure(info)
//                }
//     return "func returned"
// }

// func showInfo() {
//     getInfo { info in
//                 print(info)
//     }
// }

// print(showInfo())



// func messageResponse(_ response: @escaping (String) -> Void) {
//     print("Hey, how are you?")
    
//     DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//         response("Hi, I'm doing really good.")
//     }
  
//     print("Responding takes a while...")
// }

// messageResponse { friendResponse in
//     print(friendResponse)
// }



///////////////////////
import Foundation

extension Double {
    mutating func sqaure() {
        self = self * self
    }
}

var val = 1.5
val.sqaure()
print(val)

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}
let str = "hello"
print(str[1])

extension Int {
    enum IntType {
        case positive
        case negative
        case zero
    }
    var type: IntType {
        switch self {
            case 0: 
                return IntType.zero
            case let value where value > 0 : 
                return IntType.positive
            default: 
                return IntType.negative
        }
    }
}

print(0.type)


protocol PersonProtocol {
    init(code: Int)
}
class Person: PersonProtocol {
    var name: String = ""
    var code: Int 

    required init(code: Int) {
        self.code = code
    }
}
class Student: Person {
    
}

let person1 = Person(code: 10)

let student1 = Student(code: 1)
print(student1.code)


protocol Default {
    static var defaultValue: Self { get }
}

extension Optional where Wrapped: Default {

    var unwrap: Wrapped {
        switch self {
        case .none:
            return Wrapped.defaultValue
        case .some(let wrapped):
            return wrapped
        }
    }
}

extension Int: Default {
    static var defaultValue: Int {
        0
    }
}

extension String: Default {
    static var defaultValue: String {
        "0"
    }
}

var optionalVal: String? = "cats"

print(optionalVal.unwrap)



protocol Some {
    func someFunc() 
}
extension Some{
    func someFunc() {
        print("some")
    }
}

struct Test: Some {
//     func someFunc() {
//         print("instruct")
// }
}


Test().someFunc()



// protocol One {
//     var one: String {get}
// }

// protocol Two: One {
//     var two: String {get}
// }

// struct one: Two{
    
// }

