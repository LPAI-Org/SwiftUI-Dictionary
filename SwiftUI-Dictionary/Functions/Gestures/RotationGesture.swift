import SwiftUI

struct RotationGesture_Function: View {
    @State private var angle: Angle = Angle(degrees: 0)
    
    var body: some View {
        VStack{
            
            Text("Hello World")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(50)
                .background(Color.blue.cornerRadius(10))
                .rotationEffect(angle)
                .gesture(
                    //MARK: RotationGesture
                    RotationGesture()
                        .onChanged({ value in
                            angle = value
                        })
                        .onChanged({ value in
                            withAnimation(.spring()){
                                angle = Angle(degrees: 0)
                            }
                        })
                )
            
        }
    }
}

struct RotationGesture_Previews: PreviewProvider {
    static var previews: some View {
        RotationGesture_Function()
    }
}
