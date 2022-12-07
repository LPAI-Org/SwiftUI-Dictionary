import SwiftUI

struct onBoardingView: View {
    //Onboarding States:
    /*
     0- Welcome Screen
     1- Add Name
     2- Age
     3- Gender
     */
    
    
    //onboarding inputs
    @State var name: String = ""
    @State var age: Double = 0
    @State var onBoardingState: Int = 0
    @State var gender:String = String()
    //Alerts
    @State var alertTitle: String = String()
    @State var showAlert: Bool = false
    //AppStorage
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    //MARK: Animation Transition
    //creating a custom transition to move from the right to the left
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    var body: some View {
        ZStack {
            //Content Layer
            ZStack {
                switch onBoardingState {
                    case 0:
                      welcomeSection
                            .transition(transition)
                    case 1:
                        addNameSection
                            .transition(transition)
                    case 2:
                        addAgeSection
                            .transition(transition)
                    case 3:
                        addGenderSection
                            .transition(transition)
                    default:
                      RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.green)
                }
            }
            
            //Button Layer
            
            VStack {
                Spacer()
                bottomButton
            }
            .padding(30)
        }.alert(isPresented: $showAlert) {
            return Alert(title: Text(alertTitle))
        }

    }
}

struct onBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        onBoardingView()
            .background(.purple)
    }
}

//MARK: COMPONENTS
//Extension should have the same name as the struct where you want to display the view
extension onBoardingView {
    private var bottomButton: some View {
        Text(onBoardingState == 0 ? "Sign Up!" :
                onBoardingState == 3 ? "FINISH" : "NEXT")
            .font(.headline)
            .foregroundColor(.purple)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(.white)
            .animation(nil, value: 0)
            .cornerRadius(10)
            .onTapGesture {
                handleNextButtonPressed()
            }
    }
    
    private var welcomeSection: some View{
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "heart.text.square.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.white)
            
            Text("Find your match.")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .overlay(Capsule(style: .continuous).frame(height: 3).offset(y: 5).foregroundColor(.white), alignment: .bottom)
                
            Text("This is the best way to learn how to use AppStore and other techniques")
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(.top,15)
                .frame(width: 300)
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    private var addNameSection: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Whats your name?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            //MARK: Custom Placeholder
            //Created a custom placeholder that would take in a color in order for it to be more visible
            ZStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                if name.isEmpty {
                    Text("Enter your name here....").bold()
                        .font(.headline)
                        .foregroundColor(.orange)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.vertical)
                }
                
                TextField("", text: $name)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .frame(height: 55)
                    .padding(.horizontal)
                    .foregroundColor(.teal)
                    .background(.white.opacity(name.count > 0 ? 1: 0))
                    .cornerRadius(10)
                    .padding(.vertical)
                
                }
            }
            
            Spacer()
            Spacer()
          
        }
        .padding(30)
    }
    
    private var addAgeSection: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Whats your age?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Text("\(age, format: .number)").foregroundColor(.white)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Slider(value: $age, in: 18...99, step: 1)
                .tint(.white)
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    private var addGenderSection: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Whats your gender?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Picker(gender.count > 1 ? gender : "Select Your Gender", selection: $gender) {
                Text("Male").tag("Male")
                Text("Female").tag("Female")
                Text("Non-Binary").tag("Non-Binary")
            }
            .foregroundColor(.purple)
            .font(.headline)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(10)
            
            Spacer()
            Spacer()
        }
        .padding(30)
    }
}

//MARK: FUNCTIONS
extension onBoardingView {
 
    func handleNextButtonPressed() {
        
        //Check inputs
        
        switch onBoardingState {
            case 1:
                guard name.count >= 3 else {
                    showAlert(title: "Your name must be at least three characters long!")
                    return
                }
            case 3:
                guard !gender.isEmpty else {
                    showAlert(title: "Please select a gender to move forward.")
                    return
                }
            default: break
        }
        
        //Go to next section
        if onBoardingState == 3 {
            //sign in
            withAnimation(.spring()){
                signIn()
            }
        }else {
            
            withAnimation(.spring())
            {
                onBoardingState += 1
            }
        }
    }
    
    func signIn() {
        currentUserName = name
        currentUserAge = Int(age)
        currentUserGender = gender
        withAnimation(.spring()) {
            currentUserSignedIn = true
        }
    }
    

    
    func showAlert(title: String) {
        alertTitle = title
        showAlert.toggle()
        
    }
}
