import SwiftUI

//Naming your data is better to name it after where you will display the data. If its at home, it would be HomeEnvironment, etc.
//MARK: ViewModel - Data
class EnvironmentViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    init() {
        getData()
    }
    
    func getData() {
        self.dataArray.append(contentsOf: ["iPhone", "iPad", "iMac", "Apple-Watch"])
    }
    
}
//MARK: Main View
/// Preview Doesnt Work. Create a simulator build or it will keep crashing in the final View
struct EnvironmentObject_Views: View {
    
    @StateObject var viewModel: EnvironmentViewModel = EnvironmentViewModel()
    
    var body: some View {
        NavigationStack {
            
            List {
                ForEach(viewModel.dataArray, id:\.self) {
                    item in
                    NavigationLink {
                        DetailView(selectedItem: item)
                    } label: {
                        Text(item)
                    }
                    
                }
            }
        }
        .navigationTitle("IOS Devices")
        //MARK: EnvirmentObject - Submission
        //Adding the environmentObject and passing in the data from viewModel so it is within our Environment to grab from anywhere within our app
        .environmentObject(viewModel)
    }
}


//MARK: Second View - Destination
/// This is the second view, passing in the 'item' from the forEach in the EnvironmentObject_Views into 'selectedItem' below
///
struct DetailView: View {
    
    let selectedItem: String
    
    var body: some View {
        
        ZStack {
            Color.orange.ignoresSafeArea()
            
            NavigationLink {
                //Sending the user to the view created below
                FinalView()
            } label: {
                //SelectedItem is taking the array from the forEach within EnvironmentObject_Views
                Text(selectedItem)
                    .font(.headline)
                    .foregroundColor(.orange)
                    .padding()
                    .background(.white)
                    .cornerRadius(30)
            }
        }
    }
}


//MARK: Final View
struct FinalView: View {
    
    //MARK: EnvirmentObject Retrieval
    @EnvironmentObject var viewModel: EnvironmentViewModel
    
    var body: some View {
        
        ZStack {
            //background
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.1351174116, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.5097600818, green: 0.2834306061, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            //foreground layer
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.dataArray, id: \.self) {
                        item in
                        Text(item)
                    }
                    
                }.foregroundColor(.white)
                    .font(.largeTitle)
                
            }
            
        }
    }
}

struct EnvironmentObject_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EnvironmentObject_Views()
        }
    }
}
