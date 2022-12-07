//Note: GeometryReader slows down the app if its over used.

import SwiftUI

struct GeometryReader_Preview: View {
    
    func getPercentage(geo: GeometryProxy) -> Double {
        // maxDistance gets dimensions for half of the screen
        let maxDistance = UIScreen.main.bounds.width / 2
        //currentX grabs the global frame of the entire device and the value of the center of the screen
        let currentX = geo.frame(in: .global).midX
        //now we divide half the width with the value of the middle of the screen
        let distance = (currentX / maxDistance)
        //then we deduct one from it to flatten the frame when it reaches the middle
        let coordinate = 1 - distance
        return Double(coordinate)
    }
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20){
                    index in
                    //MARK: GeometryReader
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geometry) * 33),
                                axis: (x: 0, y: 1.0, z: 0)  )
                      
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        }
        
        
//        GeometryReader { geometry in
//            HStack(spacing: 0) {
//                Rectangle().fill(.red)
//                    .frame(width: geometry.size.width * 0.6666)
//                Rectangle().fill(.blue)
//            }
//            .ignoresSafeArea()
//        }

    }
}

struct GeometryReader_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader_Preview()
    }
}
