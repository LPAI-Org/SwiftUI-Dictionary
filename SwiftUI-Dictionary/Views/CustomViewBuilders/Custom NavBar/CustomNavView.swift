import SwiftUI

//MARK: Generic View
struct CustomNavView<Content:View>: View {
    
    let content: Content
    
    //MARK: @Viewbuilder initializer
    ///accepting the generic data from <Content:View> and passing it into the property 'content'
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        //Having the default NavigationView in our CustomNavView it allows us to leverage the performance benefits of apples built in NavigationView on our Custom Nav View. Basically hoisting the functionality behind the screen/scene of our AppNavBarView. 
        NavigationView {
            //Here we are calling CustomNavBar_ContainerView and passing in the 'content' that is coming into this struct within the Custom ContainerView that we created. Therefore, marrying these two views into one.
            CustomNavBar_ContainerView {
                content
            }
            //Removing the built in navigation bar so we can overlay our own CustomNavBarView.
            .navigationBarHidden(true)
        }
        //StackNavigationViewStyle() creates the sane regular navigation stack.
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CustomNavView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView(content: {
            Color.red.ignoresSafeArea()
        })
    }
}

//MARK: Swipe back action controller
///The extension below allows the user to slide back on the screen the same way apple's NavigationView allows us to swipe. By default when creating the custom navigation bar this would be removed because its hidden behind the screens but if you create the extension for UINavigationController, you can overwrite it and bring it back to the surface for the user to swipe as well. This gets initialized upon load, hence the viewDidLoad modifier, therefore you don't need to call viewDidLoad() on each screen in order for it to work.
extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
