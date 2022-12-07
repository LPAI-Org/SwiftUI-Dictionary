import SwiftUI
//MARK: System Material Versions
/*
 Getting material types
 static let ultraThin: Material
 A mostly translucent material.
 
 static let thin: Material
 A material that’s more translucent than opaque.
 
 static let regular: Material
 A material that’s somewhat translucent.
 
 static let thick: Material
 A material that’s more opaque than translucent.
 
 static let ultraThick: Material
 A mostly opaque material.
 
 static let bar: Material
 A material matching the style of system toolbars.

 */
struct System_Materials: View {
    
    
    let url = URL(string: "https://picsum.photos/400/")
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack{
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 40, height: 4)
                    .padding()
                Spacer()
            }
            .frame(height: 350)
            .frame(maxWidth: .infinity)
            //MARK: Background Material
            ///different versions of System Materials listed above in the comments
            .background(.ultraThinMaterial)
            .cornerRadius(30)
        }.ignoresSafeArea()
            .background(
                AsyncImage(url: url)
            )
    }
}

struct System_Materials_Previews: PreviewProvider {
    static var previews: some View {
        System_Materials()
    }
}
