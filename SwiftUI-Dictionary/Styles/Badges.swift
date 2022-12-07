//
//  Badges.swift
//  SwiftUI-Functionalities
//
//  Created by Marcus Arkan on 11/25/22.
//

import SwiftUI

struct Badges_Styles: View {
    var body: some View {
        


        TabView {
            ListViewBadge
                .tabItem {
                    Image(systemName: "house.fill")
                        Text("Home")
                }
            
            //MARK: Badge Example
            Color.red
                .tabItem {
                    Image(systemName: "envelope")
                    Text("Hello")
                }
                //Badge example Int format
                .badge(5)
            
            Color.green
                .tabItem {
                    Image(systemName: "person.fill")
                        Text("Person")
                }
            //Badge example String format
                .badge("New")
        }
    }
    
    //MARK: Badge example within list
    var ListViewBadge: some View {
        List {
            Text("Hello World")
                .badge("New")
            Text("Hello World")
                .badge(5)
            Text("Hello World")
                .badge("Swipe")
        }
    }
}


struct Badges_Previews: PreviewProvider {
    static var previews: some View {
        Badges_Styles()
    }
}
