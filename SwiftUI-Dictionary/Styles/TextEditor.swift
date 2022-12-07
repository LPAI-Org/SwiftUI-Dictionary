

import SwiftUI

struct TextEditor_Styles: View {
    
    @State var textEditorText: String = "Enter some text here"
    
    @State var savedText: String = ""
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                //MARK: Text Editor
                TextEditor(text: $textEditorText)
                    .frame(height: 250)
                    .foregroundColor(.green)
                    .cornerRadius(10)
                //adding the text editor you can see it takes a natural height and width of infinity in order to take in as much text on screen as possible but the space is mutable by adding a frame with height and width.
           
                
                Button(action: {
                    
                    savedText = textEditorText
                    textEditorText = ""
                    
                }, label: {
                    Text("Save".uppercased())
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(10)
                })
                
                Text(savedText)
                Spacer()
                
            }
            
            Spacer()
            Spacer()

        }.padding()
            .background(.green)
            .navigationTitle("Text Editor")
    }
}

struct TextEditor_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TextEditor_Styles()
        }
    }
}
