import SwiftUI

struct Animation_Curves: View {
    
    @State private var isAnimating:Bool = false
    @State private var timing:Double = 1.0
    var body: some View {
        ScrollView {
            VStack {
                
                Button("Button") {
                    isAnimating.toggle()
                }
           
                
            //Different levels of animation curves below. Animation curves are the parameters passed into Animation such as easeInOut, Linear, easeIn, spring(), etc.
                
                //recent IOS update we need to add a value within animation modifier to offset
                
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: isAnimating ? 350:50, height: 100)
                    .animation(.spring(
                        response: 0.5,
                        dampingFraction: 0.7,
                        blendDuration: 1.0), value: isAnimating ? 100:1000)
                
//                RoundedRectangle(cornerRadius: 20)
//                    .frame(width: isAnimating ? 350:50, height: 100)
//                    .animation(.linear(duration: timing))
//
//                RoundedRectangle(cornerRadius: 20)
//                    .frame(width: isAnimating ? 350:50, height: 100)
//                    .animation(.easeIn(duration: timing))
//
//                RoundedRectangle(cornerRadius: 20)
//                    .frame(width: isAnimating ? 350:50, height: 100)
//                    .animation(.easeInOut(duration: timing))
//
//                RoundedRectangle(cornerRadius: 20)
//                    .frame(width: isAnimating ? 350:50, height: 100)
//                    .animation(.easeOut(duration: timing))
                
//                RoundedRectangle(cornerRadius: 20)
//                    .frame(width: isAnimating ? 350:50, height: 100)
//                    .animation(.spring())
                
            }
        }
    }
}

struct Curves_Previews: PreviewProvider {
    static var previews: some View {
        Animation_Curves()
    }
}
