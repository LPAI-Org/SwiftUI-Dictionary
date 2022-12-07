import SwiftUI

//MARK: Modifier
struct DefaultViewModifier: ViewModifier {
    
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
        .padding()
    }
}
//MARK: Extension -> Modifier
extension View {
    func withDefaultButtonFormatting(backgroundColor: Color = .blue) -> some View {
        //this would take self in but since it is implied you can remove self all together but leaving it below for clarity looking back in the future.
        //self.modifier(DefaultViewModifier())
        modifier(DefaultViewModifier(backgroundColor: backgroundColor))
    }
}

struct ViewModifier_View: View {

    
    var body: some View {
        VStack {
            
            //MARK: Text Modifier added
            Text("First Modifier")
                .modifier(DefaultViewModifier(backgroundColor: .blue))
            
            Divider()
            //MARK: Modifier + Extension
            //Even though we created our own modifier to have a look and feel that is altered in one location, we can still modify the button and overwrite the modifier by calling another modifier like "font" in the example below.
            Text("Second Modifier")
                .font(.subheadline)
                .withDefaultButtonFormatting(backgroundColor: .orange)
        
            Divider()
            
            Text("Third Modifier")
                .font(.largeTitle)
                .withDefaultButtonFormatting(backgroundColor: .purple)
            
            Divider()
            
            //Modifier below taking in no parameter and falling back into the default color (blue) within the extension that we have passed into the function
            Text("Fourth Modifier")
                .font(.largeTitle)
                .withDefaultButtonFormatting()
        }
    }
}

struct ViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifier_View()
    }
}
