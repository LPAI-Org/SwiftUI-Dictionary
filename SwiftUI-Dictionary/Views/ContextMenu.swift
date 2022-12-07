//This is a button that would show a pop up once you hold it down for a few seconds

import SwiftUI

struct ContextMenu_View: View {
    
    
    @State var backgroundColor:Color = .purple
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: "house.fill")
                .font(.title)
            Text("ContextMenu Ideas")
                .font(.headline)
            Text("How to use Context Menu")
                .font(.subheadline)
        }
        .foregroundColor(.white)
        .padding()
        .background(backgroundColor)
        .cornerRadius(10)
        
        //MARK: Context Menu
        .contextMenu {
            
            //Adding three buttons into ContextMenu pop taking  three different ways a label. The function of changing color is a place holder on what you can pass in.
            
            Button {
                backgroundColor = .yellow
            } label: {
                Label("Button 1", systemImage: "flame.fill")
            }
        
            Button {
                backgroundColor = .red
            } label: {
                Text("Report Post")
            }

            Button {
                backgroundColor = .green
            } label: {
                HStack {
                    Text("Like Post")
                    Image(systemName: "heart.fill")
                }
            }


            
        }
    }
}

struct ContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenu_View()
    }
}
