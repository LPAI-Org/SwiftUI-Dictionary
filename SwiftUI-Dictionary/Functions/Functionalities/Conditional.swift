import SwiftUI

struct Conditional_Function: View {
    
    @State var showCircle:Bool = false
    
    var body: some View {
        
        VStack {
            
            Button {
                showCircle.toggle()
            } label: {
                ZStack{
                    //This is a conditional statement. If showCircle is true, show the following within the brackets, otherwise show the else statement. 
                    if showCircle {
                        Circle().frame(width: 100, height: 100)
                        Text("Show Circle").foregroundColor(.white)
                    } else {
                        Text("Show Circle")
                    }
                }
            }

        }
        
       
    }
}

struct Conditional_Previews: PreviewProvider {
    static var previews: some View {
        Conditional_Function()
    }
}
