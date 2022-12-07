import SwiftUI

struct Binding_wrapper: View {
    
    
    @State var backgroundColor: Color = .pink
    @State var myTitle = "Pink"
    
    var body: some View {
        ZStack {
            //Background
            backgroundColor.ignoresSafeArea()
            
            //MARK: SubView content
            // Subview allows us to use the same view throughout our entire app while property view its only useful within the same struct view.
            
            VStack {
                //MARK: Content via new struct (Subview)
                //The money sign before the variable name binds to the variable
                BindingView(backgroundColor: $backgroundColor, myTitle: $myTitle)
                
            }
        }
        
    }
}

//New Struct
struct BindingView: View {
    //MARK: Binding to Main View Properties Above
    //Adding @Binding with the same variable name we are connecting it to the main view properties
    @Binding var backgroundColor: Color
    @Binding var myTitle:String
    
    var body: some View {
        VStack {
            Text(myTitle)
                .font(.largeTitle)
            
            Button {
                withAnimation(.easeIn(duration: 0.5)) {
                    buttonPressed()
                }
                
            } label: {
                Text("Press Me")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
            }
        }
    }
    func buttonPressed() {
        backgroundColor = .yellow
        myTitle = "Yellow"
    }
}

struct Binding_Previews: PreviewProvider {
    static var previews: some View {
        Binding_wrapper()
    }
}
