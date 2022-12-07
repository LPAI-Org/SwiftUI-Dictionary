import SwiftUI

struct Gradient_Styles: View {
    
    var firstCustomColor = #colorLiteral(red: 1, green: 0.3630719781, blue: 0.9806739688, alpha: 1)
    var secondCustomColor = #colorLiteral(red: 0, green: 0.7957646847, blue: 1, alpha: 1)
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(
               // Gradient(colors: [.blue, .purple])
//                LinearGradient(gradient:
//                                Gradient(
//                                colors: [.purple, .teal]
//                                ),
//                               startPoint: .top,
//                                endPoint: .trailing)
                
     //           RadialGradient(gradient: Gradient(colors: [.blue, .teal]), center: .center, startRadius: 3, endRadius: 125) // Gradient that starts from the center and moves out in a circular manner
                
//                LinearGradient(gradient: Gradient(colors: [Color(firstCustomColor), Color(secondCustomColor)]), startPoint: .top, endPoint: .trailing) // Gradient taking in custom colors from properties assigned
                
//                RadialGradient(gradient: Gradient(
//                    colors: [Color(firstCustomColor),
//                             Color(secondCustomColor)]),
//                               center: .topLeading,
//                               startRadius: 3,
//                               endRadius: 333) //RadialGradient taking custom colors
            
                AngularGradient(gradient: Gradient(colors: [Color(firstCustomColor), Color(secondCustomColor)]), center: .leading, angle: .degrees(30 * 40)) //Angular Gradient. You can use arithmetic in the degrees to get the style you're aiming to achieve . 

                
            )
            .frame(width: 300, height: 300)
    }
}

struct Gradient_Styles_Previews: PreviewProvider {
    static var previews: some View {
        Gradient_Styles()
    }
}
