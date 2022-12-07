
//MARK: Model
struct FruitModel: Identifiable {
    var id: String = UUID().uuidString
    let name: String
    let count: Int
}

//MARK: ObservableObject Model - Data
class FruitViewModel: ObservableObject {
    ///ObservableObject tells us that this code can be observed as it will update with time or new data gets passed into it.
    @Published var fruitArray: [FruitModel] = []
    
    @Published var isLoading: Bool = false
    
    init() {
        getFruits()
    }
    func getFruits() {
        
        let fruit1 = FruitModel(name: "Orange", count: 1)
        let fruit2 = FruitModel(name: "Banana", count: 2)
        let fruit3 = FruitModel(name: "Watermelon", count: 88)
        
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [self] in
            fruitArray.append(fruit1)
            fruitArray.append(fruit2)
            fruitArray.append(fruit3)
            isLoading = false
        })

    }
    
    func delete(index: IndexSet) {
        fruitArray.remove(atOffsets: index)
    }
}

import SwiftUI


   /*
    The ObservedObject tells Xcode that this property will be updating with ObservedObject if the View updates, so will the data inside fruitViewModel
   
    @ObservedObject var fruitViewModel: FruitViewModel = FruitViewModel()
    
    
    Using the StateObject, it will force the model to remain static even if the View refreshes, If you want the data to update, use ObservedObject. Otherwise, if the data is not going to update/release with the View updating, than use StateObject.
    
    Memo: Use StateObject if its the first view that will get this model, but if its subviews, use ObservedObject
    
    */
   

struct StateObject_ObservableObject: View {

/*
    1) @StateObject -> USE THIS ON CREATION / INIT
    2) @ObservedObject -> USE THIS FOR SUBVIEWS
*/
    //MARK: StateObject
    @StateObject var fruitViewModel: FruitViewModel = FruitViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                
                if fruitViewModel.isLoading {
                    ProgressView()
                } else {
                    
                    ForEach(fruitViewModel.fruitArray) { fruits in
                        HStack {
                            Text(fruits.name).font(.headline.bold())
                            Spacer()
                            Text("\(fruits.count)").font(.headline).foregroundColor(.red)
                        }
                    }.onDelete(perform: fruitViewModel.delete)
                }
            }.listStyle(GroupedListStyle())
                .navigationTitle("Fruit List")
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        NavigationLink(destination: SecondView()) {
                            Text("SecondView")
                        }
                        Text("")
                    }
                })
                
        }
    }
}
//MARK: Second Screen
struct SecondView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    /*
        1) @StateObject -> USE THIS ON CREATION / INIT
        2) @ObservedObject -> USE THIS FOR SUBVIEWS
    */
    
    //MARK: ObservedObject
    @ObservedObject var fruitViewModel: FruitViewModel = FruitViewModel()
    
    var body: some View {
        
        ZStack {
            Color.green.ignoresSafeArea()
            
            VStack {
                ForEach(fruitViewModel.fruitArray) {
                    fruits in
                    HStack {
                        Text(fruits.name)
                        Text("\(fruits.count)")
                    }.foregroundColor(.white)
                        .font(.headline)
                }
            }
            
        }
        
    }
}

struct StateObject_ObservableObject_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
           StateObject_ObservableObject()
        }
    }
}
