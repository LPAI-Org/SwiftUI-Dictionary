import SwiftUI

struct SafeArea_Views: View {
    var body: some View {
//        ZStack {
//
//            /*
//             Having the Text in its own VStack and adding the background on a ZStack, you ensure the content doesn't push over the safe area and only the background is outside of the safe area.
//             */
//
//
//            //background layer
//            Color.blue
//            .ignoresSafeArea()
//
//            //foreground layer
//            VStack {
//                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//                Spacer()
//
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//
//        }
        
        ///Using ScrollView without ignoreSafeArea and it still pushes over the safe area without pushing the content into the safe area.

        ScrollView {

                VStack {

                    Text("Title Goes Here")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    ForEach(0..<10) {
                        _ in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                            .frame(height: 100)
                            .shadow(radius: 10)
                            .padding()
                    }
                }
        }.background(.purple)
    }
}

struct SafeArea_Previews: PreviewProvider {
    static var previews: some View {
        SafeArea_Views()
    }
}
