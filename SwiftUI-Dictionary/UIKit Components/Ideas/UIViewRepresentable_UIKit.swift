import SwiftUI

struct UI_ViewRepresentable_UIKit: View {
    
    @State private var text: String = ""
    
    var body: some View {
        
        
        VStack {
            Spacer()
            Text(text).font(.largeTitle)
                .foregroundColor(.purple)
            HStack {
                Text("SwiftUI:")
                TextField("Type here...", text: $text)
                    .frame(height: 55)
                    .background(.gray)
            }
           
      
            HStack {
                Text("UIKit: ")
                UI_TextField_ViewRepresentable(text: $text, placeholder: "Tell me why again...", placeholderColor: .white)
                    .frame(height: 55)
                    .background(.gray)
            }
            HStack {
                Text("UIKit #2: ")
                UI_TextField_ViewRepresentable(text: $text)
                    .updatePlaceHolder("Hello")
                    .frame(height: 55)
                    .background(.gray)
            }
            
            Spacer()
        }
    }
}

struct UIView_Representable_UIKit_Previews: PreviewProvider {
    static var previews: some View {
        UI_ViewRepresentable_UIKit()
    }
}


struct UI_TextField_ViewRepresentable: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    let placeholderColor: UIColor
    
    init(text: Binding<String>, placeholder: String = "Default placeholder...", placeholderColor: UIColor = .tintColor) {
        self._text = text
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
    }
    
    /* We changed the output from 'some View' to 'UITextField' because we know for sure that is the only output and UITextField is a form of a view itself.*/
    
    //From UIKit to-> SwiftUI
    func makeUIView(context: Context) -> UITextField {
        //as the name suggests make UI-View, by taking getTextField() getting the context.coordinator to be delegated (not sure if I got this right...)
        //To use .delegate, we needed to add UITextFieldDelegate to our Coordinator class below. That is why UITextFieldDelegate provided us with the .delegate option to use in our textfield property.
        let textfield = getTExtField()
        //I think this coordinator is coordinating the data  coming in to the delegator so it can delegate our data onto the placeholder
        textfield.delegate = context.coordinator
        return textfield
    }
    
    /* We called updateUIView after we changed the output in makeUIView from 'some View' to 'UITextField', which made the auto complete of updateUIView provide the uiView: UITextField property as a default.*/
    
    //From SwiftUI to-> UIKit
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }

    
    private func getTExtField() ->UITextField {
        let textfield = UITextField(frame: .zero)
        
        ///Previous version
//        let placeholder = NSAttributedString(string: "Type here...", attributes: [
//            .foregroundColor : UIColor.white
//        ])
        
        ///Current Version passing in the properties placeholder & placeholderColor instead
        let placeholder = NSAttributedString(string: placeholder, attributes: [
            .foregroundColor : placeholderColor
        ])
        
        textfield.attributedPlaceholder = placeholder
//        textfield.delegate
        return textfield
    }
    
    //Creates the custom instance that you use to communicate changes from your view to other parts of your SwiftUI interface
    func makeCoordinator() -> Coordinator {
        //requires to have the binding property connect to this coordinator
        return Coordinator(text: $text)
    }
    
//We created a function just to take in a text as string, the output is our main struct view UI_TextField_ViewRepresentable and we are passing 'self' which is the struct the function is in (UI_TextField_ViewRepresentable) so that we can obtain placeholder and pass the texts that is coming in into it and returning the output
    //this almost acts like an extension of a property because we could have called UI_TextField_ViewRepresentable and passed in the Text for the placeholder but instead creating this function you can call on it like a modifier within the struct that this is designed to output the data to. The difference is that this would only work for one struct at a time while extensions can be more versatile on where you can use it. 
    func updatePlaceHolder(_ text: String)  -> UI_TextField_ViewRepresentable {
        var viewRepresentable = self
        viewRepresentable.placeholder = text
        return viewRepresentable
    }
    
    
    //This class is only used in this struct so its added in here. Otherwise it would have been set outside of a struct to be used globally.
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        
        //we need to initialize the class in order for the text to bind with what is coming in
        init(text: Binding<String>) {
            //The underscore before text is the same as money sign when it comes to binding to properties. _text is the same as $text.
            self._text = text
        }
        
        
        //by typing textFieldDidChangeSelection, we get the auto complete of this function, it basically acts as a custodian to a placeholder of what is being passed into it. In our case, its a text, so we called textField.text which is an optional so we give it an empty string. Otherwise pass in the text that is coming in into 'text' property from textField.
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}

//Another view that is not used but created as a demonstration
struct Basic_View_Representable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        
        view.backgroundColor = .purple
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
}
