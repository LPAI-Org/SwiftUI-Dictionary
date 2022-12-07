import Foundation
import SwiftUI


struct TabBarItemsPreferenceKey: PreferenceKey {
    static var defaultValue: [TabBarItem] = []
    
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        //Here we are using the += because we're appending to the preference key and not just changing it
        value += nextValue()
    }
}


struct TabBarItemViewModifier:ViewModifier {
    
    let tab: TabBarItem
    @Binding var selection: TabBarItem
    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1.0 : 0.0)
            .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
    }
}

//Here when we call the tabBarItem modifier moving forward in our views thanks the the extension below, it will call the TabBarItemViewModifier which will pass in the TabBarItem as an array preferencekey within TabBarItemsPreferenceKey

extension View {
    func tabBarItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
        
        self.modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
}
