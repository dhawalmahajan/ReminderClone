//
//  ReminderCloneApp.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 31/08/25.
//

import SwiftUI

@main
struct ReminderCloneApp: App {
    

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
