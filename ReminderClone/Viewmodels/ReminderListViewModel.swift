//
//  ReminderListViewModel.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 05/10/25.
//
import SwiftUI
class ReminderListViewModel: ObservableObject {
    @Published var selectedReminder: Reminder?
    @Published var showReminderDetail: Bool = false
    
    func reminderCheckChanged(_ reminder: Reminder, isCompleted: Bool) {
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = isCompleted
        do {
            _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error)
        }
    }
    
    func deleteReminder(_ reminders: FetchedResults<Reminder>, at indexSet: IndexSet) {
        indexSet.forEach { index in
            let reminder = reminders[index]
            do {
                try ReminderService.deleteReminder(reminder)
            } catch {
                print(error)
            }
        }
    }
    
    func isReminderSelected(_ reminder: Reminder) -> Bool {
        selectedReminder?.objectID == reminder.objectID
    }
}
