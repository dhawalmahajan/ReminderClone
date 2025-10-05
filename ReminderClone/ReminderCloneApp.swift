//
//  ReminderCloneApp.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 31/08/25.
//

import SwiftUI
import UserNotifications
@main
struct ReminderCloneApp: App {
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            
        }
    }
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
