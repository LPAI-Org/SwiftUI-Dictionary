import SwiftUI

struct Weak_Self_Functionality: View {
    
    @AppStorage("count") var countAppStorage: Int?
    
    init() {
        countAppStorage = 0
    }
    
    var body: some View {
        NavigationView {
            NavigationLink("Navigate") {
                WeakSelfSecondScreen()
                    .navigationTitle("Screen 1")
            }
        }
        .overlay (
            Text("\(countAppStorage ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green.cornerRadius(10))
            , alignment: .topTrailing
        )
    }
}

struct WeakSelfSecondScreen: View {
    @StateObject var vm = WeakSelfSecondScreenViewModel()

    var body: some View{
        VStack {
            Text("SecondView").font(.largeTitle).foregroundColor(.red)
            
            if let data = vm.data {
                Text(data)
            }
        }
   
        
    }
}

class WeakSelfSecondScreenViewModel: ObservableObject {
    @Published var data: String? = nil
    
    init() {
        print("Initialize A NEW ONE")
        let currentcount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentcount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("De-initialize The LAST ONE")
        let currentcount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentcount - 1, forKey: "count")
    }
    
    func getData(){

            DispatchQueue.main.asyncAfter(deadline: .now() + 500, execute: {
                //MARK: Weak Self
                [weak self] in
                self?.data = "NEW DATA!"
            })
    }
}

struct Weak_Self_Previews: PreviewProvider {
    static var previews: some View {
        Weak_Self_Functionality()
    }
}
