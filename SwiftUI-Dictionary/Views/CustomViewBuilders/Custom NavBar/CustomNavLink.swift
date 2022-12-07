import SwiftUI
/*
 The standard NavigationLink is render as per the following:
 
---> struct NavigationLink<Label, Destination> where Label : View, Destination : View  <---
 
 the struct below will do the same as the above, written in a better format.
 
 Instead of calling "where Label : View, Destination : View", you pass in the generics as
 
 ---->  <Label:View, Destination: View> : View    <----
 
 This will allow us to call on CustomNavLink and pass in the destination + label the same way we would on NavigationLink
 
 */


struct CustomNavLink<Label:View, Destination: View> : View {
    
    let destination: Destination
    let label: Label
    
    /*
     We copied the same init() below that comes with NavigationLink as a standard if you look at the documentation of NavigationLink you will see the following:
     
     public init(@ViewBuilder destination: () -> Destination, @ViewBuilder label: () -> Label)
     
     */
    
    init(@ViewBuilder destination: () -> Destination, @ViewBuilder label: () -> Label) {
        
        self.destination = destination()
        self.label = label()
        
    }
    
    var body: some View {
        
        NavigationLink(destination: {
            //Connecting CustomNavBar_Container with destination so that when you click on the destination, you have the ability to add another view on the next screen which in our case will be 'destination' This will allow us to keep our navBarView at the top on each screen that you slide into. Without CustomNavBar_ContainerView you wont see the header CustomNavBar at the top
            CustomNavBar_ContainerView {
                destination
            }
            //Forcing the regular navBar to be hidden so we can show our own CustomNavBar.
            .navigationBarHidden(true)
        }, label: {
            label
        })
    }
}

struct CustomNavLink_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView {
            CustomNavLink(destination: {
                Text("Destination")
            }, label: {
                Text("Click Me")
            })
        }

    }
}
