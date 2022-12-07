import SwiftUI

struct OnSubmit_and_SubmitLabel: View {
    
    @State private var text: String = ""
    var body: some View {
        VStack {
            
            //MARK: Submit Label
            /// adding  a submitLabel it allows us to change the button the keyboard that would either imply return by default changed to route, search, next and many more.
            TextField("PlaceHolder", text: $text)
                .submitLabel(.route)
            
            TextField("PlaceHolder", text: $text)
                .submitLabel(.search)
            
            TextField("PlaceHolder", text: $text)
                .submitLabel(.next)
            
            //Combine it with onSubmit and the button will perform the action of your choice
        }
    }
}

struct OnSubmit_and_SubmitLabel_Previews: PreviewProvider {
    static var previews: some View {
        OnSubmit_and_SubmitLabel()
    }
}
