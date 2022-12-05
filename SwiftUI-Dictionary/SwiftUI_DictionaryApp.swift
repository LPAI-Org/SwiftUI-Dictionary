//
//  SwiftUI_DictionaryApp.swift
//  SwiftUI-Dictionary
//
//  Created by Marcus Arkan on 12/5/22.
//

import SwiftUI

@main
struct SwiftUI_DictionaryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
