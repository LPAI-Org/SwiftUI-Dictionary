import SwiftUI

struct Shapes_Styles: View {
    var body: some View {
        //  Circle()
        // Ellipse()
        
        // Rectangle()
        RoundedRectangle(cornerRadius: 20)
        
        //            .fill(.blue)
        //            .foregroundColor(.red)
        //            .stroke(.blue, lineWidth: 30)
        //            .stroke(.blue, style: StrokeStyle(lineWidth: 20, lineCap: .round, dash: [30, 40, 50, 60]))
                    .trim(from: 0.2 , to: 0.9)
                    .stroke(.purple, lineWidth: 30)
            .frame(width: 200, height: 100)
    }
}

struct Shapes_Styles_Previews: PreviewProvider {
    static var previews: some View {
        Shapes_Styles()
    }
}
