//
//  ReminderListView.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 03/10/25.
//


import SwiftUI


struct ReminderListView: View {
    let reminders: FetchedResults<Reminder>
    @StateObject private var viewModel = ReminderListViewModel()
    var body: some View {
        VStack {
            List {
                ForEach(reminders) { reminder in
                    ReminderCellView(reminder: reminder, isSelected: viewModel.isReminderSelected(reminder)) { event in
                        switch event {
                        case .onInfo:
                            viewModel.showReminderDetail = true
                        case .onCheckChange(let reminder, let isCompleted):
                            viewModel.reminderCheckChanged(reminder, isCompleted: isCompleted)
                        case .onSelect(let reminder):
                            viewModel.selectedReminder = reminder
                        }
                    }
                }
                .onDelete { indexSet in
                    viewModel.deleteReminder(reminders, at: indexSet)
                }
            }
        }
        .sheet(isPresented: $viewModel.showReminderDetail) {
            ReminderDetailView(reminder: Binding($viewModel.selectedReminder)!)
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
