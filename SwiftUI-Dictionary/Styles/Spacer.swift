import SwiftUI

struct Spacer_Styles: View {
    var body: some View {
        
        //Utilizing minLength with Spacer to push the elements away or closer to the edges
        
        VStack {
            HStack {
                
                Image(systemName: "xmark")
                Spacer()
                Image(systemName: "gear")
                
            }
                .padding(.horizontal)
            
            Spacer()
        }
        
///Example below uses rectangle boxes for illustration
        
//        HStack {
//            //            Spacer(minLength: 0)
//            //                .frame(height: 10)
//            //                .background(.orange)
//            //
//            //            Rectangle()
//            //                .frame(width: 50, height: 50)
//            //
//            //            Spacer()
//            //                .frame(height: 10)
//            //                .background(.orange)
//            //
//            //            Rectangle()
//            //                .fill(.red)
//            //                .frame(width: 50, height: 50)
//            //
//            //
//            //            Spacer()
//            //                .frame(height: 10)
//            //                .background(.orange)
//            //
//            //            Rectangle()
//            //                .fill(.green)
//            //                .frame(width: 50, height: 50)
//            //
//            //            Spacer(minLength: 0)
//            //                .frame(height: 10)
//            //                .background(.orange)
//        }
    }
}

struct Spacer_Styles_Previews: PreviewProvider {
    static var previews: some View {
        Spacer_Styles()
    }
}
