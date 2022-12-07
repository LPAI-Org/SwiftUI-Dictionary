import SwiftUI
//MARK: Button Style
struct PressableButtonStyle: ButtonStyle {
    
    let scaleAmount: CGFloat
    
    init(scaleAmount: CGFloat) {
        self.scaleAmount = scaleAmount
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
            //.brightness(configuration.isPressed ? 0.5:0)
            .opacity(configuration.isPressed ? 0.3: 1.0)
    }
}
//MARK: Extension
//you can remove the .self below, Xcode is smart enough to know its for self.
//Having the extension it makes it much cleaner to use custom styles in your project
extension View {
    func withPressableStyle(scaleAmount: CGFloat = 0.9) -> some View {
        buttonStyle(PressableButtonStyle(scaleAmount: scaleAmount))
    }
}
struct CustomButtonStyles_Styles: View {
    var body: some View {
        VStack {
            //Version 1 using custom view
            Button {
                //
            } label: {
                Text("Click Me 1")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(10)
                    .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
            }
            //MARK: Taking only custom style (no extension use here)
            .buttonStyle(PressableButtonStyle(scaleAmount: 0.5))
        .padding(40)
            
            Divider()
            
            //Version 2 using extension & taking in default amount of scaleAmount
            
            Button {
                //
            } label: {
                Text("Click Me 2")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(10)
                    .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
            }
            //MARK: Extension added
            .withPressableStyle()
            .padding(40)
            
            Divider()
            //Version 3 using extension & passing in the parameter scaleAmount
            
            Button {
                //
            } label: {
                Text("Click Me 3")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(10)
                    .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0.0, y: 10)
            }
            //MARK: Extension added
            .withPressableStyle(scaleAmount: 1.2)
            .padding(40)
            
            
        }

    }
}

struct CustomButtonStyles_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonStyles_Styles()
    }
}
