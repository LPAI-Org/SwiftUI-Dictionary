import SwiftUI

struct Mask_Modifier: View {
    
    @State private var rating: Int = 3
    
    var body: some View {
        
        //Getting the black colored stars
        starView
        //overlaying it with the geometry reader rectangle
            .overlay(
                overlayView
                //masking it back with the starView to match the rectangle color yellow to the black stars so they become yellow
                //MARK: Mask
                    .mask(starView)
            )

    }
    
    private var overlayView: some View {
        
        ZStack {
            
            starView
                .overlay(
                    GeometryReader { geo in
                        //adding the ZStack for the purpose of adding the alignment .leading, to always start the geometry reader from the start of the element which is the stars in our case.
                        ZStack(alignment: .leading) {
                            Rectangle()
                            //we can customize the color scheme of this rectangle which will overlay as a mask on the stars. Instead of a foregroundColor, we can use .fill and add gradients.
                                .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)), Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                                //.foregroundColor(.yellow)
                            
                            //we know there are 5 stars and if we want to get one out of five, we divide the 'rating' property by 5 times the size of the full width of the geometry reader to land the exact spot of the star.
                                .frame(width: CGFloat(rating) / 5 * geo.size.width)
                        }
                    }
                    //allowshitTesting basically means it allows the users to click on the layer below it that has an ontapGesture which in our case is within starView.
                        .allowsHitTesting(false)
                )
        }
    }
    
    private var starView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
                }
            }
    }
}

struct Mask_Previews: PreviewProvider {
    static var previews: some View {
        Mask_Modifier()
    }
}
