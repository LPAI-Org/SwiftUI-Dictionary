import SwiftUI

///what is being covered:
//do-catch
//try
//throws


class DoTryCatchThrowsDataManager {
    
    let isActive: Bool = true
    
    func getTitle() -> (title: String?, error: Error?){
        if isActive {
            return ("New Text!", nil)
        } else {
            return (nil, URLError(.badURL))
        }
    }
    
    func getTitle2() -> Result<String, Error> {
        if isActive {
            return .success("New Text2")
        } else {
            return .failure(URLError(.appTransportSecurityRequiresSecureConnection))
        }
    }
    
    func getTitle3() throws -> String {
//        if isActive {
//            return "New Text3"
//        } else {
            throw URLError(.badServerResponse)
 //       }
    }
    
    
    func getTitle4() throws -> String {
        if isActive {
            return "Final Text4"
        } else {
            throw URLError(.badServerResponse)
        }
    }
    
}

class DoCatchTryThrowsViewModel: ObservableObject {
    @Published var text: String = "Starting Text..."
    let manager = DoTryCatchThrowsDataManager()
    
    
    func fetchTitle() {
        /*
         let returnedValue = manager.getTitle()
         if let newTitle = returnedValue.title {
         self.text = newTitle
         } else if let error = returnedValue.error {
         self.text = error.localizedDescription
         }
         */
        
        /*
         let result = manager.getTitle2()
         switch result {
         case .success(let newTitle):
         self.text = newTitle
         case .failure(let error):
         self.text = error.localizedDescription
         }
         */
        /*
        let newTitle = try? manager.getTitle3()
        if let newTitle = newTitle {
            self.text = newTitle
        }
         */
        do {
          
            if let newTitle = try? manager.getTitle3() {
                self.text = newTitle
            }
            
            let finalTitle = try manager.getTitle4()
            self.text = finalTitle

        } catch let error {
            self.text = error.localizedDescription
        }
    }
}

struct Do_Try_Catch_Throws: View {
    
    @StateObject var vm = DoCatchTryThrowsViewModel()
    
    var body: some View {
        Text(vm.text)
            .frame(width: 300, height: 300)
            .background(.blue)
            .cornerRadius(10)
            .onTapGesture {
                vm.fetchTitle()
                
            }
    }
}

struct Do_Try_Catch_Throws_Previews: PreviewProvider {
    static var previews: some View {
        Do_Try_Catch_Throws()
    }
}
