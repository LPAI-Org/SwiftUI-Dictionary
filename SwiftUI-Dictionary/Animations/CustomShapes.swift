import SwiftUI

struct CustomShapes: View {
    var body: some View {
        ZStack {
            
            Trapezoid()
                .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round, miterLimit: 5, dash: [5], dashPhase: 2.0))
                .foregroundColor(.blue)
                .frame(width: 300, height: 300)
                
        }
    }
}

struct CustomShapes_Previews: PreviewProvider {
    static var previews: some View {
        CustomShapes()
    }
}

//MARK: Three custom shapes below
struct Trapezoid: Shape {
    func path(in rect: CGRect) -> Path {
        Path {
            path in
            let horizontalOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
            
        }
    }
}


struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        Path {
            path in
            let horizontalOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}


struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path {
            path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
    
}
