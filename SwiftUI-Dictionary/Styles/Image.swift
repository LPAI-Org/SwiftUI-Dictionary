import SwiftUI

struct Image_Styles: View {
    var body: some View {
//        Image("muskAvatar")
//            .resizable()
//            .scaledToFit()
//            .clipShape(Circle())
//            .frame(width: 264, height: 264)
    
        Image("google")
         //   .renderingMode(.template) //renderingMode allows us to fill in colors on item in the image versus the whole canvas **you can also add this to the image directly in the navigation panel on the image options within the assets folder
            .resizable()
            .scaledToFill()
            .foregroundColor(.blue)
            .frame(width: 300, height: 300)

    }
}

struct Image_Styles_Previews: PreviewProvider {
    static var previews: some View {
        Image_Styles()
    }
}
