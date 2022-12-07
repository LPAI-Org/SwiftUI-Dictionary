import SwiftUI

struct Transitions: View {
    
    @State private var showView:Bool = false
    var body: some View {
        ZStack(alignment: .bottom) {
            
           
            VStack {
                Button("Button") {
                    showView.toggle()
                }
                Spacer()
            }
            if showView {
                
                ///Version One
                ///
//                RoundedRectangle(cornerRadius: 30)
//                    .frame(height: UIScreen.main.bounds.height * 0.5)
//                    .transition(.move(edge: .bottom))
//                    .animation(.spring())
                
                ///Version Two
                
//                RoundedRectangle(cornerRadius: 30)
//                    .frame(height: UIScreen.main.bounds.height * 0.5)
//                    .transition(AnyTransition.opacity.animation(.easeInOut))
                
                ///Version Three
                
                RoundedRectangle(cornerRadius: 30)
                    .frame(height: UIScreen.main.bounds.height * 0.5)
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .bottom)))
                //added value to remove error warning
                    .animation(.spring(), value: 0)
            }
        }
        
    }
}

struct Transitions_Previews: PreviewProvider {
    static var previews: some View {
        Transitions()
    }
}
