import SwiftUI

struct Background_and_Overlay_Styles: View {
    
    var gradientColor:RadialGradient {
        let customColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
       return RadialGradient(gradient: Gradient(colors: [Color(customColor), .teal]), center: .center, startRadius: 5, endRadius: 120).self
    }
    
    var customColorOpacity = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 0.3889435017)

    
    var body: some View {
        
        /// You can add overlays by adding the same modifier background with different width sizes like the one below
        //        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        //            .background(
        //            Circle()
        //                .fill(.blue)
        //                .frame(width: 100, height: 100)
        //            )
        //            .background(
        //            Circle()
        //                .fill(.red)
        //                .frame(width: 120, height: 120)
        //            )
        //            .foregroundColor(.white)

//        /// Below is a different method of adding a text or image over another element like Circle() or any other element. Below we are using Circle() and adding an overlay of Text()
//                Circle()
//                    .fill(.pink)
//                    .frame(width: 100, height: 100)
//                    .overlay {
//                        Text("1")
//                            .font(.largeTitle)
//                            .foregroundColor(.white)
//                    }
//                    .background(
//                    Circle()
//                        .fill(.purple)
//                        .frame(width: 110, height: 110)
//                    )

        ///Below is a rectangle versions on adding backgrounds and overlays while using alignment to move each frame into its appropriate place. Play with the alignment variable to understand the concept
//
//        Rectangle()
//            .frame(width: 100, height: 100)
//            .overlay(alignment: .topLeading) {
//                Rectangle()
//                    .fill(.blue)
//                    .frame(width: 50, height: 50)
//            }
//            .background(
//            Rectangle()
//                .fill(.red)
//                .frame(width: 150, height: 150),
//            alignment: .center
//
//            )
        
        ///Using overlays to create a notification icon over another view
        
        Image(systemName: "heart.fill")
            .font(.system(size: 40))
            .foregroundColor(.white)
            .background(
                Circle().fill(gradientColor)
                    .frame(width: 100, height: 100)
                    .shadow(color: Color(customColorOpacity), radius: 10, x: 0.0, y: 10)
                    .overlay(
                        Circle()
                            .fill(.blue)
                            .frame(width: 35, height: 35)
                            .shadow(color: Color(customColorOpacity), radius: 10, x: 5, y: 5)
                            .overlay (
                                Text("5")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            ), alignment: .bottomTrailing
                        )
            )
    }
}

struct Background_and_Overlay_Styles_Previews: PreviewProvider {
    static var previews: some View {
        Background_and_Overlay_Styles()
    }
}
