import SwiftUI

struct TabView_Views: View {
    
    @State var selectedTab: Int = 2
    
    let icons:[String] = [
        "heart.fill",
        "globe",
        "house",
        "person"
    ]
    var body: some View {
        //MARK: TabView Looping
        //this tabView icons at the bottom are not showing up but the tabview with PageTabViewStyle formats the tabView into a slider
        TabView {
            ForEach(icons, id: \.self) {
                icon in
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
            }.background(RadialGradient(gradient: Gradient(colors: [.blue, .purple]), center: .center, startRadius: 5, endRadius: 300))
        }.tabViewStyle(PageTabViewStyle())
        
        
        //MARK: TabViews Slider
        
//        TabView(selection: $selectedTab) {
//            RoundedRectangle(cornerRadius: 10).fill(.red).tag(0)
//            RoundedRectangle(cornerRadius: 10).fill(.green).tag(1)
//            RoundedRectangle(cornerRadius: 10).fill(.blue).tag(2)
//        }
//        .tabViewStyle(PageTabViewStyle())
//        .frame(height: 300)
  
        //MARK: TabViews
        
//        TabView(selection: $selectedTab) {
//
//            //MARK: Tab Items
//
//            //creating an extracted view with tab item
//            HomeView(selectedTab: $selectedTab)
//                .tabItem {
//                    Text("Home")
//                    Image(systemName: "house")
//                }.tag(0)
//
//            //creating a simple text's tab item
//            Text("Browse Tab")
//                .tabItem {
//                    Text("Browse")
//                    Image(systemName: "globe")
//                }.tag(1)
//
//            Text("Profile Tab")
//                .tabItem {
//                    Text("Profile")
//                    Image(systemName: "person")
//                }.tag(2)
//        }.tint(.green)
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView_Views()
    }
}

struct HomeView: View {
    
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
            VStack {
                Text("Home Tab").font(.largeTitle).foregroundColor(.white)
                Button {
                    selectedTab = 2
                } label: {
                    Text("GO to Profile")
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                }

                }
            }
        }
    }
