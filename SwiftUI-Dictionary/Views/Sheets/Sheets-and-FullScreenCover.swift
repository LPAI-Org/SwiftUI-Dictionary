import SwiftUI

struct Sheets_and_FullScreenCover: View {
    
    @State private var showSheet:Bool = false
    var body: some View {
        ZStack {
            
            Color.green
                .ignoresSafeArea()
            
            Button {
                
                showSheet.toggle()
            
            } label: {
                Text("Button").foregroundColor(.green)
                    .font(.headline)
                    .padding(20)
                    .background(Color.white.cornerRadius(10))
            }

            
        }
        ///below is the full screen cover view. This covers the full screen and it requires a dismiss() function on the secondscreen or you wont be able to slide down and back like you would with sheet() modifier

//        .fullScreenCover(isPresented: $showSheet) {
//            SecondScreen()
//      }
      
        ///Adding the sheet below and invoking a new view (Do not ever use conditional logic inside a sheet modifier, it will have unexpected behavior)
      .sheet(isPresented: $showSheet) {
          SecondScreen()
            //presentationDetents provide the level of height you would allow for the sheet to be pulled up and down. Below we are using three sizes, Fraction, Medium and Large.
             .presentationDetents([.fraction(0.8), .medium, .large])
      }
    }
}

struct SecondScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(20)
            }

        }
    }
}

struct Sheets_and_FullScreenCover_Previews: PreviewProvider {
    static var previews: some View {
        Sheets_and_FullScreenCover()
    }
}
