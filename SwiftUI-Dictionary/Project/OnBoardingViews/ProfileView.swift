//
//  ProfileView.swift
//  SwiftUI-Functionalities
//
//  Created by Marcus Arkan on 11/25/22.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            Text("User: \(currentUserName ?? "No Name")")
            Text("Users Age: \(currentUserAge ?? 0)")
            Text("Users Gender: \(currentUserGender ?? "Unknown Gender")")
            
            Text("Sign Out")
                .foregroundColor(.white)
                .font(.headline)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(.blue)
                .cornerRadius(10)
                .onTapGesture {
                    withAnimation(.spring()) {
                        signOut()
                    }
                }
            
        }   .font(.title)
            .foregroundColor(.purple)
            .padding()
            .padding(.vertical, 40)
            .background(.white)
            .cornerRadius(10)
            .shadow(radius: 10)
        
 
    }
    
    func signOut() {
        
        currentUserName = nil
        currentUserAge = nil
        currentUserGender = nil
        withAnimation(.spring()) {
            currentUserSignedIn = false
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
