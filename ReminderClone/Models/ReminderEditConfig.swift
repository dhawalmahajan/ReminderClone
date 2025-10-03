//
//  EditConfig.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 03/10/25.
//

import Foundation
struct ReminderEditConfig {
    var title: String = ""
    var notes: String?
    var isCompleted: Bool = false
    var hasTime: Bool = false
    var hasDate: Bool = false
    var reminderDate: Date?
    var reminderTime: Date?
    init() {}
    init(reminder: Reminder) {
        self.title = reminder.title ?? ""
        self.notes = reminder.notes
        self.isCompleted = reminder.isCompleted
        self.hasTime = reminder.reminderTime != nil
        self.hasDate = reminder.reminderDate != nil
        self.reminderDate = reminder.reminderDate
        self.reminderTime = reminder.reminderTime
    }
}
