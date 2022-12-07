import SwiftUI

//Transition Modifier is a big arrow in my ankle. Can't get it to perform in the same manner in IOS 16+ as in it does in IOS 15 and below. Needs a lot more work but there are a bunch of different modifiers below that you can play with.
struct MyMoveModifier: ViewModifier {

    let width: CGFloat
    let height: CGFloat

    @Binding var forward: Bool

    

    func body(content: Content) -> some View {

        content

            .offset(x: (forward ? 1 : -1) * width, y: (forward ? 0 : 1) * height)

    }

}

//MARK: Modifier
struct RoatateViewModifer: ViewModifier {
    
    let rotation: Double
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
            .offset(
                x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                y: rotation != 0 ? UIScreen.main.bounds.height : 0)
    }
}

extension AnyTransition {
    

    static var rotating: AnyTransition {
        return AnyTransition.modifier(
            active: RoatateViewModifer(rotation: 180),
            identity: RoatateViewModifer(rotation: 0))
    }
    
        static func rotating(rotation: Double) -> AnyTransition {
            return AnyTransition.modifier(
                active: RoatateViewModifer(rotation: rotation),
                identity: RoatateViewModifer(rotation: 0))
        }

    static func rotatingOut(rotating: Double) -> AnyTransition {
        return AnyTransition.modifier(
            active: RoatateViewModifer(rotation: rotating),
            identity: RoatateViewModifer(rotation: 0))
    }

    static func rotatingIn(rotating: Double) -> AnyTransition {
        return AnyTransition.modifier(
            active: RoatateViewModifer(rotation: rotating),
            identity: RoatateViewModifer(rotation: 0))
    }
    
    static var slideOff: AnyTransition {
        return AnyTransition.asymmetric(
            insertion: .rotating,
            removal: .move(edge: .leading))
    }
    
    
    
    static func myMove(forward: Binding<Bool>) -> AnyTransition {

        return .asymmetric(

            insertion: .modifier(

                active: MyMoveModifier(width: 100, height: 100, forward: forward),

                identity: MyMoveModifier(width: 0, height: 0, forward: .constant(true))

            ),

            removal: .modifier(

                active: MyMoveModifier(width: -100, height: -100, forward: forward),

                identity: MyMoveModifier(width: 0, height: 0, forward: .constant(true))

            )

        )

    }
}

struct CustomAnyTransition_Animation: View {
    
    @State private var showRectangle:Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            //if adding the second frame is confusing, comment it out and see the behavior of the transition and in the simulator go from Live mode to Selectable to see how the frame covers the screen area.
            if showRectangle {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 250, height: 350)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .transition(.rotatingOut(rotating: 1080))
//                    .transition(.rotatingIn(rotating: 1080))
                    .transition(.asymmetric(insertion: .rotating, removal: .move(edge: .leading)))
                
                    //.transition(.myMove(forward: $showRectangle))
                    //.transition(AnyTransition.rotating.animation(.easeInOut))
                   // .transition(.move(edge: .leading))
                   // .transition(AnyTransition.scale.animation(.easeInOut))

            }
            
            
            Spacer()
            
            Text("Click Me")
                .withDefaultButtonFormatting()
                .padding(.horizontal, 40)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 2)) {
                        showRectangle.toggle()
                    }
                }
        }
    }
}

struct CustomAnyTransition_Previews: PreviewProvider {
    static var previews: some View {
        CustomAnyTransition_Animation()
    }
}
