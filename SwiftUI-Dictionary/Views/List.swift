import SwiftUI

struct List_Views: View {
    
    @State var fruits:[String] = ["Apple", "Orange","Banana", "Peach"]
    
    @State var veggies: [String] = ["Tomato", "Potato", "Carrot"]
    
    var body: some View {
      
        NavigationView {
            
            //MARK: Adding List
            List {
                
                //Section has a header named Fruits
                
                Section(header:
                    //MARK: Customized Header
                    HStack {
                    Text("Fruits")
                    Image(systemName: "apple.logo")
                })
                    {
                        
                        //Using a forEach to retrieve all the fruits in the array
                        
                        ForEach(fruits, id: \.self) {
                            Text($0).foregroundColor(.white)
                        }
                        
                        //adding the onDelete and passing the onDelete function created below. This needs to be attached to the forEach of the array within a list in order to work.
                        
                        .onDelete(perform: onDelete)
                        
                        //onMove works in the same fashion as onDelete above.
                        
                        .onMove(perform: onMove)
                    }
                    .tint(.yellow)
        
                    .listRowBackground(Color.orange)
                
                Section("Veggies") {
                        ForEach(veggies, id: \.self) { items in
                            Text(items)
                        }
                        .onDelete(perform: onDelete)
                        .onMove(perform: onMove)
                }
                .tint(.green)
                
            }
            //ListStyle changes the formatting on how the style should appear in your list. This would render differently on iPhone vs iPad. Use this with caution
            .listStyle(.sidebar)
            .navigationBarItems(
                leading: EditButton(),
                trailing: addButton)
            //The tint below changes the color of the headers
            .tint(.red)
        }
    }
    
    var addButton: some View {
        Button("Add") {
            fruits.append("Dates")
        }
    }
    
    //MARK: Delete and Move Function
    //Delete function finding the index from your IndexSet to remove from the list. It goes over the array's index i.e 0, 1, 2, 3, etc. And it removes based on the index where the item is located in the list.
    func onDelete(indexSet: IndexSet) {
        fruits.remove(atOffsets: indexSet)
    }
    // On move works the same manner as onDelete but it requires two parameters to be passed in. One to know where it started from and second, where it ended up.
    func onMove(from: IndexSet, to: Int) {
        fruits.move(fromOffsets: from, toOffset: to)
    }
}

struct List_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List_Views()
        }
    }
}
