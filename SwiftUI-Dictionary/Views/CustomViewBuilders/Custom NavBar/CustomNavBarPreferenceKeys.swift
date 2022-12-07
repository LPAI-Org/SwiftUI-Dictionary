import Foundation
import SwiftUI

//MARK: PreferenceKeys
///Creating a PreferenceKey for all of our data that we want to customize on each screen. Example, when you click on the main screen that has a navigation title / subtitle, the next screen should update the title / subtitle to the second screens information
///Apple uses PreferenceKey's on their own Navigation Views that allows us to update the title on each screen. Therefore, we will mimic the same process by creating a PreferenceKey for Title, SubTitle and whether to show/notShow the backButton.
///
///
struct CustomNavBarTitlePreferenceKey: PreferenceKey {
    //Each PreferenceKey takes in a defaultValue of whatever type you assign to it.
    static var defaultValue: String = ""
    
    //Then we use the reduce function below to pass in the value that is coming in for the title
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}


struct CustomNavBarSubtitlePreferenceKey: PreferenceKey {
    
    //defaultValue taking an optional String
    static var defaultValue: String? = nil
    
    //using the function below to pass in the newValue that is coming in into the value property
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = nextValue()
    }
}

struct CustomNavBarBackButtonHiddenPreferenceKey: PreferenceKey {
    
    //defaultValue taking a Boolean this type
    static var defaultValue: Bool = false
    
    //reducing it by taking the boolean value from nextValue and passing it into value
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

//MARK: PreferenceKey Extensions
///Here we create a view extension to use the PreferenceKeys above
extension View {
    
    // customNavigationTitle takes the string within Title and returns the text on the on the screen by calling the preference modifier and passing in the CustomNavBarTitlePreferenceKey we created above. We repeat this step for each PreferenceKey below for SubTitle and BackButton.
    func customNavigationTitle(_ title: String) -> some View {
        preference(key: CustomNavBarTitlePreferenceKey.self, value: title)
    }
    
    func customNavigationSubTitle(_ subtitle: String?) -> some View {
        preference(key: CustomNavBarSubtitlePreferenceKey.self, value: subtitle)
    }
    
    func customNavigationBackButtonHidden(_ hidden: Bool) -> some View {
        preference(key: CustomNavBarBackButtonHiddenPreferenceKey.self, value: hidden)
    }
    
    //This function concatenates all three above for us to use when calling the extension. You basically want one function that you can use for all three instead of calling each one by one which can make your code very ugly.
    /// customNavBarItems takes the Title, SubTitle, and BackButton into one function.
    func customNavBarItems(title: String = "" , subtitle: String? = nil, backButtonHidden: Bool = false) -> some View {
        
        //Calling each function we created above as self and passing in the properties of customNavBarItems into each function, thus linking them all together into one. Example, customNavigationTitle function taking the title property created for customNavBarItems.
        self
            .customNavigationTitle(title)
            .customNavigationSubTitle(subtitle)
            .customNavigationBackButtonHidden(backButtonHidden)
    }
    
}
