import SwiftUI
import Combine


//PROBLEMS WITH SINGLETONS
// 1. Singletons are global (accessible from anywhere, can cause issues if the app is accessing it from several places causing threading issues)
//2. Can't customize the init!
//3. Can't swap out dependencies/services (in our case we would only be able to use ProductionDataService class)
 
//MARK: MAIN VIEW
struct Dependency_Injection: View {
    
    @StateObject private var vm: DependencyInjectionModel
    
    init(dataService: DataServiceProtocol){
        _vm = StateObject(wrappedValue: DependencyInjectionModel(dataService: dataService))
    }
    
    var body: some View {
        ZStack {
            Color.purple.ignoresSafeArea(.all)
        ScrollView {

                LazyVStack(spacing: 30) {
                    ForEach(vm.dataArray) {post in
                        Text(post.title)
                            .padding()
                            .font(.largeTitle)
                            .background(.thinMaterial)
                            .cornerRadius(10)
                        Text(post.body)
                            .padding()
                            .background(.ultraThinMaterial)
                    }
                }.padding()
            }

        }
    }
}

struct Dependency_Injection_Previews: PreviewProvider {
    
    //never explicitly unwrap with an !, but rather use a guard let statement that catches an response and error but for this demo, we dont care.
    
    //MARK: Production Data
     static let dataService = ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
    //MARK: Fake Data
       // static let dataService = MockDataServices(data: [PostModel(userId: 5, id: 5, title: "Hellloooo!", body: "test")])
    
    static var previews: some View {
        Dependency_Injection(dataService: dataService)
    }
}
