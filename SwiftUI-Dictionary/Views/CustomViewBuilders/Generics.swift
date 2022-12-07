import SwiftUI

//MARK: Two Non Generic Models below
struct StringModel {
    let info: String?
    func removeInfo() -> StringModel {
        StringModel(info: nil)
    }
}

struct BoolModel {
    let info: Bool?
    func removeBoolValue() -> BoolModel {
            BoolModel(info: nil)
    }
}
//MARK: Generic Model Example
struct GenericModel<T> {
    let info: T?
    
    func removeAll() -> GenericModel {
        GenericModel.init(info: nil)
    }
}


//MARK: ViewModel

class GenericsViewModel: ObservableObject {

    @Published var stringModel = StringModel(info: "Hello ,Word!")
    
    @Published var boolModel = BoolModel(info: true)
    
    @Published var genericStringModel = GenericModel(info: "Hello, World!")
    
    @Published var genericBoolModel = GenericModel(info: true)
    
    func removeData() {
        stringModel = stringModel.removeInfo()
        boolModel = boolModel.removeBoolValue()
        genericBoolModel = genericBoolModel.removeAll()
        genericStringModel = genericStringModel.removeAll()
    }
}

//MARK: Second View = GenericView

///Below we are explicitly stating what type of Generic it will take in by stating the following <T: View> <--This is taking a view only now --> therefore content will require a view like Text() or any other type of view
struct GenericView<T:View>: View {
    
    let content: T
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
            content
        }
    }
}

struct Generics: View {
    @StateObject var vm = GenericsViewModel()
    @StateObject var boolVM = GenericsViewModel()
    @StateObject var genericBoolValue = GenericsViewModel()
    @StateObject var genericStringValue = GenericsViewModel()
    
    var body: some View {
        VStack(spacing: 30) {
                
            GenericView(content: Text("Hello, Worllllldddd"), title: "This is a ttitle")
          //  GenericView(title: "NEW VIEW!")
            
            Text(vm.stringModel.info ?? "No Data")
            Text(boolVM.boolModel.info?.description ?? "No Bool")
            
            Text(genericBoolValue.genericBoolModel.info?.description ?? "No Generic Bool Value")
            
            Text(genericStringValue.genericStringModel.info ?? "No Generic String Value")
            
                .onTapGesture {
                    vm.removeData()
                    boolVM.removeData()
                    genericBoolValue.removeData()
                    genericStringValue.removeData()
                    
                    
                }
        }
    }
}

struct Generics_Previews: PreviewProvider {
    static var previews: some View {
        Generics()
    }
}
