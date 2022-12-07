import SwiftUI

struct TextField_Styles: View {
    
    @State var textFieldText: String = ""
    
    @State var dataArray:[String] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                //MARK: TextField
                
                TextField("Type something...", text: $textFieldText)
                    .padding()
                   // .textFieldStyle(.roundedBorder)
                    .background(Color.gray.opacity(0.3).cornerRadius(10))
                    .foregroundColor(.red)
                .font(.headline)
                
                //Adding button to save some fake data
                Button {
                    //Creating a conditional logic to determine if a text is an appropriate length
                    if textIsAppropriate() {
                        
                        //saving the data that is coming from the user and getting passed into dataArray
                        saveText()
                    }
                    
                  
                } label: {
                    Text("Save".uppercased())
              
                .padding()
                .frame(maxWidth: .infinity)
               // .textFieldStyle(.roundedBorder)
                .background( textIsAppropriate() ?  Color.blue.cornerRadius(10) :Color.gray.cornerRadius(10) )
                .foregroundColor(.white)
            .font(.headline)
                }
                //Adding a disable button with a boolean function that we created to disable the button from being pressed if our logic is false
                .disabled(!textIsAppropriate())
                
                ForEach(dataArray, id:\.self) {
                    data in
                    Text(data)
                }
                
                Spacer()
            }
        }.padding()
            .navigationTitle("TextField Text")
    }
    
    //MARK: Functions
    func textIsAppropriate() -> Bool  {
        //Check Text Input from User
        
        if textFieldText.count >= 3 {
            return true
        }
        
        return false
    }
    
    func saveText() {
        dataArray.append(textFieldText)
        textFieldText = ""
    }
}

struct TextField_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TextField_Styles()
        }
    }
}
