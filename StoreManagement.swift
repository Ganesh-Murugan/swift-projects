import Foundation

protocol staffProtocols {
    var staffName: String { get }
    var contact: Int { get }
    var Id: String { get }
    var password: String { get }
    
}
extension String {
    var toInt: Int {
        return Int(self) ?? 0
    }
}

class Store {
    var storeName: String
    var stocks: [Stock]
    var newStocks: [Stock]
    var staffs: [Staff]
    var customerDetails: [CustomerDetails]
    init(storeName: String, stocks: [Stock], newStocks: [Stock], staffs: [Staff], customerDetails: [CustomerDetails]) {
        self.storeName = storeName
        self.stocks = stocks
        self.newStocks = newStocks
        self.staffs = staffs
        self.customerDetails = customerDetails
    }

    func login(){
        var loggedIn: Bool = false
        print("""
         Staff login:
         """)
        while !loggedIn{
            print("""
          _________________
          
          Enter Id:
          """)
            let enteredId = readLine() ?? "0"
            if enteredId == ""{ break }
            print("""
          _________________
          
          Enter password:
          """)
            let enteredPassword = readLine() ?? "0"
            let filteredStaff = staffs.firstIndex(where: { $0.Id == enteredId && $0.password == enteredPassword })
            if let staffIndex = filteredStaff{
                staffs[staffIndex].loggedIn = true
                print("""
                   __________________________
                   LoggedIn as \(staffs[staffIndex].staffName)
                   __________________________
                   """)
                staffs[staffIndex].staffMenu(currentStaff: staffs[staffIndex], customerDetails: customerDetails)
                loggedIn = true
            } else {print("Invalid Id or password")}
        }
    }
    
    
    func purchase( billing: ([PurchaseDetails]) -> Void){
        var cart = [PurchaseDetails]()
        
        var purchaseComplete = false
        print("""
              Select Products to buy
              ______________________
              """)
        while !purchaseComplete {
            for (index ,stock) in stocks.enumerated(){
            print("""
                  
                  \(index + 1): Name: \(stock.stockName) | Price: \(stock.price) | Quantity: \(stock.stockQuantity)
                  """)
        }
            let userSelectedProduct = readLine() ?? ""
            if let productId = Int(userSelectedProduct) {
                if productId <= stocks.count && productId > 0{
                    let index = productId - 1
                    if stocks[index].stockQuantity == 0 {
                        print("Out of stock")
                        continue
                    }
                    print("Enter Number of quantity:")
                    let userEnteredQuantity = readLine() ?? ""
                    if let demandedQuantity = Int(userEnteredQuantity){
                    if demandedQuantity <= stocks[index].stockQuantity{
                        if demandedQuantity == 0 { continue }
                        stocks[index].stockQuantity -= demandedQuantity
                        stocks[index].setpurchaseQuantity = demandedQuantity
                        if let exists = cart.firstIndex(where: {$0.name == stocks[index].stockName} ) {
                            cart[exists] = PurchaseDetails(name: stocks[index].stockName, quantity: stocks[index].purchasedQuantity, price:stocks[index].price,  totalPrice: stocks[index].totalPrice)
                        } else{
                            cart.append(PurchaseDetails(name: stocks[index].stockName, quantity: stocks[index].purchasedQuantity, price:stocks[index].price, totalPrice: stocks[index].totalPrice))
                        }
                        
                        }
                     else {
                        print("only \(stocks[productId].stockQuantity) available")
                    }
                }
                } else {
                    print("enter correct id")
                }
            } else {
                if cart.isEmpty{
                    print("puchase cancelled")
                    return
                }
                print("Purchase comlete")
                purchaseComplete = true
                addCustomerDetails(cart: cart)
                billing(cart)
                
            }
        }
    }
    private func getCurrentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMMM yyyy HH:mm:ss a"
        return dateFormatter.string(from: date)
    }
    private func addCustomerDetails(cart: [PurchaseDetails]) {
        func payment() -> PaymentMethod{
            while true{
                print("select a payment method")
                print("""
                      1. card
                      2. cash
                      3. gpay
                      """)
                let selectedMethod = readLine() ?? ""
                switch selectedMethod{
                    case "1": return .card
                    case "2": return .cash
                    case "3": return .gpay
                    default: break 
                }
            }
        }
        while true {
            print("Enter Name:")
            if let name = readLine() {
                if name.count > 3{
                    print("Enter Contact:")
                    if let contact = readLine() {
                        if contact.count == 10 {
                            if let number = Int(contact) {
                            print("Enter address:")
                            if let address = readLine(){
                                customerDetails.append(CustomerDetails(name: name, contact: number, address: address, purchaseDetails: cart, date: getCurrentDate(), paymentMethod: payment()))
                                print("Details Added")
                                break
                        }
                    } else { print("Invalid Contact Number") }
                } else { print("Invalid Contact Number") }
                    
            }
            }else { print("enter proper name") }
        }
    }
}
   private func showAvailableStocks(){
        for (index ,stock) in newStocks.enumerated(){
            print("""
                  
                  \(index + 1): Name: \(stock.stockName) | Price: \(stock.price) | Quantity: \(stock.stockQuantity) | from: \(stock.place)
                  """)
        }
    }
    func buyStock(){
        while true{
            showAvailableStocks()
            print("______________________")
            print("Select a product:")
            let enteredIndex = readLine() ?? ""
            if let indexOfProduct = Int(enteredIndex) {
                let index = indexOfProduct - 1
                if index < newStocks.count, index >= 0 {
                let enteredQuantity = readLine() ?? ""
                if let requestedQuantity = Int(enteredQuantity){
                    if requestedQuantity <= newStocks[index].stockQuantity{
                        if requestedQuantity == 0 { continue }
                        newStocks[index].stockQuantity -= requestedQuantity
                        //newStocks[index].setNewStocksQuantity = requestedQuantity
                        if let exists = stocks.firstIndex(where: {$0.stockName == newStocks[index].stockName} ){
                            stocks[exists].stockQuantity += requestedQuantity
                        } else {
                            stocks.append(Stock(stockName: newStocks[index].stockName, price: newStocks[index].price, stockQuantity: requestedQuantity, place: newStocks[index].place))
                        }
                    } else {
                        print("\(newStocks[index].stockQuantity) available")
                    }
                }
                } else {print("invalid selection")}
            } else {
                print("stocks added")
                return
            }
        }
    } 
    func getStockList(){
        for (index ,stock) in stocks.enumerated(){
            print("""
                  
                  \(index + 1): Name: \(stock.stockName) | Price: \(stock.price) | Quantity: \(stock.stockQuantity) | from: \(stock.place)
                  """)
        }
    }
    func removeStock(){
        store.getStockList()
        print("""
              1. Remove Stock
              2. Reduce Quantity
              """)
        let userSelection = readLine() ?? ""
        print("Select a Product  ")
        let stockIndex = (readLine() ?? "").toInt
        if stockIndex <= 0 {return}
        switch(userSelection){
            case "1": if stockIndex <= stocks.count {
                        let removed = stocks.remove(at: stockIndex - 1)
                        print("\(removed.stockName) was removed")
                      } else {
                        print("Incorrect Value")
                }
            case "2": if stockIndex <= stocks.count {
                        print("Enter Quantity")
                        let enteredQuantity = (readLine() ?? "").toInt
                        if enteredQuantity > 0, enteredQuantity <= stocks[stockIndex - 1].stockQuantity {
                            stocks[stockIndex - 1].stockQuantity -= enteredQuantity
                        } else {
                            print("Incorrect quantity")
                        }
                } else {
                    print("Incorrect Value")
            }
            default: print("Incorrect value")
        }
    }
}
class Stock {
    let stockName: String
    let price: Int
    var stockQuantity: Int
    let place: String
    var purchasedQuantity = 0{
        willSet { print("cart item was: \(purchasedQuantity) ")}
        didSet { print("number of items in cart:  \(purchasedQuantity) ")}
        
    }
    
    //var newStocksQuantity = 0
    var setpurchaseQuantity: Int {
        get {return 0}
        set(value){
            purchasedQuantity += value
        }
    }
    var totalPrice: Int{
        get { return purchasedQuantity * price }
    }
    
    init(stockName: String, price: Int, stockQuantity: Int, place: String){
        self.stockName = stockName
        self.price = price
        self.stockQuantity = stockQuantity
        self.place = place
    }
}

class Staff : staffProtocols{
    let staffName: String
    let contact: Int
    let address: String
    let Id: String
    let password: String
    
    var loggedIn = false
    init(staffName: String, contact: Int, address: String, Id: String, password: String){
        self.staffName = staffName
        self.contact = contact
        self.address = address
        self.Id = Id
        self.password = password
    }
    
    func staffMenu(currentStaff : Staff, customerDetails: [CustomerDetails]){
        while currentStaff.loggedIn == true {
            print("""
        __________________________
            1. View stocks
            2. buy stocks
            3. Remove stocks
            4. Customer Details
            5. Logout
        __________________________
    """)
            let input = readLine() ?? "0"
            switch (input) {
                case "1" : store.getStockList()
                case "2" : store.buyStock()
                case "3" : store.removeStock()
                case "4" : currentStaff.getCustomerDetails(customerDetails: customerDetails)
                case "5" : currentStaff.logout(currentStaff: currentStaff)
                case "exit": return
                default : print("incorrect value")
            }
        }
    }
    
    private func getCustomerDetails(customerDetails: [CustomerDetails]){
        var sum: Int = 0
        for (index ,customer) in customerDetails.enumerated(){
            print("""
                  
                  \(index+1): Name: \(customer.name) | contact: \(customer.contact) | address: \(customer.address) | time: \(customer.date) | payment method: \(customer.paymentMethod)
                  """)
        }
        let enteredValue = readLine() ?? ""
        if let index = Int(enteredValue) {
            if index <= customerDetails.count && index > 0{
                for item in customerDetails[index-1].purchaseDetails{
                    sum += item.totalPrice
                    print("""
                          name: \(item.name)\t price: \(item.price) \t Quantity: \(item.quantity) total: \(item.totalPrice)
                          """)
                }
                print("""
                      ________________________________________________
                      Total amount:                             \(sum)
                      """)
            }
        }
    }
    private func logout(currentStaff: Staff){
        currentStaff.loggedIn = false
        print("""
          logged Out SuccessFully
          __________________________
          """)
    }
}

enum PaymentMethod{
    case cash, card, gpay
}

struct CustomerDetails {
    var name: String
    var contact: Int
    var address: String
    var purchaseDetails: [PurchaseDetails]
    var date: String
    var paymentMethod: PaymentMethod
 
}

struct PurchaseDetails {
    var name: String
    var quantity: Int
    var price: Int
    var totalPrice: Int

}

class MainMenu{
    
    func home(){
        while true {
        print("""
              1. Staff login
              2. Shop
              """)
        let userInput = readLine() ?? ""
        switch userInput{
            case "1": store.login()
            case "2": store.purchase()  { cart in
                        var sum: Int = 0
                        print("""
                              ______________BILL_______________
                                
                              """)
                    for item in cart {
                        sum += item.totalPrice
                        print("""
                              name: \(item.name)\t price: \(item.price) \t Quantity: \(item.quantity)  \(item.totalPrice)
                              """)
                        }
                        print("""
                              __________________________________
                              Bill Amount:                 \(sum)
                              __________________________________
                              """)
                        }
            case "" : return
            default : print("incorrect value")
        }
    }
}
    
}

let stocksList = [ Stock(stockName: "cheese", price: 20, stockQuantity: 2, place: "Chennai"),
                   Stock(stockName: "milk", price: 30, stockQuantity: 4, place: "Tirunelveli"),
                   Stock(stockName: "cookies", price: 25, stockQuantity: 0, place: "Coimbatore"),
                   Stock(stockName: "chocolate", price: 80, stockQuantity: 1,  place: "Tirunelveli"),
]
let newStocks = [  Stock(stockName: "note", price: 25, stockQuantity: 2, place: "Tenkasi"),
                   Stock(stockName: "lays", price: 30, stockQuantity: 4, place: "Chennai"),
                   Stock(stockName: "cookies", price: 25, stockQuantity: 1, place: "Coimbatore"),
                   Stock(stockName: "milk", price: 30, stockQuantity: 1, place: "Tirunelveli")]

let customerList = [CustomerDetails(name: "Nivin", contact: 9701234561, address: "4a, 5th street, perumalpuram", purchaseDetails: [PurchaseDetails(name: "pen", quantity: 2, price: 20, totalPrice: 40)], date: "Friday, 03 June 2022 09:00:12 AM", paymentMethod: .card)]

let staffList = [Staff(staffName: "ganesh", contact: 7558104648, address: "no.4, 1st street, sivapuram", Id: "a2z01", password: "123456")]

let store = Store(storeName: "AtoZ", stocks: stocksList,newStocks: newStocks, staffs: staffList, customerDetails: customerList)





MainMenu().home()
