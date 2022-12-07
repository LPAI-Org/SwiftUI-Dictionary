import SwiftUI

struct CoreRelationship: View {
    @StateObject var vm = CoreDataRelationship_ViewModel()
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    Button(action: {
//                        vm.fetchEmployees(forBusiness: vm.businesses[3])
                        vm.deleteDepartment()
                    }, label: {
                        Text("Perform Action")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .cornerRadius(10)
                        
                    })
                    
                    Section("Departments") {
                        ScrollView(.horizontal, showsIndicators: true) {
                            HStack(alignment: .top) {
                                ForEach(vm.department) {
                                    department in
                                    DepartmentView(entity: department)
                                }
                            }
                        }
                    }
                    
                    Section("Businesses") {
                        ScrollView(.horizontal, showsIndicators: true) {
                            HStack(alignment: .top) {
                                ForEach(vm.businesses) {
                                    business in
                                    BusinessView(entity: business)
                                }
                            }
                        }
                    }
                    
                    Section("Employees") {
                        ScrollView(.horizontal, showsIndicators: true) {
                            HStack(alignment: .top) {
                                ForEach(vm.employee) {
                                    employee in
                                    EmployeeView(entity: employee)
                                }
                            }
                        }
                    }
                    
                }.navigationTitle("Relationships")
                    .padding()
            }
        }
    }
}

struct BusinessView: View {
    
    let entity: BusinessEntity
    var body: some View {
        VStack(alignment: .leading ,spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            if let department = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments:").bold()
                ForEach(department) { department in
                    Text(department.name ?? "")
                }
            }
                
                if let employee = entity.employees?.allObjects as? [EmployeeEntity] {
                    Text("Employees: ").bold()
                    
                    ForEach(employee) {
                        employee in
                        Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct DepartmentView: View {
    
    let entity: DepartmentEntity
    var body: some View {
        VStack(alignment: .leading ,spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesses:").bold()
                ForEach(businesses) { businesses in
                    Text(businesses.name ?? "")
                }
            }
                
                if let employee = entity.employees?.allObjects as? [EmployeeEntity] {
                    Text("Employees: ").bold()
                    
                    ForEach(employee) {
                        employee in
                        Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.green.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct EmployeeView: View {
    
    let entity: EmployeeEntity
    var body: some View {
        VStack(alignment: .leading ,spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            Text("Business: ").bold()
            Text(entity.business?.name ?? "")
            
            Text("Department: ").bold()
            Text(entity.department?.name ?? "")
            
            Text("Age: \(entity.age)")
            Text("Date Joined: \(entity.dateJoined ?? Date(), format: .dateTime)")
            
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.blue.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}



struct CoreRelationship_Previews: PreviewProvider {
    static var previews: some View {
        CoreRelationship()
    }
}
