import SwiftUI

//MARK: Model 1  with Hashable
///below you can see that we don't need to pass in an 'id' variable because hashable is creating a hash for each one that will be used as an ID when you loop over it
///
//struct UserModel: Hashable {
//    let displayName: String
//    let userName: String
//    let followers: Int
//}

//MARK: Model 2  with Identifiable
///below we are using Identifiable which requires an ID to be created and passed into it.
struct UserModel: Identifiable {
    var id = UUID()
    let displayName: String
    let userName: String
    let followers: Int
    let isVerified: Bool
}

struct Model_Types: View {
    //MARK: Property with UserModel assigned to it
    @State var users: [UserModel] = [
        //Creating userModel data below
        UserModel(displayName: "Tiffany", userName: "TJA", followers: 1_000_000_000, isVerified: true),
        UserModel(displayName: "Adrian", userName: "Warrior", followers: 240_000_000, isVerified: true),
        UserModel(displayName: "Sarah", userName: "Starkan", followers: 1000, isVerified: false),
        UserModel(displayName: "Marcus", userName: "funStuff", followers: 10, isVerified: false)
    ]
    
    var body: some View {
        NavigationStack {
            List {
                
                //MARK: ForEach for Identifiable
                ///Since we are creating an ID in our model, we dont need to assign a id:\.self here
                ForEach(users){
                    item in
                    HStack {
                        Circle()
                            .frame(width: 35, height: 35)
                            .padding(.trailing)
                        VStack(alignment: .leading, spacing: 3.0) {
                            Text("User: \(item.displayName)").font(.headline)
                            Text("@\(item.userName)").font(.caption)
                   
                        }
                        
                        Spacer()
                        VStack {
                            Text("\(item.followers)").font(.headline)
                            Text("Followers").font(.caption)
                            
                            if item.isVerified {
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(.blue)
                            } else {
                                Image(systemName: "person.fill")
                                    .foregroundColor(.red)
                            }
                        }
                        
                    }.padding(.vertical, 10)
                   
                }
                //MARK: ForEach for Hashable
                ///Since we don't have  an ID in our model, we need to assign a id:\.self here. Need to uncomment to and comment the above to see the difference
                ///
                ///
//                ForEach(users, id: \.self){
//                    item in
//                    HStack {
//                        Circle()
//                            .frame(width: 35, height: 35)
//                            .padding(.trailing)
//                        VStack {
//                            Text("User: \(item.displayName)")
//                            Text("UserName: \(item.userName)")
//                            Text("Follower Count: \(item.followers)")
//                        }
//                    }.padding(.vertical, 10)
//
//                }
            }
        }.navigationTitle("Model[Users]")
    }
}

struct Model_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Model_Types()
        }
    }
}
