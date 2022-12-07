import SwiftUI
import CoreData

struct CoreData: View {
    
    //MARK: CoreData Model
    @StateObject var vm = CoreDataViewModel()
    //MARK: Properties
    @State private var textFieldFruit: String = ""
    let textFieldColor = Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter fruit name...", text: $textFieldFruit)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(textFieldColor)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button(action: {
                    //guard below ensures there is some text or else return nothing
                    guard !textFieldFruit.isEmpty else {return}
                    vm.addFruit(text: textFieldFruit)
                    textFieldFruit = ""
                }, label: {
                    Text("Save")
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .font(.headline)
                        .foregroundColor(.white)
                        .background(.pink)
                        .cornerRadius(10)
                        .padding(.horizontal)
                })
                
                Spacer()
                
                List {
                    ForEach(vm.savedEntities) {
                        entity in
                        Text(entity.name ?? "No Name")
                            .onTapGesture {
                                vm.updateFruit(entity: entity)
                            }
                    }
                    .onDelete(perform: vm.delete)
                }.listStyle(PlainListStyle())
                
            }.navigationTitle("Fruits")
        }
    }
}

struct CoreData_Previews: PreviewProvider {
    static var previews: some View {
        CoreData()
    }
}
