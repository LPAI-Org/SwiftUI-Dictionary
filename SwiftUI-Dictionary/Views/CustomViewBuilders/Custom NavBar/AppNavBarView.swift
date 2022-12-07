import SwiftUI

struct AppNavBarView: View {
    var body: some View {
        
        
        //MARK: Custom Navigation View
        CustomNavView {
            ZStack {
                Color.orange.ignoresSafeArea()
                //MARK: Custom Navigation Link
                CustomNavLink(destination: {
                   
                    //MARK: Custom Navigation Title
                    ///Adding a custom title for the second screen by passing the data below
                    Text("Second Screen - View")
                        .customNavigationTitle("Second Screen")
                    
                    
                    //MARK: Custom Navigation Subtitle
                    ///Adding a custom subTitle for the second screen *** You will notice that we are not calling customNavBarItems -> backButtonHidden.*** Because we want to show the backButton which is set as false by default.
                        .customNavigationSubTitle("Subtitle")
                }, label: {
                    Text("Navigation")
                })
                    
                }
            
            //MARK: Custom Navigation Bar-Items (Data)
            ///CustomNavBarItems displays the header information on the current screen
                .customNavBarItems(title: "New Title", subtitle: "SubTitle", backButtonHidden: true)
            }
        }
    }

//Below is a reference view to replicate in a custom view
//extension AppNavBarView {
//    private var defaultNavView: some View {
//
//        NavigationView {
//
//            ZStack {
//                NavigationLink(
//                    destination:
//                        Text("Destination")
//                        .navigationTitle("Title 2")
//                        .navigationBarBackButtonHidden(false)
//                    ,
//                    label: {
//                    Text("Navigate")
//
//                })
//
//            }
//            .navigationTitle("Title here")
//
//        }
//    }
//}

struct AppNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppNavBarView()
    }
}
