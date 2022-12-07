import SwiftUI

struct TextSelection_Function: View {
    var body: some View {
        Text("Hold for two second over this text to pop up the selection")
        //MARK: Text Selection
            .textSelection(.enabled)
        //This enables you to hold the text and a pop up will show up for copy/share
    }
}

struct TextSelection_Previews: PreviewProvider {
    static var previews: some View {
        TextSelection_Function()
    }
}
