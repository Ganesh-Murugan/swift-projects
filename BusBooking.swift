import Foundation
// import UIKit
extension Optional where Wrapped == String {
    var unwrap: String {
        self ?? ""
    }
}
extension Date{
    static func dateToString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMMM yyyy HH:mm:ss a"
        return dateFormatter.string(from: Date())
    }
}
extension String {
    var toInt: Int {
        Int(self) ?? -1
    }
}
extension Int {
    var toString: String {
        String(self)
    }
}
enum Places: CaseIterable {
    case chennai, tirunelveli, bangalore, kerala, delhi, karnataka, coimbatore
    
    static var printList: Void {
        Self.allCases.enumerated().forEach({print($0.offset + 1, ": ", $0.element)})
    }
}
enum Colors: String {
    case red = "🟥", green = "🟩"
    
    
}
enum TravelDetail: Equatable {
    //    enum TravelDetail {
    //        case from(_ place: Places),
    //             to(_ place: Places),
    //             Time(_ date: Date)
    //    }
    
    case travelDetail(from: Places, to: Places, time: Date? = nil)
    //    case travelLog(bus: BusModel, from: Places, to: Places, time: Date, rating: Int = 0)
}

protocol Model {
    var id: UUID {get set}
    var name: String {get set}
}

struct BookingModel {
    static var totalSeats = 20
    var from: Places
    var to: Places
    var time: String
    var occupiedBy = String()
    var occupiedSeats = [Int]()
    var occupiedSeatCount: Int {occupiedSeats.count}
    var availableSeats: Int { Self.totalSeats - occupiedSeatCount }
}

struct BusModel: Model {
    var id = UUID()
    var name: String
    var booking: [BookingModel]
}

struct UserModel: Model {
    var id = UUID()
    var name: String
    var password: String
    var loggedIn: Bool = false
    var userHistory = [UserBookings]()
}

struct UserBookings {
    var from: Places
    var to: Places
    var time: String
    var bus: String
    var seats: [Int]
}

class BusViewModel {
    var busList = BusList.busList
    
    func showList() {
        busList.printAll()
    }
    func availableBuses(from: Places, destination: Places) -> [BusModel]? {
        let filteredList = busList.filterList(from, destination)
        return filteredList
    }
    func addBooking(bus: BusModel, bookedSeat: BookingModel, index: Int){
        guard let busIndex = busList.getIndex(bus.id) else {
            return
        }
        busList[busIndex].booking[index] = bookedSeat
    }
}

class UserViewModel {
    var userList = UserList.userList
    
    func showList() {
        userList.printAll()
    }
    
    func verify(_ name: String, _ password: String) -> UserModel? {
        return userList.getUser(name, password)
    }
    
    func createUser(_ name: String, _ password: String) -> UserModel {
        let user = UserModel(name: name, password: password)
        userList.append(user)
        return user
    }
    
    func addUserBookings(user: UserModel, from: Places, to: Places, time: String, bus: String, seats: [Int]){
        guard let userIndex = userList.getIndex(user.id), !seats.isEmpty else {
            return
        }
        userList[userIndex].userHistory.append(UserBookings(from: from, to: to, time: time, bus: bus, seats: seats))
        print("Booking succus: \(userList[userIndex].name), bus: \(bus), time: \(time), from: \(from), to: \(to), seats: \(seats)")
    }
    func showUserHistory(_ user: UserModel){
        guard let userIndex = userList.getIndex(user.id) else {
            return
        }
        userList[userIndex].userHistory.forEach({print("bus: \($0.bus), time: \($0.time), from: \($0.from), to: \($0.to), seats: \($0.seats)")})
    }
}

extension Array where Element: Model {
    func getIndex(_ userId: UUID) -> Int? {
        self.firstIndex(where: {$0.id == userId})
    }
    
    func filterList(_ from: Places, _ to: Places)  -> [BusModel]? {
        let `self` = self as? [BusModel]
        return self?.filter{$0.booking.contains( where: {$0.from == from && $0.to == to})}
    }
    
    func printAll() {
        self.enumerated().forEach {
            if let element = $0.element as? UserModel {
                print("\($0.offset+1) Name: \(element.name)")
                element.userHistory.forEach({ print("\tfrom: \($0.from), to: \($0.to), time: \($0.time)")})
            } else if let element = $0.element as? BusModel {
                print("\($0.offset+1) Travels Name: \(element.name)")
                element.booking.forEach({ print("\tfrom: \($0.from), to: \($0.to), time: \($0.time)")})
            }
        }
    }
    
    func getUser(_ name: String, _ password: String) -> UserModel? {
        let `self` = self as? [UserModel]
        return self?.first {  $0.name == name && $0.password == password }
    }
}

class Booking {
    var currentUser: UserModel?{
        didSet { currentUser?.loggedIn = true
            currentUsername = currentUser?.name
        }
    }
    var currentUsername: String? = ""
    let busList = BusViewModel()
    let users = UserViewModel()
    
    func mainMenu() {
        while true {
        print("""
              1. Login
              2. SignUp
              """)
        let selection = readLine().unwrap
        switch selection {
        case "1": login()
        case "2": signUp()
        default : return
        }
        }
    }
    private func signUp(){
        print("Enter Name: ")
        let name = readLine().unwrap
        print("Enter New Password: ")
        let password = readLine().unwrap
        print("Confirm Password: ")
        let confirmPassword = readLine().unwrap
        
        guard password == confirmPassword else { return }
        
        let newUser = users.createUser(name, password)
        self.currentUser = newUser
        bookingMenu(newUser)
    }
     
    private func login() {
        let userName = readLine().unwrap
        let password = readLine().unwrap
        guard let loggedUser = users.verify(userName, password) else {
            return
        }
        self.currentUser = loggedUser
        bookingMenu(loggedUser)
    }
    
    private func logout() {
        currentUser?.loggedIn = false
        mainMenu()
    }
    private func bookingMenu(_ currentUser: UserModel) {
        while true {
            print("""
              1. Book a Ticket
              2. User History
              3. show all Buses
              4. Logout
              """)
            let selection = readLine().unwrap
            switch selection {
            case "1": book(currentUser)
            case "2": users.showUserHistory(currentUser)
            case "3": busList.showList()
            case "4": logout()
                return
            default : break
            }
        }
    }
    
    private func book(_ currentUser: UserModel) {
        let places = Places.allCases
        Places.printList
        print("Select From Location")
        let fromLocationIndex = readLine().unwrap.toInt - 1
        
        print("Select Destination Location")
        let toLocationIndex = readLine().unwrap.toInt - 1
        
        guard toLocationIndex >= 0, toLocationIndex < places.count,
              fromLocationIndex >= 0, fromLocationIndex < places.count,
              toLocationIndex != fromLocationIndex else {
            return
        }
        let from = places[fromLocationIndex]
        let to = places[toLocationIndex]
        
        guard let bus = busList.availableBuses(from: from, destination: to) else { return }
        
        guard let selectedBus = selectBus(bus) else { return }
        
        guard let bookedSeat = selectSeat(selectedBus, from, to, user: currentUsername.unwrap) else { return }
        
        busList.addBooking(bus: selectedBus, bookedSeat: bookedSeat.0, index: bookedSeat.1)
        users.addUserBookings(user: currentUser, from: from, to: to, time: bookedSeat.0.time, bus: selectedBus.name, seats: bookedSeat.2)
    }
    
    
}
extension Booking {
    private func selectBus(_ bus: [BusModel]) -> BusModel? {
        bus.printAll()
        let selectedBus = readLine().unwrap.toInt - 1
        guard selectedBus >= 0, selectedBus < bus.count else {
            return nil
        }
        return bus[selectedBus]
    }
    private func selectSeat(_ bus: BusModel, _ from: Places, _ to: Places, user: String) -> (BookingModel, Int, [Int])? {
        var finalSelection = [Int]()
        
        if let filteredSelection = bus.booking.firstIndex(where: {$0.from == from && $0.to == to}) {
            var bookedModel = bus.booking[filteredSelection]
            printSeats(bookedModel)
            while true {
                let selectedSeat = readLine().unwrap.toInt
                guard selectedSeat != -1 else { break }
                if selectedSeat > 0, selectedSeat <= 20,
                   !bookedModel.occupiedSeats.contains(selectedSeat),
                   !finalSelection.contains(selectedSeat)  {
                    finalSelection.append(selectedSeat)
                } else {print("seat unavailable")
                }
            }
            bookedModel.occupiedBy = user
            bookedModel.occupiedSeats.append(contentsOf: finalSelection)
            return (bookedModel, filteredSelection, finalSelection)
        }
        return nil
    }
    private func printSeats(_ bookedModel: BookingModel) {
        for seat in 1...BookingModel.totalSeats {
            let index = String(format: "%02d", seat)
            let color = bookedModel.occupiedSeats.contains(seat) ? Colors.red : Colors.green
            [4,8,12,16,20].contains(seat) ? print("\(index)\(color)", terminator: "\n") : print("\(index)\(color)", terminator: "\t")
        }
    }
}

struct BusList {
    static var busList: [BusModel] = [
        BusModel(name: "Sundara travels", booking: [
            BookingModel(from: .bangalore, to: .tirunelveli, time: "Friday, 01 July 2022 01:06:21 PM", occupiedSeats: [11]),
            BookingModel(from: .tirunelveli, to: .bangalore, time: "Friday, 01 July 2022 01:06:21 PM", occupiedSeats: [5,3]),
            BookingModel(from: .tirunelveli, to: .chennai, time: "Friday, 01 July 2022 01:06:21 PM", occupiedSeats: [1,3]),
            BookingModel(from: .chennai, to: .tirunelveli, time: "Friday, 01 July 2022 01:06:21 PM", occupiedSeats: [2,6]),
        ]),
        BusModel(name: "Jupyter travels", booking: [
            BookingModel(from: .tirunelveli, to: .chennai, time: "Friday, 01 July 2022 01:06:21 PM", occupiedSeats: [6,3]),
            BookingModel(from: .chennai, to: .tirunelveli, time: "Friday, 01 July 2022 01:06:21 PM", occupiedSeats: [2,27]),
            BookingModel(from: .bangalore, to: .chennai, time: "Friday, 01 July 2022 01:06:21 PM"),
            BookingModel(from: .chennai, to: .bangalore, time: "Friday, 01 July 2022 01:06:21 PM")
        ]),
        BusModel(name: "Z Travels", booking: [
            BookingModel(from: .delhi, to: .coimbatore, time: "Friday, 01 July 2022 01:06:21 PM", occupiedSeats: [10]),
            BookingModel(from: .coimbatore, to: .delhi, time: "Friday, 01 July 2022 01:06:21 PM", occupiedSeats: [5,7,2]),
            BookingModel(from: .kerala, to: .karnataka, time: "Friday, 01 July 2022 01:06:21 PM", occupiedSeats: [15]),
            BookingModel(from: .karnataka, to: .kerala, time: "Friday, 01 July 2022 01:06:21 PM", occupiedSeats: [1,2,4])
        ]),
    ]
}

struct UserList {
    static var userList: [UserModel] = [
        UserModel(name: "ganesh", password: "123456",
                  userHistory: [
                    UserBookings(from: .tirunelveli, to: .chennai, time: "Friday, 01 July 2022 01:06:21 PM", bus: "Z Travels", seats: [2]),
                    UserBookings(from: .tirunelveli, to: .chennai, time: "Friday, 01 July 2022 01:06:21 PM", bus: "Jupyter travels", seats: [1,2])
                  ]),
    ]
}

Booking().mainMenu()
