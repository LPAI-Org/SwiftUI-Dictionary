import SwiftUI

struct UserModels: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    
    @Published var dataArray: [UserModels] = []
    @Published var filteredArray: [UserModels] = []
    @Published var mappedArray: [String] = []
    
    init(){
        getUsers()
        updateFilteredArray()
    }
    //MARK: Fake User Data
    func getUsers() {
        let user1 = UserModels(name: "Mark", points: 5, isVerified: true)
        let user2 = UserModels(name: "Tiffany", points: 50, isVerified: true)
        let user3 = UserModels(name: "Sarah", points: 25, isVerified: true)
        let user4 = UserModels(name: "Adrian", points: 55, isVerified: true)
        let user5 = UserModels(name: "Max", points: 95, isVerified: true)
        let user6 = UserModels(name: "Sandro", points: 25, isVerified: false)
        let user7 = UserModels(name: "Dennis", points: 15, isVerified: true)
        let user8 = UserModels(name: nil, points: 55, isVerified: true)
        let user9 = UserModels(name: nil, points: 25, isVerified: false)
        let user10 = UserModels(name: "Argo", points:555, isVerified: false)
        
        self.dataArray.append(contentsOf: [
        user1,
        user2,
        user3,
        user4,
        user5,
        user6,
        user7,
        user8,
        user9,
        user10
        ])
    }
    
    func updateFilteredArray() {
        //MARK: Sort:
        /*
        ///two was of sorting filteredArray below:
    
        ///first way:
//        filteredArray = dataArray.sorted { firstUser, secondUser in
//            return firstUser.points > secondUser.points
//        }
        
        ///second way:
//        filteredArray = dataArray.sorted(by: {$0.points < $1.points})
        */
        //MARK: Filter:
        /*
        //Two ways on writing this code below (short and long version
        ///shorter way:
        filteredArray = dataArray.filter({$0.isVerified})
        
        ///longer way:
//        filteredArray = dataArray.filter({ user in
//            return user.isVerified
//        })
        
         */
        
        //MARK: Map:
        /*
        //Two ways to approach the map function below
        ///first way:
//        mappedArray = dataArray.map({ user in
//            return user.name ?? "ERROR"
//        })
//
        ///second way:
        //mappedArray = dataArray.map({$0.name ?? "No User"})
        
        //third way:
//        mappedArray = dataArray.compactMap({ users in
//            users.name
//        })
        
        //fourth way:
//        mappedArray = dataArray.compactMap({$0.name})
        
        */
        
        //MARK: Stack Sorting:
        //sorting each version separately:
//        let sort = dataArray.sorted(by: {$0.points > $1.points})
//        let filter = dataArray.filter({$0.isVerified})
//        let map = dataArray.compactMap({$0.name})
        
        //Stacked Sorting example:
        mappedArray = dataArray
            .sorted(by: {$0.points > $1.points})
            .filter({$0.isVerified})
            .compactMap({$0.name})
    }
    
}

struct Sort_Filter_Map: View {
    
    @StateObject private var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ///Foreach below is used for MappedArray only
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name).font(.title)
                }
                
                ///Below is used for the Sort and Filtered Array
//                ForEach(vm.filteredArray) {
//                    user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//                        HStack{
//                            Text("Points: \(user.points)")
//                            Spacer()
//
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }.foregroundColor(.white)
//                        .padding()
//                        .background(Color.blue.cornerRadius(10))
//                        .padding(.horizontal)
//                }
            }
            
                
        }
    }
}

struct Sort_Filter_Map_Previews: PreviewProvider {
    static var previews: some View {
        Sort_Filter_Map()
    }
}
