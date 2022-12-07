import SwiftUI

struct Color_Styles: View {
    
    //To obtain color literal below you need to invoke a property and pass in the following #colorLiteral( . Example: var someColor = #colorLiteral(   <--- this brings up the color pallet
    
    var someColor = #colorLiteral(red: 0.7403077483, green: 0.2608321905, blue: 0.5680459142, alpha: 1)
    
    var anotherColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(
               // .pink
              //  Color(someColor)
                
             //   Color(uiColor: .secondarySystemBackground) //uiColor gives us more colors to pick from UIKit like these system colors
                
                Color("ColorSamples") //adding colors to assets you can create variance for dark/light mode
                    )
            .shadow(color: .gray, radius: 30, x: 20, y: 40)
            .frame(width: 300, height: 300)
            
    }
}

struct Color_Styles_Previews: PreviewProvider {
    static var previews: some View {
        Color_Styles()
    }
}
