import SwiftUI
///What we will use in this demo
//Generics
//ViewBuilder
//PreferenceKey
//MatchGeometryEffect

struct TabBarView: View {
    
    @State private var selection: String = "Home"
    
    @State private var tabSelection: TabBarItem =  .home
    
    var body: some View {
        Custom_TabBar_ContainerView(selection: $tabSelection) {
            
            Color.purple
                .tabBarItem(tab: .messages, selection: $tabSelection)
            
            Color.red
                .tabBarItem(tab: .home, selection: $tabSelection)
         
            
            Color.blue
                .tabBarItem(tab: .favorites, selection: $tabSelection)
            
            Color.green
                .tabBarItem(tab: .profile, selection: $tabSelection)

        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        TabBarView()
    }
}


extension TabBarView {
    private var defaultTabView: some View {
        TabView(selection: $selection) {
            Color.red
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            Color.blue
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
            
            Color.orange
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}
