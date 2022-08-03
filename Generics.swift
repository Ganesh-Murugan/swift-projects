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
