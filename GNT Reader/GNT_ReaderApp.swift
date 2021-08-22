//
//  GNT_ReaderApp.swift
//  GNT Reader
//
//  Created by Matt Robertson on 8/22/21.
//

import SwiftUI

@main
struct GNT_ReaderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
