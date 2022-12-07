import SwiftUI

struct TextStyles: View {
    
    var text: String = "Hello, world! I am here to figure out how this whole thing is going to work and essentially, try to center this text in a more appropriate format."
    
    var body: some View {
        Text(text.capitalized).font(.body)
            .italic()
            .bold()
            //.underline()
            //.strikethrough()
            .baselineOffset(10.0) // separating the spacing between lines
            .multilineTextAlignment(.leading) // this is the text format within the box
            .kerning(1) // this is the spacing between characters
            .foregroundColor(.blue)
            .frame(width: 300, height: 400)

    }
}

struct TextStyles_Previews: PreviewProvider {
    static var previews: some View {
        TextStyles()
    }
}
