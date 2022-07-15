import Foundation

protocol Login {
    var Id: String { get }
    var password: String { get }
    
}

class College {
    var collegeName: String
    var classRooms: [Classroom]
    var staffAdmins: [StaffAdmin]
    var staffs:[Staff]
    var students: [Students]
    init(collegeName: String, classRooms: [Classroom], staffs: [Staff], students:[Students], staffAdmins: [StaffAdmin]){
        self.collegeName = collegeName
        self.classRooms = classRooms
        self.staffs = staffs
        self.students = students
        self.staffAdmins = staffAdmins
    }
    //staff login
    func staffLogin() {
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
            if enteredId == ""{ return }
            let filteredStaff = staffs.filter { $0.Id == enteredId && $0.password == enteredPassword }
            if filteredStaff.isEmpty{
                print("Incorrect Id or password")
            } else {
                filteredStaff[0].loggedIn = true
                print("""
                  __________________________
                  LoggedIn as \(filteredStaff[0].staffName)
                  __________________________
                  """)
                loggedIn = true
                let staffClasses = filteredStaff[0].department
                
                let filteredClassRoom = classRooms.filter { staffClasses.contains($0.department) }
                if staffClasses.count == 1{
                    filteredStaff[0].menu(filteredStaff[0], filteredClassRoom[0])
                } else{
                    let selectedClass = selectClass(currentUser: filteredStaff[0], classRoom: filteredClassRoom)
                    filteredStaff[0].menu(filteredStaff[0], selectedClass)
                }
            }
        }
    }
    func selectClass(currentUser: Staff, classRoom: [Classroom]) -> Classroom{
        var selected = false
        print("""
          Select Class
          __________________________

          """)
        for (index, classes) in classRoom.enumerated(){
            print("""
          \(index): \(classes.department)
          """)
        }
        while !selected {
            let enteredValue = readLine() ?? "0"
            if let selectedClass = Int(enteredValue) {
                if abs(selectedClass) <= classRoom.count - 1{
                    selected = true
                    return classRoom[abs(selectedClass)]
                } else {
                    print("class not found")
                    continue
                }
            }
            print("class not found")
            continue
        }
        
    }
    func logout(currentUser: Staff) {
        currentUser.loggedIn = false
        print("""
          logged Out SuccessFully
          __________________________
          """)
        college.staffLogin()
    }
    
    func staffAdminLogin() {
        var loggedIn: Bool = false
        print("""
         Admin login:
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
            let filteredAdmin = staffAdmins.filter { $0.Id == enteredId && $0.password == enteredPassword }
            if filteredAdmin.isEmpty{
                print("Incorrect Id or password")
            } else {
                filteredAdmin[0].loggedIn = true
                print("""
                  __________________________
                  LoggedIn as \(filteredAdmin[0].name)
                  __________________________
                  """)
                loggedIn = true
                filteredAdmin[0].adminMenu(currentUser: filteredAdmin[0], college: college)
            }
        }
    }
    func getStudentsList(){
        for student in students{
            print("""
              
              \(student.name)\t \(student.rollNo)\t \(student.contact)\t \(student.department)
              _______________________________________
             """)
        }
    }
    func getStaffList() -> [Staff] {
        return staffs
    }
    
    func whoAmI() -> StaffAdmin{
        return staffAdmins.filter { $0.loggedIn == true }[0]
        
    }
}

class StaffAdmin: Login {
    //for admin login to manage staffs and other stuffs at clg level
    var name: String
    var Id: String
    var password: String
    var loggedIn = false
    var staffs: [Staff]
    init(name: String, Id: String, password: String, staffs: [Staff]){
        self.name = name
        self.Id = Id
        self.password = password
        self.staffs = staffs
    }
    func adminMenu(currentUser: StaffAdmin, college: College) {
        while currentUser.loggedIn == true {
            print("""
        __________________________
            1. View Staffs
            2. Add Staff
            3. Remove staff
            4. Search for staff
        __________________________
    """)
            let input = readLine() ?? "0"
            switch (input) {
            case "1" : currentUser.getStaffList()
                
            case "2" :
                currentUser.addStaff() { staffId, staffs in
                    let filtered = staffs.filter({ $0.Id == staffId })
                    return !filtered.isEmpty
                } passwordVerify: { password in
                    return password == "" || password.count < 6
                }
            case "3" :
                print(currentUser.removeStaff())
            case "4" :
                let result = currentUser.searchForStaff()
                result.forEach{ staff in
                    print("\(staff.staffName), \(staff.Id), \(staff.contact)")
                }
            case "exit":
                return
            default :
                print("incorrect value")
            }
            
        }
        
    }
    
    func addStaff(isExist: (String, [Staff]) -> Bool, passwordVerify: (String) -> Bool) {
        
        func addDepartments() -> [Courses]{
            var depList = [Courses]()
            print("Enter Department")
            for _ in 1...3 {
                let department = readLine() ?? ""
                switch department {
                case "BCA": depList.append(.BCA)
                case "Cs": depList.append(.Cs)
                case "Maths": depList.append(.Maths)
                default: return depList
                }
                
                
            }
            return depList
        }
        
        print("Enter Name:")
        if let name = readLine() {
            if name == ""{ return }
            print("Enter Staff Id: ")
            if let staffId = readLine() {
                if staffId == "" || staffId.count != 5  {
                    print("Invalid Id ")
                    return
                }
                if isExist(staffId, staffs){
                    print("Staff with Id \(staffId) already exists")
                    return
                }
                print("Enter password: ")
                if let password = readLine() {
                    if !passwordVerify(password){
                        print("Enter contact number:")
                        if let contact = readLine() {
                            if contact == "" || contact.count != 10 {
                                print("Invalid Contact Number")
                                return
                            }
                            if let number = Int(contact){
                                staffs.append(Staff(staffName: name, Id: staffId, password: password, contact: number, department: addDepartments()))
                                print("""
                         Staff added successfully
                         _________________________
                         """)
                            } else {
                                print("Invalid Contact Number")
                            }
                        }
                    }
                }
                
            }
        }
    }
    func removeStaff() -> String{
        let enteredValue = readLine() ?? "0"
        let filtered = staffs.filter({ $0.Id != enteredValue })
        if staffs.count > filtered.count {
            staffs = filtered
            return "Staff Removed"
        }
        return "Incorrect Id"
    }
    func searchForStaff() -> [Staff] {
        let input = readLine() ?? "0"
        let filteredStaffs = staffs.filter { $0.staffName.contains(input) || $0.Id.contains(input) }
        if filteredStaffs.isEmpty{
            print("not found")
        }
        return filteredStaffs
    }
    func getStaffList() {
        for staff in staffs{
            print("\(staff.staffName), \(staff.Id), \(staff.contact), \(staff.department[0]),")
        }
    }
}

class Classroom {
    var department: Courses
    var students:[Students]
    var staffs:[Staff]
    init(department: Courses, students: [Students], staffs: [Staff]){
        self.department = department
        self.students = students
        self.staffs = staffs
    }
    
    var presentList = [String]()
    
    
    func getPresentList() -> [String] {
        var resultPresentList = [String]()
        print("Present List: ")
        if presentList.isEmpty{
            return []
        }
        for presentStudent in presentList{
            for student in students where student.rollNo == presentStudent{
                resultPresentList.append("\(student.name), \(student.rollNo), \(student.contact)")
            }
        }
        return resultPresentList
    }
    
    func getAbsentList() -> [String]{
        var resultAbsentList = [String]()
        print("Absent list: ")
        if presentList.isEmpty{
            for student in students {
                resultAbsentList.append("\(student.name), \(student.rollNo), \(student.contact)")
            }
        } else {
            for student in students{
                if presentList.contains(student.rollNo){
                    continue
                }
                else {
                    resultAbsentList.append("\(student.name), \(student.rollNo), \(student.contact)")
                }
            }
        }
        return resultAbsentList
        
    }
    
    func isPresent() -> String{
        print("Enter Roll number:")
        let enteredValue = readLine() ?? "0"
        for student in students where student.rollNo == enteredValue {
            if presentList.contains(student.rollNo){
                return "present"
            } else{
                return "Absent"
            }
        }
        return "Enter Correct Roll number"
    }
    
    func addStudent(isExist : (String, [Students]) -> Bool ) {
        
        func addDepartment() -> Courses{
            print("courses available: ")
            for course in  Courses.allCases{
                print("\t\(course)")
            }
            var selectedDepartment: Courses
            print("Enter Department")
            let enteredDepartment = readLine() ?? ""
            switch enteredDepartment {
            case "BCA": selectedDepartment = .BCA
            case "Cs": selectedDepartment = .Cs
            case "Maths": selectedDepartment = .Maths
            default: return .BCA
            }
            return selectedDepartment
        }
        
        print("Enter Name:")
        if let name = readLine() {
            if name == ""{ return }
            print("Enter Roll Number:")
            if let rollNo = readLine() {
                if rollNo == "" || rollNo.count != 7 {
                    print("Invalid Roll Number")
                    return
                }
                if isExist(rollNo, students){
                    print("student already exists")
                    return
                }
                print("Enter contact number:")
                if let contact = readLine() {
                    if contact == "" || contact.count != 10 {
                        print("Invalid Contact Number")
                        return
                    }
                    if let number = Int(contact){
                        
                        students.append(Students(name: name, rollNo: rollNo, contact: number, department: addDepartment()))
                        print("""
                          Student added successfully
                        """)
                        
                    } else {
                        print("Invalid Contact Number")
                    }
                }
            }
        }
    }
    
    func takeAttendance() {
        var loopLength = students.count
        print("Enter Roll number: ")
        while loopLength != 0{
            let list = readLine() ?? "0"
            if list == ""{ break }
            let filtered = students.filter({ $0.rollNo == list })
            if filtered.isEmpty{
                print("Roll number entered is incorrect")
                continue
            }
            if !presentList.contains(list) {
                presentList.append(list)
                loopLength -= 1
            } else{
                print("Attendance already given")
            }
        }
    }
    func getStudentsList(){
        for student in students{
            print("""
              
              \(student.name)\t \(student.rollNo)\t \(student.contact)
              ___________________________________
             """)
        }
    }
    func removeStudent() -> String{
        let enteredValue = readLine() ?? "0"
        let filtered = students.filter({ $0.rollNo != enteredValue })
        if students.count > filtered.count{
            students = filtered
            return "Student Removed"
        }
        return "Incorrect Roll Number"
    }
    
    
    
    func getStaffList() -> [Staff]{
        return staffs
    }
    
    func whoAmI() -> Staff{
        return staffs.filter { $0.loggedIn == true }[0]
        
    }
}
extension Classroom {
    func searchForStudent() -> [Students] {
        let input = readLine() ?? "0"
        let filteredStudents = students.filter { $0.name.contains(input) || $0.rollNo.contains(input) }
        if filteredStudents.isEmpty{
            print("not found")
        }
        return filteredStudents
    }
}

class Staff: Login {
    var staffName: String
    var Id: String
    var password: String
    var contact: Int
    var department: [Courses]
    var loggedIn: Bool = false
    init(staffName: String, Id: String, password: String, contact: Int, department: [Courses]) {
        self.staffName = staffName
        self.Id = Id
        self.password = password
        self.contact = contact
        self.department = department
    }
    let menu: (Staff, Classroom) -> Void = { currentUser, classRoom in
        print("Entered \(classRoom.department)")
        while currentUser.loggedIn == true {
            let MenuList = """
    __________________________
      Class \(classRoom.department)
        1. Take Attendance
        2. Get Present List
        3. Get Absent List
        4. Check is student present
        5. Add Student
        6. View Students List
        7. Remove Student
        8. Search for Student
        9. Staffs
        0. Logout
        #. whoAmI
    __________________________
    """
            print(MenuList)
            let input = readLine() ?? "0"
            switch (input) {
            case "1" :
                classRoom.takeAttendance()
            case "2" :
                let classBcaPresentList = classRoom.getPresentList()
                classBcaPresentList.forEach{ student in
                    print(student)
                }
            case "3" :
                let classBcaAbsentList = classRoom.getAbsentList()
                classBcaAbsentList.forEach{ student in
                    print(student)
                }
            case "4" :
                print(classRoom.isPresent())
            case "5" :
                classRoom.addStudent() { rollNo, students in
                    let filtered = students.filter({ $0.rollNo == rollNo })
                    if filtered.isEmpty{ return false }
                    return true
                }
            case "6" :
                classRoom.getStudentsList()
            case "7" :
                print(classRoom.removeStudent())
            case "8" :
                let result = classRoom.searchForStudent()
                result.forEach{ student in
                    print("\(student.name), \(student.rollNo), \(student.contact)")
                }
            case "9" :
                let result = classRoom.getStaffList()
                result.forEach{ staff in
                    print("\(staff.staffName), \(staff.Id), \(staff.contact)")
                }
            case "#" :
                let result = classRoom.whoAmI()
                print("\(result.staffName), \(result.Id), \(result.contact)")
                
            case "0":
                college.logout(currentUser: classRoom.whoAmI())
            case "exit":
                return
            default :
                print("incorrect value")
            }
        }
    }
}

class Students {
    var name: String
    var rollNo: String
    var contact: Int
    var department: Courses
    init(name: String, rollNo: String, contact: Int, department: Courses){
        self.name = name
        self.rollNo = rollNo
        self.contact = contact
        self.department = department
    }
}
enum Courses: Int, CaseIterable{
    case BCA = 0, Cs = 1, Maths = 2
}


var studentList = [
    Students(name: "ganesh", rollNo: "19sca01", contact: 1234056231, department: Courses.BCA),
    Students(name: "hari", rollNo: "19sca02", contact: 2023315146, department: Courses.BCA),
    Students(name: "gokul", rollNo: "19sca03", contact: 4123623051, department: Courses.BCA),
    Students(name: "hariharan", rollNo: "19sca04", contact: 4562123031, department: Courses.BCA),
    Students(name: "vikash", rollNo: "19acs01", contact: 1234056231, department: Courses.Cs),
    Students(name: "adbullah", rollNo: "19acs02", contact: 2023315146, department: Courses.Cs),
    Students(name: "santhosh", rollNo: "19acs03", contact: 4123623051, department: Courses.Cs),
    Students(name: "durai", rollNo: "19acs04", contact: 4562123031, department: Courses.Cs),
]

let staffList = [
    Staff(staffName: "Jeyanth", Id: "sac01", password: "123456", contact: 7558102423, department: [.BCA,.Cs]),
    Staff(staffName: "Aasiq", Id: "sac02", password: "000000", contact: 8124555941, department: [.BCA])
]

let classes = [Classroom(department: .BCA, students: studentList.filter{ $0.department == .BCA }, staffs: staffList),
               Classroom(department: .Cs, students: studentList.filter{ $0.department == .Cs }, staffs: staffList)]

let staffAdmin = [StaffAdmin(name: "Nithish", Id: "sta01", password: "123456", staffs: staffList),
                  StaffAdmin(name: "Nithish", Id: "sta02", password: "123123", staffs: staffList)]

let college = College(collegeName: "Sadakathullah", classRooms: classes, staffs: staffList, students: studentList, staffAdmins: staffAdmin)

college.staffLogin()

func main() {
            print("""
                    1: staff login
                    2: staff admin login
                  """)
            while true {
                let userSelection = readLine() ?? ""
                switch(userSelection) {
                    case "1": college.staffLogin()
                    case "2": college.staffAdminLogin()
                    default : print("Enter correct value")
                }
            }
                    
        }

//main()
