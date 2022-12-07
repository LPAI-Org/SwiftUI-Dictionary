import SwiftUI

struct ColorPicker_Styles: View {
    
    @State var backgroundColor: Color = .green
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            //Super simple function to call a color picker. You bind it to a color property and use that property where you want the changes to occur.
            
            //SupportsOpacity creates the ability for the user to have a opacity slider in the picker
            //MARK: ColorPicker
            ColorPicker("Select a color", selection: $backgroundColor, supportsOpacity: true)
                .padding()
                .background(.black)
                .foregroundColor(.white)
                .font(.headline)
                .cornerRadius(20)
                .padding(50)
                
        }
    }
}

struct ColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        ColorPicker_Styles()
    }
}
