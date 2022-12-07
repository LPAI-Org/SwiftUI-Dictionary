import SwiftUI

struct Navigation_View_Link: View {
    var body: some View {
        
        //MARK: NavigationView
        NavigationView {
            ScrollView {
                //MARK: NavigationLink
                //Adding a navigation link to where you want the user to go. Below, we are using a second screen for the user to transition
                NavigationLink("Hello. World!!!") {
                    MyOtherScreen()
                }
                
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Text("Hello, World!")
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
        }.navigationTitle("Navigation Fun")
            .navigationBarTitleDisplayMode(.inline)
        //NavigationBarItems is replaced with Toolbar moving forward
            .navigationBarItems(leading: Image(systemName: "gear"), trailing: Image(systemName: "person"))
    }
}

struct MyOtherScreen: View {
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            VStack {
                Text("New Word Order").foregroundColor(.white)
                    .navigationTitle("NWO").padding()
                Button("Dismiss", role: .destructive) {
                    dismiss()
                }.padding().background(.white).frame(width: 100, height: 50).cornerRadius(10)
            }
        }
    }
}

struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Navigation_View_Link()
        }
    }
}
