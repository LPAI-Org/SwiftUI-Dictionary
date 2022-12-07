import SwiftUI

struct IntroView: View {
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {
        ZStack {
            //background
            
            RadialGradient(gradient: Gradient(
                colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))]), center: .center,
                    startRadius: 5,
                           endRadius: UIScreen.main.bounds.height)
            .ignoresSafeArea()
            
            if currentUserSignedIn {
                ProfileView()
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
            }
            else {
               onBoardingView()
                    .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
            }
            
            
   
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
