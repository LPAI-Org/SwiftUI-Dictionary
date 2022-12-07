import Foundation
import CoreData

/*
 3 Entities
 -BusinessEntity
 -DepartmentEntity
 -EmployeeEntity
 */

class CoreDataManager {
    static let instance = CoreDataManager() // Singleton
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("There was an error with CoreData: \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("Saved Successfully")
        }
        catch let error {
            print("Error saving Core-Data: \(error.localizedDescription)")
        }
    }
}


class CoreDataRelationship_ViewModel: ObservableObject {
    let manager = CoreDataManager()
    @Published var businesses: [BusinessEntity] = []
    @Published var department: [DepartmentEntity] = []
    @Published var employee: [EmployeeEntity] = []
    
    
    init() {
        fetchBusinesses()
        fetchDepartments()
        fetchEmployees()
    }
    
    func fetchEmployees(forBusiness business: BusinessEntity) {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        //Sorting
//        let sort = NSSortDescriptor(keyPath: \EmployeeEntity.name, ascending: true)
//        request.sortDescriptors = [sort]
        
        //Filter
        let filter = NSPredicate(format: "business == %@", business)
        request.predicate = filter
        
        do {
            employee =  try manager.context.fetch(request)
        }
        catch let error {
            print("Error fetching employee core data: \(error.localizedDescription)")
        }
    }

    
    func fetchEmployees() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        let sort = NSSortDescriptor(keyPath: \EmployeeEntity.name, ascending: true)
        
        request.sortDescriptors = [sort]
        
        do {
            employee =  try manager.context.fetch(request)
        }
        catch let error {
            print("Error fetching employee core data: \(error.localizedDescription)")
        }
    }
    
    func fetchDepartments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        
        //Sorting
        let sort = NSSortDescriptor(keyPath: \DepartmentEntity.name, ascending: true)
        request.sortDescriptors = [sort]
        
        do {
            department =  try manager.context.fetch(request)
        }
        catch let error {
            print("Error fetching department core data: \(error.localizedDescription)")
        }
    }
    
    func fetchBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        //MARK: Filter, Sort
        ///Sorting
        let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)
        request.sortDescriptors = [sort]
        ///Filtering
//        let filter = NSPredicate(format: "name == %@", "Microsoft")
//        request.predicate = filter
        ///the end
        
        do {
            businesses =  try manager.context.fetch(request)
        }
        catch let error {
            print("Error fetching business core data: \(error.localizedDescription)")
        }
    }
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        
        newEmployee.age = 25
        newEmployee.dateJoined = Date()
        newEmployee.name = "Tiffany"
//        newEmployee.business = businesses[0]
//        newEmployee.department = department[0]
        save()
    }
    
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
       newDepartment.name = "Marketing"
    //    newDepartment.businesses = [businesses[0]]
   //     newDepartment.employees = [employee[0]]
      //  newDepartment.addToEmployees(employee[0])
        save()
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Twitter"
        
//        //add existing dept. to the new business
//        newBusiness.departments = [department[0], department[1]]
       // newBusiness.departments = [department[0]]

        //add existing employees
      //  newBusiness.employees = [employee[0]]
//        add mew business to existing dept.
//        newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
//        add mew business to existing employees
     //   newBusiness.addToEmployees(employee[0])
        
        save()
    }
    
    func deleteDepartment() {
        let department = department[0]
        manager.context.delete(department)
        save()
    }
    
    func save() {
        businesses.removeAll()
        department.removeAll()
        employee.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.manager.save()
            self.fetchBusinesses()
            self.fetchDepartments()
            self.fetchEmployees()
        })

        
    }
    
}
