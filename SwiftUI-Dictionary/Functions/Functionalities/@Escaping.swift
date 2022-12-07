import SwiftUI

class EscapingViewModel: ObservableObject {
    @Published var text: String = "...."
    
    func getData() {
//        downloadData3 { [weak self] returnedData in
//            self?.text = returnedData
//        }
        
        downloadData5 { [weak self] DownloadResult in
            self?.text = DownloadResult.data
        }
        
    }
    
    //MARK: 5 = Escaping Closure Examples
    //most simplest function taking no parameters and returning an immediate string.
    func downloadData() -> String {
        return "New Data!"
    }
    
    //takes in a string and returns void. It gets only executed when called upon.
    func downloadData2(handler: (_ data: String) -> Void){
        handler("New Data2!")
    }
    
    //this allows us to use escaping to make our property become async. In this case, we are only required one data point which is a string and if there is no data passed into it, then no error will be thrown since its not getting called. Hence why its called asynchronous code.
    func downloadData3(handler: @escaping (_ data: String) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            handler("New Data3!")
        })
    }
    
    //By creating a model of DownloadResult, we can pass that as our escaping closure and it can take as many data points as we require so that we can call it in getData() like a modifier. In our case, its .data.
    func downloadData4(handler: @escaping (DownloadResult) -> ()){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
           let result = DownloadResult(data: "New Data4!")
            handler(result)
        })
    }
    
    //The same ability as downloadData4 utilizing Typealias, making the function call a lot more cleaner and more professional
    func downloadData5(handler: @escaping DownloadCompletion){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
           let result = DownloadResult(data: "New Data5!")
            handler(result)
        })
    }
}

//MARK: Typealias
typealias DownloadCompletion = (DownloadResult) -> ()

//MARK: Model
struct DownloadResult {
    let data: String
}


struct _Escaping_Function: View {
    
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle).bold().foregroundColor(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

struct _Escaping_Previews: PreviewProvider {
    static var previews: some View {
        _Escaping_Function()
    }
}
