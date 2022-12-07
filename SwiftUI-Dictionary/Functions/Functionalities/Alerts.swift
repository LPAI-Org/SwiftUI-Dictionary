import SwiftUI

struct Alert_function: View {
    //MARK: State variables
    @State var isAlertActive:Bool = false
    @State var backgroundColor: Color = .green
    @State var title: String = String()
    @State var message: String = String()
    
    @State var alertChanges: alertTypes? = nil
    @Environment(\.dismiss) var dismiss
    
    enum alertTypes {
        case success, error
    }
    
    var body: some View {
        
        ZStack {
            
            backgroundColor.ignoresSafeArea()
            
            VStack {
                //MARK: Button Alert
                Button("Alert"){
                    isAlertActive.toggle()
//                    title = "First Button"
//                    message = "First message"
                    backgroundColor = .green
                    alertChanges = .success
                }.padding().foregroundColor(.white).font(.headline).background(.blue).cornerRadius(10)
                
                //MARK: Second Button
                Button("Second Alert") {
                    isAlertActive.toggle()
//                    title = "Second button pressed"
//                    message = "Second message"
                    backgroundColor = .green
                    alertChanges = .error
                }.padding().foregroundColor(.white).font(.headline).background(.blue).cornerRadius(10)
                
            }
            //Adding alert modifier with a binding bool to toggle between showing the alert and hiding it.
            .alert(isPresented: $isAlertActive) {
                //Passing the Alert data & buttons to be passed into the alert modifier as a function (cleaner code)
                showAlert()
            }
        }
    }
    
    
    //Using a switch statement of going over different alerts
    func showAlert() -> Alert {
        switch alertChanges {
        case .error:
            return Alert(title: Text("There as an error!"))
        
        case .success:
            return Alert(title: Text("This was a success!"), message: nil, dismissButton: .default(Text("Ok")))
            
        default:
            return Alert(title: Text("no alert"))
        }
        
    }
    
    //Using only a function to switch between alerts.
    
//    func showAlert() -> Alert{
//
//        Alert(
//            title: Text(title),
//            message: Text(message),
//            primaryButton: .default(Text("Ok"), action: {
//                //adding animation to make a smooth transition
//                withAnimation(.spring()) {
//                    backgroundColor = .orange
//                }
//            }),
//            secondaryButton: .destructive(Text("Cancel")))
//
//    }
}

struct Alerts_Previews: PreviewProvider {
    static var previews: some View {
        Alert_function()
    }
}
