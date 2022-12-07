import SwiftUI

struct Animations: View {
    
    @State private var isAnimated:Bool = false
    
    var body: some View {
        VStack {
            Button {
                //adding the "withAnimation" it will force the button toggle to animate based on the parameter you passed in. Below, we passed .easeInOut(duration:0.5).
                withAnimation(.easeInOut(duration: 0.5)) {
                    isAnimated.toggle()
                }
            } label: {
                Text("Button")
            }
            Spacer()
            
            //Adding the isAnimated as a Ternary within each modifier will respond with the animation effect placed to the toggle button.
            
            RoundedRectangle(cornerRadius: isAnimated ? 50:25)
                .fill(isAnimated ? .red:.green)
                .frame(width: isAnimated ? 100:300, height: isAnimated ? 100:300)
                .rotationEffect(Angle(degrees: isAnimated ? 300:0))
                .offset(y: isAnimated ? 300:0)
               
            Spacer()
        }
    }
}

struct Animations_Previews: PreviewProvider {
    static var previews: some View {
        Animations()
    }
}
