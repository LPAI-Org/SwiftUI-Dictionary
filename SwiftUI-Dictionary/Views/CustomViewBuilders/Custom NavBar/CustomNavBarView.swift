import SwiftUI

struct CustomNavBarView: View {
    //MARK: PresentationMode
    //created to allow the use to hit the back button and return to the previous screen
    @Environment(\.presentationMode) var presentationMode
    
    //MARK: EMPTY PROPERTIES
    ///when creating a customNavBarView, you will be passing the data below to create the view
    let showBackButton: Bool
    let title: String
    let subtitle: String?
    
    var body: some View {
        HStack {
            //If showBackButton is set to true, show back button: otherwise hide it.
            if showBackButton {
                backButton
            }
            
            Spacer()
            //backButton & titleSection come from the extension below
            titleSection
            
            Spacer()
            //The button below is hidden whether the boolean condition is true or false because we are using it as a placeholder to center the 'title' and 'subtitle' on our screen. Basically its used to align the text only and not meant to do anything else. 
            
            if showBackButton {
                backButton
                    .opacity(0)
            }
        }
        .padding()
        .accentColor(.white)
        .foregroundColor(.white)
        .font(.headline)
        .background(Color.blue.ignoresSafeArea(edges: .top))
    }
}

//MARK: EXTENSION - View
extension CustomNavBarView {
    //Button represents the icon on the header to allow the user to click back
    private var backButton: some View {
        
        Button(action: {
            //PresentationMode used for going back to the previous screen
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
        })
    }
    //Title of the navigation bar
    private var  titleSection: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
            //Since subtitle is optional, we are unwrapping it by using if-let statement. If the subtitle is not nil, show it.
            if let subtitle {
                Text(subtitle)
            }
        }
    }
}

struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            //MARK: Dummy Data to test on preview
            CustomNavBarView(showBackButton: true, title: "Title here", subtitle: "Subtitle here")
            Spacer()
        }
    }
}
