import SwiftUI

struct AnimatableData_styles: View {
    
    @State private var animate: Bool = false
    
    var body: some View {
        ZStack {
          //  RoundedRectangle(cornerRadius: animate ? 60: 0).frame(width: 250, height: 250)
//            RectangleSingleCornerAnimate(cornerRadius: animate ? 60: 0)
            PacMan(offSetAmount: animate ? 20 : 0)
                .fill(.yellow)
                .frame(width: 250, height: 250)

        }.onAppear {
            withAnimation(.linear.repeatForever()) {
                animate.toggle()
            }
        }
    }
}

struct AnimatableData_Previews: PreviewProvider {
    static var previews: some View {
        AnimatableData_styles()
    }
}

struct RectangleSingleCornerAnimate: Shape {

    //MARK: AnimatableData Version 1
    //without the small chunk of property code below, the withAnimation code wont know what to animate.
    var cornerRadius: CGFloat
    var animatableData: CGFloat {
        get { cornerRadius}
        set { cornerRadius = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path {
            path in
            
            //move to left top corner
            path.move(to: .zero)
            //Top line across
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            //Moving a line from top right to bottom right then cutting it with cornerRadius 60 property
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
            //While in the bottom right corner after cutting it in an angle down, we want to bend it into an arc with a by adding path.addArc
            path.addArc(
                //since we are in the right bottom corner, our center would be in the middle of the two centers we cut across above
                center:
                    CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                radius: cornerRadius,
                //here we add the angle of a circle which always starts at 0 to 360
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 360),
                clockwise: false)
            
            //now we have perfect circle added to the bottom right corner but we need to create a line from the bottom left to the bottom right to blend it into a perfect square with a radius bottom right corner
            //from the bottom right with the corner radius to the bottom left
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY))
                             
            //finally moving a final line from the left bottom corner to the top left corner
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
            
        }
    }
}


struct PacMan: Shape {
    //MARK: AnimatableData version 2
    //You can technically use CGFloat or Double, as long as its not an Int. 
    var offSetAmount: Double
    var animatableData: Double {
        get { offSetAmount} set { offSetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path {
            path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.minY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: offSetAmount),
                endAngle: Angle(degrees: 360 - offSetAmount),
                clockwise: false)
        }
    }
}
