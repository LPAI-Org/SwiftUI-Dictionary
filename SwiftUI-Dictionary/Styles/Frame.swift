import SwiftUI

struct Frame_Styling: View {
    var body: some View {
        
        //adding different frames after before each background allows you to create different flex boxes that you might be used to with CSS. The alignment forces the element within each object to conform to the position passed in while you can add width, height, maxWidth, maxHeight, minWidth, or minHeight with .infinity or custom value to stretch or shrink an element
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .frame(height: 100, alignment: .top)
            //.frame(height: 100, alignment: .center)
            .background(.blue)
            .frame(width: 150)
            .background(.orange)
            //.frame(maxWidth: .infinity, alignment: .leading)
            .frame(maxWidth: .infinity)
            .background(.pink)
            .frame(height: 400)
            .background(.green)
            .frame(maxHeight: .infinity, alignment: .center)
           // .frame(maxHeight: .infinity, alignment: .top)
            .background(.yellow)
            .foregroundColor(.white)
    }
}

struct Frame_Styling_Previews: PreviewProvider {
    static var previews: some View {
        Frame_Styling()
    }
}
