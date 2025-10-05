//
//  ReminderDetailViewModel.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 05/10/25.
//

import SwiftUI
class ReminderDetailViewModel: ObservableObject {
    @Published var editConfig: ReminderEditConfig = ReminderEditConfig()
    
    var isFormValid: Bool {
        !editConfig.title.isEmpty
    }
    
    func loadReminder(_ reminder: Reminder) {
        editConfig = ReminderEditConfig(reminder: reminder)
    }
    
    func updateReminder(reminder: inout Reminder) {
        do {
            let updated = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
            if updated, reminder.reminderDate != nil || reminder.reminderTime != nil {
                let userData = Userdata(title: reminder.title, body: reminder.notes, date: reminder.reminderDate, time: reminder.reminderTime)
                NotificationManager.scheduleNotification(userData: userData)
            }
        } catch {
            print(error)
        }
    }
    
    func handleDateToggle(_ hasDate: Bool) {
        if hasDate {
            editConfig.reminderDate = Date()
        }
    }
    
    func handleTimeToggle(_ hasTime: Bool) {
        if hasTime {
            editConfig.reminderTime = Date()
        }
    }
}
