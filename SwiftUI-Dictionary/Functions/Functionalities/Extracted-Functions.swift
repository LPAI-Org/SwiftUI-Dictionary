import SwiftUI

struct Extracted_Functions: View {
    
    @State var backgroundColor: Color = .pink
    @State var myTitle = "Pink"
    var body: some View {
        ZStack {
            //Background
            backgroundColor.ignoresSafeArea()
            
            //Both methods below create a view but one the struct method would require a binding variable while creating a view from a property doesn't require a binding property as it is still within the same struct view.
            
            //SubView content allows us to use the same view throughout our entire app while property view its only useful within the same struct view.
            
            VStack {
                //MARK: Content via new struct (Subview)
                NewView(backgroundColor: $backgroundColor, myTitle: $myTitle)
                //MARK: Content via property
                ContentLayer
            }
        }
        
    }
    var ContentLayer: some View {
        VStack {
            Text(myTitle)
                .font(.largeTitle)
            
            Button {
                withAnimation(.easeIn(duration: 1)) {
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

struct Extracted_Functions_Previews: PreviewProvider {
    static var previews: some View {
        Extracted_Functions()
        
    }
}

struct NewView: View {
    @Binding var backgroundColor: Color
    @Binding var myTitle:String
    
    var body: some View {
        VStack {
            Text(myTitle)
                .font(.largeTitle)
            
            Button {
                withAnimation(.easeIn(duration: 1)) {
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
