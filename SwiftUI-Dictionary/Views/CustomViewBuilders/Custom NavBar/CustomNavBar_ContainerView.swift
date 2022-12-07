import SwiftUI

///Container View is the part that is below the navigation bar to display the content of what you want the user to see when they click through the navigation links. This will be the container to hold those views.
///
//MARK: Generic Struct : View Type
struct CustomNavBar_ContainerView<Content:View>: View {
    
    let content: Content
    
    //MARK: PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @State private var showBackButton: Bool = true
    @State private var title: String = ""
    @State private var subtitle: String? = nil
    
    //MARK: ViewBuilder Initializer
    //The @ViewBuilder initializer will allow us to call on CustomNavBar_ContainerView and be able to pass in any View to this struct. This is called *Generics*
    //The property below is taking a property called content and accepting a temp void Content Generic that we created on the "CustomNavBar_ContainerView" above. Then we are connecting these two together so that the property can accept views getting passed into it by creating a property called 'content' that is accepting the generic Content we have above and ()-> implies it is a function that accepts content but can be void too. Then we are implying that self.content = Content() is taking whatever View is getting passed into it within itself.
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            //Here we are importing the CustomNavBar that we created and passing in the properties from our @State above
            
            CustomNavBarView(showBackButton: showBackButton, title: title, subtitle: subtitle)
            
            
            //MARK: Custom Content
            ///Here we are taking the custom content we have created in our initializer above and giving it a frame of width & height of infinity so it covers the remaining area of the screen below the custom nav bar above.
            ///In laymen terms we are saying, whatever view that this container eventually gets passed into, show it in here.
            content.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        //MARK: PreferenceKey initializer - onPreferenceChange
        ///The PreferenceKeys that we created for Title, SubTitle and BackButton can only be used where we call onPreferenceChange and pass in the PreferenceKey that we want to initialize. It works like a ForEach loop, where it grabs whatever data it is getting passed in **(there could be a lot of data since each screen will pass in their own, therefore it acts like an array which we need to loop through)** we have in our PreferenceKey and passing it into the @State property we created on this struct above.
        ///This allows the data to be unique on each destination view that we are creating so that the NavigationBar title, subtitle and backButton that is unique for each screen.
        .onPreferenceChange(CustomNavBarTitlePreferenceKey.self, perform: {
            value in
            self.title = value
        })
        .onPreferenceChange(CustomNavBarSubtitlePreferenceKey.self, perform: {
            value in
            self.subtitle = value
        })
        
        .onPreferenceChange(CustomNavBarBackButtonHiddenPreferenceKey.self, perform: {
            value in
            //adding the value as !value to indicate the backButton is already by default true, and this makes it become false. So if the user wants to use the backButton, he will need to pass in true value to show the backButton.
            ///Otherwise, it will be confusing to other programmers if they call CustomNavBar_ContainerView and the value of backButtonHidden by default is true. In pure english, your property "backButtonHidden on customNavBarItems" is asking the question "should we hide it?" and if the coder types "true" and it shows it instead, it would be very confusion. THEREFORE WE FORCE IT TO BE FALSE FROM THE BEGINNING. 
            self.showBackButton = !value
        })
    }
}

struct CustomNavBar_ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        
        //MARK: Example Preview of CustomNavBar_ContainerView
        CustomNavBar_ContainerView(content: {
            ZStack {
                Color.green.ignoresSafeArea(edges: .bottom)
                
                Text("Hello, WORLD!")
                    .foregroundColor(.white)
                    .customNavigationTitle("New Title")
                    .customNavigationSubTitle("Subtitle")
                    .customNavigationBackButtonHidden(false)

            }
        })

    }
}
