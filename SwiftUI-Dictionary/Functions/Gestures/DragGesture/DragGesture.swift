import SwiftUI

struct DragGesture_Function: View {
    
    @State private var offset: CGSize = .zero
    
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    Text("Regular CGSize:")
                    Text("\(offset.width)")
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                }.padding()
                HStack {
                    Text("Absolute: ")
                    Text("\(abs(offset.width))")
                        .foregroundColor(.purple).fontWeight(.bold)
                }
               
                Spacer()
            }
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 300, height: 500)
                .offset(offset)
                .scaleEffect(getScaleAmount())
                .rotationEffect(Angle(degrees: getRotationAmount()))
            //MARK: DragGesture
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation(.spring()){
                                offset = value.translation
                            }
                        })
                        .onEnded({ value in
                            withAnimation(.spring()){
                                
                                // .zero is a short hand instead of writing ->  CGSizeMake(width: CGFloat, height: CGFloat)
                                
                                offset = .zero
                            }
                        })
                )
        }
    }
    
    func getRotationAmount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        //Here we are not using the absolute function because it does make sense for it to go negative going left and positive going right. That indicates to us which side its going to turn towards.
        let currentAmount = offset.width
        let percentage = currentAmount / max
        let percentageAsDouble = Double(percentage)
        let maxAngle: Double = 10
        return percentageAsDouble * maxAngle
    }
    
    func getScaleAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        //the reason we are using the absolute function to pass in the offset.width its because the scaleEffect amount going left or right makes no difference if its a negative or positive amount. Its the same amount scaling left or right, so it can remain positive going both sides.
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / max
        
        return 1.0 - min(percentage, 0.5) * min(percentage, 0.5)

    }
}

struct DragGesture_Previews: PreviewProvider {
    static var previews: some View {
        DragGesture_Function()
    }
}
