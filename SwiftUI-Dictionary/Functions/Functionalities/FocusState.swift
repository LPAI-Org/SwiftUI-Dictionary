import SwiftUI

struct FocusState_Functions: View {
    
    enum OnboardingFields {
        case username, password
    }
    @FocusState private var fieldFocus: OnboardingFields?
    
    @State var username: String = String()
    @FocusState private var isNameFocused: Bool
    
    @State var password: String = String()
    @FocusState private var isPassFocused: Bool
    
    var body: some View {
        VStack {
            
            //MARK: @FocusState Version 2 + Enum
            TextField("Add your name here...", text: $username)
                .focused($fieldFocus, equals: .username)
                .padding(.leading)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.gray.brightness(0.3))
                .cornerRadius(10)
            
            SecureField("Add your password here...", text: $password)
                .focused($fieldFocus, equals: .password)
                .padding(.leading)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.gray.brightness(0.3))
                .cornerRadius(10)
            
            Button("Sign up! 😎") {
                isNameFocused.toggle()
                let usernameIsValid = !username.isEmpty
                let passwordIsValid = !password.isEmpty
                
                if usernameIsValid && passwordIsValid {
                    print("SIGN UP!")
                }else if usernameIsValid {
                    fieldFocus = .password
                    
                } else {
                    fieldFocus = .username
                }
                
            }
            
            
            
            //MARK: @FocusState Version 1
//            TextField("Add your name here...", text: $username)
//                .focused($isNameFocused)
//                .padding(.leading)
//                .frame(height: 55)
//                .frame(maxWidth: .infinity)
//                .background(Color.gray.brightness(0.3))
//                .cornerRadius(10)
//
//            SecureField("Add your password here...", text: $password)
//                .focused($isPassFocused)
//                .padding(.leading)
//                .frame(height: 55)
//                .frame(maxWidth: .infinity)
//                .background(Color.gray.brightness(0.3))
//                .cornerRadius(10)
//
//            Button("Sign up! 😎") {
//                isNameFocused.toggle()
//                let usernameIsValid = !username.isEmpty
//                let passwordIsValid = !password.isEmpty
//
//                if usernameIsValid && passwordIsValid {
//                    print("SIGN UP!")
//                }else if usernameIsValid {
//                    isNameFocused = false
//                    isPassFocused = true
//
//                } else {
//                    isNameFocused = true
//                    isPassFocused = false
//                }
//
//            }
        }
        .padding(40)
        
    }
}

struct FocusState_Previews: PreviewProvider {
    static var previews: some View {
        FocusState_Functions()
    }
}
