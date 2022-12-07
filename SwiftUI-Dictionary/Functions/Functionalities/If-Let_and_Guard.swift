import SwiftUI

struct If_Let_and_Guard: View {

    
    //MARK: Loading indicator boolean
    @State var loadingIndicator: Bool = false
    
    //MARK: Optional String
    @State var displayText:String? = nil
    @State var currentUserID: String? = nil

    
    var body: some View {
        NavigationStack {
            
            VStack {
                
                //MARK: Best Practice
                ///Correct way by force unwrapping
                //Text(displayText ?? "")
                ///Incorrect way of force unwrapping
                //Text(displayText!)
                
                
                Text("Here we are practicing safe coding")
                //MARK: IF-LET protocol
                //Since displayText is set to be an optional with the question-mark after the String protocol, we need to unwrap the variable if we want to use it by calling a 'if-let' and passing the displayText into a new variable called 'text'. This will only accept data once displayText has something to provide, otherwise it will be set to nil or false.
                if let text = displayText {
                    Text(text).font(.headline)
                }
                
                //MARK: Loading indicator
                //loading indicator boolean is added to show the loading indicator if the boolean is true, otherwise remove.
                if loadingIndicator {
                    ProgressView()
                }
                
                Spacer()
            }
            
        }
        .navigationTitle("Safe Coding")
        .onAppear {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                

                ///currentUserID will pass in a fake ID if you uncomment it.
                //currentUserID = "MarkyMark"
                
                ///Below you can test each scenario by uncommenting loadData or loadGuarData, do not use both as they will conflict with each other.

               // loadData()
                loadGuardData()
            })
         
        }
    }
    
    //MARK: Guard-Let Function
    
    func loadGuardData() {
        loadingIndicator = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            //Adding the guard-let within a dispatchQueue of a delayed 1 second to allow the indicator to show up for at least a second before we remove it below.
            guard let userID = currentUserID else {
                displayText = "Error. There is no User ID"
                return loadingIndicator = false
            }
            //guard let is a boolean conditional, it is basically asking if currentUserID has a value, pass it into userID and running the code within the else statement `below`. Otherwise, run the displayText = "Error. There is no User ID" in the code `above`.
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                //Displaying the text & remove the loading indicator by setting the boolean to false
                displayText = "This is the new data for \(userID)"
                loadingIndicator = false
            })
        })
  
    }
    
    //MARK: If-LET Function
    func loadData() {
        
        if let userID = currentUserID {
            //loading indicator is set to true before dispatchQueue is called in order to display the loading indicator until the process on dispatchQueue is completed
           
            loadingIndicator = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                //Displaying the text & remove the loading indicator by setting the boolean to false
                displayText = "This is the new data for \(userID)"
                loadingIndicator = false
            })
        } else {
            displayText = "There is no userID"
        }
        

        
       
    }
}

struct If_Let_and_Guard_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            If_Let_and_Guard()
        }
    }
}
