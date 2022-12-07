import SwiftUI

struct AppStorage_func: View {
    //MARK: State variable for UserDefaults
  //  @State var currentUserName: String? = nil
    //MARK: AppStorage
    @AppStorage("Name") var currentUserName: String?
    
    var body: some View {
      
        VStack(spacing: 20) {
         //Two Save ways to unwrap options
            //MARK: Unwrap 1
            Text("Regular unwrap: \(currentUserName ?? "Add Name Here")")
            
            //MARK: Unwrap 2
            //This version wont have any data displayed if its nil
            if let name = currentUserName {
                Text("If-let version: \(name)")
            }
            
            Button("Save".uppercased()) {
                let name = "Tiffany"
                currentUserName = name
            //    UserDefaults.standard.set(name, forKey: "Name")
                
            }
            Button("Clear".uppercased()) {
                let name = ""
                currentUserName = name
             //Using AppStorage, we dont need to call a function to set and get the data anymore. We basically pass in the data like a regular property. Hence why this is awesome in comparison. 
                
                
                //MARK: UserDefault Version
                //UserDefaults.standard.set(name, forKey: "Name")
                
            }
        }
        //If we are using userDefault, we need a way to call/retrieve the data when the screen loads
//        .onAppear(perform: {
//            currentUserName =
//            UserDefaults.standard.string(forKey: "Name")
//        })
        
    }
}

struct AppStorage_Previews: PreviewProvider {
    static var previews: some View {
        AppStorage_func()
    }
}
