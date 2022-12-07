import SwiftUI

struct DarkMode_Views: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    //MARK: DARK/LIGHT MODE
                    
                    //Primary and Secondary is adaptable between dark and light mode while explicitly calling a color wont adapt.
                    
                    Text("This Color is primary").foregroundColor(.primary)
                    Text("This color is secondary").foregroundColor(.secondary)
                    Text("This color is Black").foregroundColor(.black)
                    Text("This color is white").foregroundColor(.white)
                    Text("This color is red").foregroundColor(.red)
                    
                    //Below we will use the color assets that is created in the assets.xcassets folder
                    
                    Text("This color is adaptive").foregroundColor(Color("ColorSamples"))
                    
                    
                    //Below is locally adaptive using @Enviroment variable
                    
                    Text("This is locally adaptive").foregroundColor(colorScheme == .light ? .green:.yellow)
                }
            }
        }.navigationTitle("DarkMode Views")
    }
}

struct DarkMode_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DarkMode_Views()
                .preferredColorScheme(.light)
        }
        NavigationStack {
            DarkMode_Views()
                .preferredColorScheme(.dark)
        }
    }
}
