import SwiftUI

struct CustomCurves: View {
    var body: some View {
        WaterShape()
            //.stroke(style: StrokeStyle(lineWidth: 5))
            .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .ignoresSafeArea()
    }
}

struct CustomCurves_Previews: PreviewProvider {
    static var previews: some View {
        CustomCurves()
    }
}


struct ArcSample:Shape {
    func path(in rect: CGRect) -> Path {
        Path {
            path in
            path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 40),
                clockwise: true)
            
        }
    }
}

struct ShapeWithArc: Shape {
    func path(in rect: CGRect) -> Path {
        Path {
            
            //MARK: legend of path rect point location
            //minX = Far Top left
            //midX = Middle top
            //maxX = Top Right
            //minY = Far Top left
            //midY = Mid Left
            //maxY = Bottom Left Corner
            
            //path.move is used to start your positioning, and depending on where you're starting the above coordinate of rect path location will adjust with it.
            
            path in
            //top left
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            
            //top right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            
            //mid right
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            
            //bottom
           // path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                //radius is always a circle, so you take the height and divide it by 2 to make a perfect half circle
                radius: rect.height / 2,
                //StartAngle & EndAngle create the angle of the arc, how much you want it to turn by creating a starting angle and ending angle
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 180),
                clockwise: false)
            
            //mid left
            
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        }
    }
}


struct QuadSample: Shape {
    func path(in rect: CGRect) -> Path {
        Path {
            path in
            //.zero takes the curser and moves it to the top left corner as a starting point. Its a short hand code versus using CGPoint to move to that location
            path.move(to: .zero)
        path.addQuadCurve(
            to: CGPoint(x: rect.midX, y: rect.midY),
            control: CGPoint(x: rect.maxX - 50, y: rect.minY - 100))
        }
    }
}


struct WaterShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path {
            path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.midY),
                control:
                    CGPoint(x: rect.width * 0.25, y: rect.height * 0.40))
            
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.midY),
                control:
                    CGPoint(x: rect.width * 0.75, y: rect.height * 0.60))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}
