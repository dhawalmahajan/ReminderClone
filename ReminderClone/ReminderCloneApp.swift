//
//  ReminderCloneApp.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 31/08/25.
//

import SwiftUI

@main
struct ReminderCloneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
