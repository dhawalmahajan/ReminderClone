//
//  ReminderListView.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 03/10/25.
//

import SwiftUI

struct ReminderListView: View {
    
    let reminders: FetchedResults<Reminder>
    @State private var selectedReminder: Reminder?
    @State private var showReminderDetail:Bool = false
    private func reminderCheckChanged(_ reminder: Reminder, isCompleted: Bool) {
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = isCompleted
        do {
           _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch  {
            print(error)
        }
        
    }
    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        selectedReminder?.objectID == reminder.objectID
    }
    var body: some View {
        VStack {
            
            List(reminders) { reminder in
                ReminderCellView(reminder: reminder, isSelected: isReminderSelected(reminder)) { event in
                    switch event {
                    case .onInfo:
                        showReminderDetail = true
                    case .onCheckChange(let reminder,let isCompleted):
                        reminderCheckChanged(reminder, isCompleted: isCompleted)
                    case .onSelect(let reminder):
                        selectedReminder = reminder
                    }
                    
                }
                
            }
        }
        .sheet(isPresented: $showReminderDetail) {
            ReminderDetailView(reminder: Binding($selectedReminder)!)
        }
    }
}

//#Preview {
//    ReminderListView()
//}
