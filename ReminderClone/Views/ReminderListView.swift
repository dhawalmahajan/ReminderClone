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
    private func deleteReminder(_ indexSet:IndexSet) {
        indexSet.forEach { index in
            let reminder = reminders[index]
            do {
                try ReminderService.deleteReminder(reminder)
            }
            catch {
                print(error)
            }
        }
    }
    var body: some View {
        VStack {
            List {
                ForEach(reminders) { reminder in
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
                .onDelete(perform: deleteReminder)
            }
        }
        .sheet(isPresented: $showReminderDetail) {
            ReminderDetailView(reminder: Binding($selectedReminder)!)
        }
    }
}
struct ReminderListViewContainer:View {
    @FetchRequest(sortDescriptors: [])
    private var reminderResults: FetchedResults<Reminder>
    var body: some View {
        ReminderListView(reminders: reminderResults)
    }
}
#Preview {
   
    ReminderListViewContainer()
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
