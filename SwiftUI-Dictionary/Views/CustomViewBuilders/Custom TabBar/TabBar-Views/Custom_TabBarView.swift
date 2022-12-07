import SwiftUI

struct Custom_TabBarView: View {
    //MARK: Properties
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @Namespace private var namespace
    
    @State var localSelection: TabBarItem

    var body: some View {
        tabBarVersion2
            .onChange(of: selection) { newValue in
                withAnimation(.easeInOut) {
                    localSelection = newValue
                }
            }
    }
}


//MARK: Extension
extension Custom_TabBarView {
    
    private  func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(localSelection == tab ? tab.color: .gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(localSelection == tab ? tab.color.opacity(0.2) : .clear)
        .cornerRadius(10)
    }
    
    private var tabBarVersion1: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges: .bottom))
    }
    
    private func switchToTab(tab: TabBarItem) {
       // withAnimation(.easeInOut) {
            selection = tab
       // }
    }
}

extension Custom_TabBarView {
    private  func tabView2(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(localSelection == tab ? tab.color: .gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if localSelection == tab {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tab.color.opacity(0.2))
                        .matchedGeometryEffect(id: "background_rectangle", in: namespace)
                }
            }
        )
    }
    
    private var tabBarVersion2: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView2(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges: .bottom))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
}

//MARK: Previews
struct Custom_TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        //Fake Data Array for Preview
        let tabs: [TabBarItem] = [ .favorites, .profile, .home
        ]
        
        VStack {
            Spacer()
            Custom_TabBarView(tabs: tabs, selection: .constant(tabs.first!), localSelection: tabs.first!)
        }
    }
}
