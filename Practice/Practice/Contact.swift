import Foundation

struct Contact: Identifiable {
    let id = UUID()
    var name: String?
    var number: Int?
    var emailId: String?
    var firstLetter: String{
        get{
            String(self.name.unwrap.prefix(1))
        }
    }
}

let contacts = [Contact(name: nil, number: 7558104648, emailId: "ganeshmurugan0123@gmail.com"),
                Contact(name: "Ashiq", number: 7339278868, emailId: "furyphoenixyt@gmail.com"),
                   Contact(name: "Jeyanth", number: 9432123012, emailId: "ganeshmurugan0123@gmail.com"),
                   Contact(name: "Vikash", number: 1561245622, emailId: "ganeshmurugan0123@gmail.com"),
                   Contact(name: "Durai", number: 7558104648, emailId: "ganeshmurugan0123@gmail.com"),
                   Contact(name: "Hari", number: 7558104648, emailId: "ganeshmurugan0123@gmail.com"),
                   Contact(name: "Santhoshsubramani", number: 7558104648, emailId: "ganeshmurugan0123@gmail.com"),
                   Contact(name: "Saran", number: 7558104648, emailId: "ganeshmurugan0123@gmail.com"),
                   Contact(name: "Nithish", number: 7558104648, emailId: "ganeshmurugan0123@gmail.com"),Contact(name: "Ganesh", number: 7558104648, emailId: "ganeshmurugan0123@gmail.com"),
                   Contact(name: nil, number: 7339278868, emailId: "furyphoenixyt@gmail.com"),
                   Contact(name: "Jeyanth", number: 9432123012, emailId: "ganeshmurugan0123@gmail.com"),
                   Contact(name: "Vikash", number: 1561245622, emailId: "ganeshmurugan0123@gmail.com"),
                   Contact(name: "Vikash Babu", number: 1561245622, emailId: "ganeshmurugan0123@gmail.com"),
                   Contact(name: "Durai", number: 7558104648, emailId: "ganeshmurugan0123@gmail.com"),
                   Contact(name: "Hari", number: 7558104648, emailId: "ganeshmurugan0123@gmail.com"),
                   Contact(name: "Santhoshsubramani", number: 7558104648, emailId: "ganeshmurugan0123@gmail.com"),
                   Contact(name: "Saran", number: 7558104648, emailId: "ganeshmurugan0123@gmail.com"),
                   Contact(name: "Nithish", number: 7558104648, emailId: "ganeshmurugan0123@gmail.com")]


var sortedList = contacts.sort{$0.name.unwrap}.unique({$0.name == $1.name})




//var contactSections = [[Contacts]]()
