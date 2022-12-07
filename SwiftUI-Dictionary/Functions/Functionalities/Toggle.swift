import SwiftUI

struct Toggle_Function: View {
    
    @State var toggleIsOn: Bool = false
    
    var body: some View {
        //MARK: Toggle Example
        VStack {
            HStack {
                Text("Status")
                Text(toggleIsOn ? "online" : "offline")
            }
            Toggle("Is True", isOn: $toggleIsOn)
                //changing the toggle color, you use the tint modifier and pass in your desired color
                .tint(.purple)
            .padding()
            Spacer()

        }.padding(.horizontal, 100)
    }
}

struct Toggle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle_Function()
    }
}
