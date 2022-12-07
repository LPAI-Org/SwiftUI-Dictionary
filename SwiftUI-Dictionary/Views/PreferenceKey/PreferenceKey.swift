import SwiftUI

struct PreferenceKey_Views: View {
    
    @State private var text: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                //MARK: Parent View
                SecondViewPreferenceKey(text: text)
                    .navigationTitle("Nav Title")
            }
        }//to use the custom title struct that we just created, we need to add it to the onPreferenceChange where navigationTitle would have gone.
        //CustomTitlePreferenceKey.self will take in the string value that gets passed into it and pushes the data into @State text property
        //Here we are getting the CustomTitlePreferenceKey which takes in a string and outputs a string that we are getting from SecondViewPreferenceKey struct view
        .onPreferenceChange(CustomTitlePreferenceKey.self) { value in
            ///here we are taking the data obtained from SecondViewPreferenceKey that gets pushed into newValue of SecondViewPreferenceKey below but we're grabbing that data and passing it back into our text property of this parent struct which will result it to display on the main screen what SecondViewPreferenceKey has to provide within two seconds of load time
            self.text = value
        }
    }
}

/*------------------------------------------------------*/

//Extension allows us to use customTitle as a modifier for more cleaner code readability
extension View {
    func customTitle(text: String) -> some View {
         preference(key: CustomTitlePreferenceKey.self, value: text)
    }
}

/*------------------------------------------------------*/



struct SecondViewPreferenceKey: View {
    
    let text: String
    @State private var newValue: String = ""
    
    var body: some View {
        //MARK: Child View
        //Text property above gets passed into the Text() for the parent struct (PreferenceKey_Views) to pass data into it
        Text(text)
        //onAppear will get the data needed for the modifier customTitle
            .onAppear(perform: getData)
        ///taking newValue and passing into our extension that we created above
            .customTitle(text: newValue)
    }
    
    func getData() {
        //passing new data into newValue property after two seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.newValue = "New Title"
        })
        
    }
}


struct CustomTitlePreferenceKey: PreferenceKey {
    // defaultValue gets added automatically by Xcode when you create a PreferenceKey struct which will hold the data that you're obtaining from reduce.
    static var defaultValue: String = ""
    //type reduce to get the code completion
    static func reduce(value: inout String, nextValue: () -> String) {
        //you take 'nextValue' and pass it into 'value' to initialize it but you need to add the brackets after nextValue for it to work.
        value = nextValue()
    }
}



/*------------------------------------------------------*/


struct PreferenceKey_Previews: PreviewProvider {
    static var previews: some View {
      //  NavigationView {
            PreferenceKey_Views()
      //  }
    }
}
