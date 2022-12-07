import SwiftUI

struct ScrollView_Views: View {
    var body: some View {
        
        //MARK: Basic Scroll View
        //        ScrollView(.horizontal, showsIndicators: false, content: {
        //            HStack {
        //
        //                ForEach(0..<51) {
        //                    _ in
        //                    Rectangle()
        //                        .fill(.blue)
        //                        .frame(width: 300, height: 300)
        //            }
        //        }
        //        })
        
        //MARK: Advanced Scroll View
        //This is adding a LazyVStack that loads the screen when it comes into view
        ScrollView {
            LazyVStack {
                ForEach(0..<20) { index in
                    
                    //Using Scroll View by passing parameters for showing the scroll indicator and changing the position of the scroll from vertical to horizontal
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack {
                            ForEach(0..<21) { _ in
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.white)
                                    .frame(width: 200, height: 150)
                                    .shadow(radius: 10)
                                    .padding()
                            }
                        }
                    })
                }
                
            }
        }
    }
}

struct ScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView_Views()
    }
}
