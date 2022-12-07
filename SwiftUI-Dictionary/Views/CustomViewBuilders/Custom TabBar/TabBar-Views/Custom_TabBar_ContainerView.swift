import SwiftUI

struct Custom_TabBar_ContainerView<Content: View>:
    View {
    
    let content: Content
    @Binding var selection: TabBarItem
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        //The underscore for selection defines that this is a binding variable
        self._selection = selection
        self.content = content()
    }
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content.ignoresSafeArea()
            Custom_TabBarView(tabs: tabs, selection: $selection, localSelection: selection)

        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
            self.tabs = value
        }
        
    }
}

struct Custom_TabBar_ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        
        let tabs: [TabBarItem] = [ .home, .favorites, .profile
        ]
        
        Custom_TabBar_ContainerView(selection: .constant(tabs.first!)) {
            Color.red
        }
    }
}
