import SwiftUI

struct Stepper_Style: View {
    
    @State var stepperValue: Int = 10
    @State var withIncrement: CGFloat = 30
    
    var body: some View {
        NavigationStack {
            Form {
                VStack {
                    //MARK: Stepper styles
                    Stepper("Stepper 1: \(stepperValue)", value: $stepperValue).padding(50)
                  
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: withIncrement, height: 100).foregroundColor(.teal)
                    
                    Stepper("Stepper 2: \(withIncrement, format: .number)") {
                        incrementWidth(amount: 10)
                    } onDecrement: {
                        incrementWidth(amount: -10)
                    }.padding()

                }
            }
        }.navigationTitle("Stepper Styles")
    }
    
    func incrementWidth(amount: CGFloat) {
        withAnimation(.easeOut(duration: 0.5)) {
            withIncrement += amount
        }
    }
}

struct Stepper_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Stepper_Style()
        }
    }
}
