import SwiftUI

struct Ternary_Operator: View {

    @State private var isStartingState:Bool = false
    
    var body: some View {
       
        VStack {
     
            Button {
                isStartingState.toggle()
            } label: {
                Text("Click Here").padding().background(.blue).foregroundColor(.white)
            }

                //Below is a ternary operator using the question-mark as a replacement of a if/else statement
            
            // In this case the question mark acts as an if statement. If isStartingState == true, show purple screen, else show pink. 
                RoundedRectangle(cornerRadius: 10)
                    .fill(isStartingState ? .purple:.pink)
        }
    }
}

struct Ternary_Previews: PreviewProvider {
    static var previews: some View {
        Ternary_Operator()
    }
}
