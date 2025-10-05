//
//  ReminderDetailView.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 03/10/25.
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

struct ReminderDetailView: View {
    @Binding var reminder: Reminder
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ReminderDetailViewModel()
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Title",text: $viewModel.editConfig.title)
                        TextField("Notes",text: $viewModel.editConfig.notes ?? "")
                    }
                    Section {
                        Toggle(isOn: $viewModel.editConfig.hasDate) {
                            Image(systemName: "calendar")
                                .foregroundColor(.red)
                        }
                        if viewModel.editConfig.hasDate {
                            DatePicker("Select date", selection: $viewModel.editConfig.reminderDate ?? Date(), displayedComponents: .date)
                        }
                        Toggle(isOn: $viewModel.editConfig.hasTime) {
                            Image(systemName: "clock")
                                .foregroundColor(.blue)
                        }
                        if viewModel.editConfig.hasTime {
                            DatePicker("Select date", selection: $viewModel.editConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
                        }
                        Section {
                            NavigationLink {
                                SelectListView(selectList: $reminder.list)
                            } label: {
                                HStack {
                                    Text("List")
                                    Spacer()
                                    Text(reminder.list?.name ?? "")
                                }
                                
                            }

                        }
                    }
                    .onChange(of: viewModel.editConfig.hasDate) { hasDate in
                        viewModel.handleDateToggle(hasDate)
                    }
                    .onChange(of: viewModel.editConfig.hasTime) { hasTime in
                        viewModel.handleTimeToggle(hasTime)
                    }
                }
                .listStyle(.insetGrouped)
            }
            .onAppear {
                viewModel.loadReminder(reminder)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Details")
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        viewModel.updateReminder(reminder: &reminder)
                        dismiss()
                    }
                    .disabled(!viewModel.isFormValid)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder) )
}
