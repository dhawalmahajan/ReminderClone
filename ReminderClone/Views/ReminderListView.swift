//
//  ReminderListView.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 03/10/25.
//

import SwiftUI

struct ReminderListView: View {
    let reminders: FetchedResults<Reminder>
    
    private func reminderCheckChanged(_ reminder: Reminder) {
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted.toggle()
        do {
           _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch  {
            print(error)
        }
        
    }
    var body: some View {
        List(reminders) { reminder in
            ReminderCellView(reminder: reminder) { event in
                switch event {
                case .onInfo:
                    print("")
                case .onCheckChange(let reminder):
                    reminderCheckChanged(reminder)
                case .onSelect(let reminder):
                    print(reminder)
                }
                
            }
            
        }
    }
}

//#Preview {
//    ReminderListView()
//}
