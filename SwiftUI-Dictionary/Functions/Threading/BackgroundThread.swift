//MARK: NOTES:
/*
 THREADING IS NOT WORKING PROPERLY, THROWS 'NSRangeException', reason: '*** -[__NSArray0 objectAtIndex:]: index 0 beyond bounds for empty NSArray' ERROR
 
 MOST LIKELY DUE TO OTHER FILES IN THIS PROJECT CONFLICTING WITH THE CODE.
 
 CREATED A SEPARATE PROJECT FOR THIS BOOTCAMP AND IT WORKS WITHOUT ANY ISSUES.
 
 NAME OF NEW PROJECT FOR THIS TRIAL: threading_Testtrial
 
 
 */

//import SwiftUI
//
//class BackgroundThreadViewModel: ObservableObject {
//    @Published var dataArray: [String] = []
//
//
//    func fetchData() {
//
//        DispatchQueue.global().async {
//            let newData = self.downloadData()
//            DispatchQueue.main.async {
//                self.dataArray = newData
//            }
//        }
//    }
//    func downloadData() -> [String] {
//        var data: [String] = []
//
//        for x in 0..<100 {
//            data.append("\(x)")
//            print(data)
//        }
//        return data
//    }
//}
//
//struct BackgroundThread_Function: View {
//
//    @StateObject var vm = BackgroundThreadViewModel()
//
//    var body: some View {
//
//        ScrollView {
//
//            VStack(spacing: 10) {
//                Text("Load Data").font(.largeTitle).fontWeight(.semibold)
//                    .onTapGesture {
//                        vm.fetchData()
//                    }
//
//                ForEach(vm.dataArray, id: \.self) {
//                    item in
//                    Text(item).font(.headline).foregroundColor(.pink)
//                }
//            }
//        }
//    }
//}
//
//struct BackgroundThread_Previews: PreviewProvider {
//    static var previews: some View {
//        BackgroundThread_Function()
//    }
//}
