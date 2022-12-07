import SwiftUI

struct Markup_and_Documentation: View {
    
    //MARK: Properties
    
    @State var data: [String] = [
        "apple", "oranges", "bananas"
    ]
    
    @State var showAlert: Bool = false
    
    var body: some View {
    
    //MARK: Body
        
        //Regular comment in a code with double slash
    
        //NAME-HERE: On large projects with multi coders, we write our name who wrote the comment.
        
        /*
         Another way to write your comment with a backslash & star inside both backlashes. Now we can write on multiple lines....
         another line here....
         and here.
         */
        
        NavigationStack { //START: NAV
            
            ListView(data: $data) //LIST VIEW
            
        }//END: NAV
        .navigationTitle("Documentation & Markups")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Alert") {
                        showAlert.toggle()
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                getAlert(text: "This is an alert!")
            }
    }
    
    //MARK: Functions
   
    /*
     If you hold the cmd + click on the function name, you get a selection called "Add Documentation" which will add the three comments below for you automatically
     */
    
    /// Gets an alert with a specified title
    ///Below is a three added lines that we hit entered three times to add a discussion as per the following:
    ///
    ///
    /// This function creates and returns an immediate alert with a title that we will pass into the parameter.
    /// Below is a code that we can add into a comment by adding the three quote mark that is next to your keyboard number 1 with the squiggly line
    ///```
    ///getAlert(text: "Hi!") -> Alert {
    /// return Alert(title: Text("Hi!"))
    /// }
    ///```
    ///
    /// - Warning: There is no additional message in this Alert.
    /// - Parameter text: This is the title for the alert.
    /// - Returns: Returns an alert with a title
    func getAlert(text: String) -> Alert {
        return Alert(title: Text(text))
    }
}

    //MARK: Previews

struct Markup_and_Documentation_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Markup_and_Documentation()
        }
    }
}

//MARK: LISTVIEW

///This is a summary comment, so that another developer holds the 'option key' and clicks on a view/property/function they would see this message. I.e. This view holds  list view.
struct ListView: View {
    
    @Binding var data: [String]
    var body: some View {
        List  {  //START: LIST
            ForEach(data, id: \.self) {
                Text($0)
                
            }.onDelete(perform: delete)
        }
    }
    func delete(index: IndexSet) {
        data.remove(atOffsets: index)
    }
}
