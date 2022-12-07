import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

//Below we have three different ways we can approach it

//1 - use binding
///To create multiple sheets on one screen, you need to have the screens use the same model as binding first and pass in the screen in the sheet binding to the @state property in the main screen.
//2 - use multiple .sheets
///Using the second approach rule requires that you put all the sheets in the child view and non in the parent view because if you have one on the parent view it will override all the sheets in the child view but this approach would get annoying if you had a lot of sheets added in the child view multiple times.
//3 - use $item
///This is the most scalable


struct Multiple_Sheets: View {
    
    @State private var isPresented: Bool = false
    @State private var isPresented2: Bool = false
    
    ///First & Second approach below:
//    @State private var selectedModel: RandomModel = RandomModel(title: "Starting Title")
    ///Third Approach below:
    @State private var selectedModel: RandomModel? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ///Third approach below:
                ForEach(0..<51) {
                    index in
                    
                    Button("Button \(index)")
                    {
                        ///First & Third approach below:
                                selectedModel = RandomModel(title: String(index))
        //                isPresented.toggle()
                    }
                    ///Second approach below:
                    //            .sheet(isPresented: $isPresented, content: {
                    //                NextScreen(selectedModel: RandomModel(title: "ONE"))
                    //            })
                }
                
     
//
//                Button("Button 2")
//                {
//                    ///First & Third approach below:
//                    selectedModel = RandomModel(title: "Two")
//    //                isPresented2.toggle()
//                }
                ///Second approach below:
                //            .sheet(isPresented: $isPresented2, content: {
                //                NextScreen(selectedModel: RandomModel(title: "TWO"))
                //            })
                
            }///Third approach below
            .sheet(item: $selectedModel) {
                model in
                NextScreen(selectedModel: model)
        }
        }
        ///First approach below:
        //        .sheet(isPresented: $isPresented, content: {
        //            NextScreen(selectedModel: $selectedModel)
        //        })
    }
}
//MARK: SECOND SCREEN
struct NextScreen: View {
    
    ///Second approach below:
    let selectedModel: RandomModel
    
    ///First approach below:
    //    @Binding selectedModel: RandomModel
    
    var body: some View {
        
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

struct Multiple_Sheets_Previews: PreviewProvider {
    static var previews: some View {
        Multiple_Sheets()
    }
}
