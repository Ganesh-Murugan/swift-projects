import Foundation

protocol Object {
    var slotNo: Int {get}
    var vehicle: Vehicle{get}
}

enum VehicleType {
    case bike, car
}
enum ParkingErrors: Error {
        case empty, full(VehicleType), invalidSlot(Int), exist(String), notFound
}

extension String {
    var toInt: Int {
        return Int(self) ?? 0
    }
}

extension Optional where Wrapped == String {
    var unwrap: String {
        guard let self = self else { return "" }
        return self
    }
}

extension Array where Element: Object {
    var checkIsEmpty: Bool { getVehicles().isEmpty }

    func getVehicles(type: VehicleType? = nil, numberPlate: String? = nil, isParked: Bool = true) -> [Element]{
        return type != nil ? self.filter { $0.vehicle.type == type && $0.vehicle.parked == isParked } : 
        ( numberPlate != nil ? self.filter { $0.vehicle.numberPlate == numberPlate && $0.vehicle.parked == isParked } : 
         self.filter { $0.vehicle.parked == isParked } )
    }

    func getVehicleIndex(_ type: VehicleType, _ slotNo: Int) -> Int {
        self.firstIndex(where: {  $0.vehicle.type == type && $0.slotNo == slotNo && $0.vehicle.parked}) ?? -1
    }
    
    func search<T: StringProtocol>(_ searchKeyword: T) -> [Element] {
        return self.filter {
            $0.vehicle.parked && ($0.vehicle.name.localizedCaseInsensitiveContains(searchKeyword) ||
            String($0.slotNo).localizedCaseInsensitiveContains(searchKeyword) ||
            $0.vehicle.numberPlate.localizedCaseInsensitiveContains(searchKeyword))
        }
    }

    var printSlots: Void {
        for slot in self {
            print("Vehicle \(slot.vehicle.name), Number \(slot.vehicle.numberPlate) is parked at \(slot.vehicle.type) parking slot number \(slot.slotNo), Parked Time: \(slot.vehicle.arrivalTime), Depature Time: \(slot.vehicle.depatureTime)")
        }       
    }
    mutating func clearHistory() {
        self.removeAll(where: {!$0.vehicle.parked})
    }
}

// let parkedVehicleList = [ ParkingSlot(slotNo: 1, vehicle: Vehicle(name: "lambo", numberPlate: "TN-72 2563", type: .car, parked: true),
//                             arrivalTime: "Monday, 05 June 2022 07:10:21 AM", depatureTime: ""),
//                      ParkingSlot(slotNo: 4, vehicle: Vehicle(name: "pulsur", numberPlate: "TN-72 3653", type: .bike, parked: true),
//                             arrivalTime: "Sunday, 04 June 2022 04:06:21 AM", depatureTime: ""),
//                      ParkingSlot(slotNo: 3, vehicle: Vehicle(name: "yamaha", numberPlate: "TN-72 5672", type: .bike, parked: true),
//                             arrivalTime: "Monday, 05 June 2022 01:04:21 AM", depatureTime: ""),
//                      ParkingSlot(slotNo: 2, vehicle: Vehicle(name: "tesla", numberPlate: "KL-23 6783", type: .car, parked: false),
//                             arrivalTime: "Sunday, 04 June 2022 06:03:21 AM", depatureTime: "Monday, 05 June 2022 06:03:21 AM")]

struct Vehicle {
    var name: String
    var numberPlate: String
    var type: VehicleType
    var arrivalTime: String = ""
    var depatureTime: String = ""
    var parked: Bool = false {
        willSet { if newValue { self.arrivalTime = setDate() } else { self.depatureTime = setDate() }}
    }
}

struct ParkingSlot: Object {
    var slotNo: Int
    var vehicle: Vehicle
}
extension Vehicle {
    mutating func setDate() -> String {
        let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "EEEE, dd MMMM yyyy HH:mm:ss a"
        return dateFormatter.string(from: Date())
    }
}
// extension Optional {
//     func unWrap(defaultValue: Wrapped) -> Wrapped {
//         guard let self = self else {
//             return defaultValue
//         }
//         return self
//     }
// }
// var value: String? = "nil"
// print(value.unWrap(defaultValue: "heloo"))

class ParkingArea {
    let name: String = "Zoho Parking"
    var parkingSlots = [ParkingSlot]()
    var maxBikeSlot: Int = 0
    var maxCarSlot: Int = 0
    var totalSlots: Int {maxBikeSlot + maxCarSlot}
    var availableBikeSlot: Int { maxBikeSlot - parkingSlots.getVehicles(type: .bike).count }
    var availableCarSlot: Int { maxCarSlot - parkingSlots.getVehicles(type: .car).count }
    var availableTotalSlot: Int { availableBikeSlot + availableCarSlot }
    func allocateMaxSlot() {
        print("Enter Total Car and Bike slots")
        let enteredCarSlot = readLine().unwrap.toInt
        enteredCarSlot > 0 ? maxCarSlot = enteredCarSlot : print("0 cannot be maxslot")
        let enteredBikeSlot = readLine().unwrap.toInt
        enteredBikeSlot > 0 ? maxBikeSlot = enteredBikeSlot : print("0 cannot be maxslot")
    }
    func park() -> ParkingErrors? {
        let vehicleType = getVehicleType()
        guard vehicleType == .car ? availableCarSlot > 0 : availableBikeSlot > 0 else {
            return ParkingErrors.full(vehicleType)
        }
        
        print("Enter \(vehicleType) number, Name and Slot Number")
        let vehicleNumber = readLine().unwrap
        let name = readLine().unwrap
        
        guard isExist(vehicleNumber) else {
            return ParkingErrors.exist(vehicleNumber)
        }
        
        let slotNumber = readLine().unwrap.toInt
        guard slotValid(vehicleType, slotNumber), !slotAllocation(vehicleType, slotNumber) else {
            return ParkingErrors.invalidSlot(slotNumber)
        }
        
        var parkedSlot = ParkingSlot(slotNo: slotNumber, vehicle: Vehicle(name: name, numberPlate: vehicleNumber, type: vehicleType))
        parkedSlot.vehicle.parked = true
        parkingSlots.append(parkedSlot)
        return nil
    }

    func dispatchVehicle() -> ParkingErrors? {
        let type = getVehicleType()
        print("Enter Slot number")
        let slotNo = readLine().unwrap.toInt
        let vehicleIndex = parkingSlots.getVehicleIndex(type, slotNo)
        guard vehicleIndex >= 0 else {
            return ParkingErrors.notFound
        }
        parkingSlots[vehicleIndex].vehicle.parked = false
        print("vehicle depatured")
        return nil
    }
    
    func isSlotOccupied() -> Bool {
        let vehicleType = getVehicleType()
        let slotNumber = readLine().unwrap.toInt
        return availableTotalSlot > 0 ? (slotValid(vehicleType, slotNumber) ? slotAllocation(vehicleType, slotNumber) : true) : true
    }
    
    func searchForVehicle() -> [ParkingSlot] {
        let searchKeyWord = readLine().unwrap
        return parkingSlots.search(searchKeyWord)
    }
    
    func checkTotalSlots(){
        print("Bike slots: \(maxBikeSlot), Available: \(availableBikeSlot)")
        print("Car slots: \(maxCarSlot), Available: \(availableCarSlot)")
        print("Total slots: \(totalSlots), Available: \(availableTotalSlot)")
    }

    func viewVehicles(_ parked: Bool){
        print("""
              1. View all
              2. Bikes
              3. Car
              """)
        let userInput = readLine().unwrap
        switch(userInput) {
            case "1": parkingSlots.getVehicles(isParked: parked).printSlots
            case "2": parkingSlots.getVehicles(type: .bike, isParked: parked).printSlots
            case "3": parkingSlots.getVehicles(type: .car, isParked: parked).printSlots
            default: print("Enter correct value")
            }
        }
    
    func clearParkingHistory() {
        parkingSlots.clearHistory()
    }
}

extension ParkingArea {
    private func slotValid(_ vehicleType: VehicleType, _ slotNumber: Int) -> Bool {
        vehicleType == .car ? (slotNumber <= maxCarSlot && slotNumber > 0) : (slotNumber <= maxBikeSlot && slotNumber > 0)
    }
    
    private func slotAllocation(_ vehicleType: VehicleType, _ slotNumber: Int) -> Bool {
        parkingSlots.getVehicleIndex(vehicleType, slotNumber) != -1
    }
    
    private func isExist(_ numberPlate: String) -> Bool {
        parkingSlots.getVehicles(numberPlate: numberPlate).count == 0
    }
    
    private func getVehicleType() -> VehicleType{ 
        print("Enter Vehicle Type -> 1: Car 2: Bike")
        while true {
            let userSelection = readLine().unwrap
            switch(userSelection) {
                case "1": return .car
                case "2": return .bike
                default : print("Select a valid type")
            }
        }
    }
    
}

let parkingPlace = ParkingArea()
func someFunction<T: ParkingArea>(_ value: T) {
    print(value.name)
}
someFunction(parkingPlace)
func main() {
    while true {
        if parkingPlace.maxBikeSlot == 0 && parkingPlace.maxCarSlot == 0 { parkingPlace.allocateMaxSlot() }
        print("""
              
              1. Set Max Slots
              2. Park vehicle
              3. Remove vehicle
              4. Is Slot Free
              5. Search for vehicle
              6. check total slots
              7. View currently parked vehicle details
              8. View previously parked vehicle details
              9. Clear parking history
              
              """)
        let userSelection = readLine().unwrap
        switch(userSelection) {
            case "1": parkingPlace.allocateMaxSlot()
             case "2": let result = parkingPlace.park()
                        if result != nil { handle(error: result!) }
            case "3": let result = parkingPlace.dispatchVehicle()
                        if result != nil { handle(error: result!) }
            case "4": let isAvailable = parkingPlace.isSlotOccupied()
                        isAvailable ? print("slot taken or invalid") : print("slot is free") 
            case "5": parkingPlace.searchForVehicle().printSlots
            case "6": parkingPlace.checkTotalSlots()
            case "7": parkingPlace.viewVehicles(true)
            case "8": parkingPlace.viewVehicles(false)
            case "9": parkingPlace.clearParkingHistory()
            default : print("Enter a correct value")
        }
    }
}
main()

func handle(error: ParkingErrors){              
    switch error {
        case .full(let type) : print("\(type) slot full")
        case .empty: print("No Available Slots")
        case .exist(let number): print("\(number) already parked")
        case .invalidSlot(let slot): print("Slot Number \(slot) is Invalid or taken")
        case .notFound: print("Vehicle Not Found")
    }
}

