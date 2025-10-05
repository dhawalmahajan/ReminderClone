//
//  ReminderDetailView.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 03/10/25.
//

import SwiftUI

struct ReminderDetailView: View {
    @Binding var reminder: Reminder
    @Environment(\.dismiss) private var dismiss
    @State var editConfig: ReminderEditConfig = ReminderEditConfig()
    private var isFormValid: Bool {
        !editConfig.title.isEmpty
    }
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Title",text: $editConfig.title)
                        TextField("Notes",text: $editConfig.notes ?? "")
                    }
                    Section {
                        Toggle(isOn: $editConfig.hasDate) {
                            Image(systemName: "calendar")
                                .foregroundColor(.red)
                        }
                        if editConfig.hasDate {
                            DatePicker("Select date", selection: $editConfig.reminderDate ?? Date(), displayedComponents: .date)
                        }
                        Toggle(isOn: $editConfig.hasTime) {
                            Image(systemName: "clock")
                                .foregroundColor(.blue)
                        }
                        if editConfig.hasTime {
                            DatePicker("Select date", selection: $editConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
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
                    .onChange(of: editConfig.hasDate) { hasDate in
                        if hasDate == true {
                            editConfig.reminderDate = Date()
                        }
                    }
                    .onChange(of: editConfig.hasTime) { hasTime in
                        if hasTime == true {
                            editConfig.reminderTime = Date()
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
            .onAppear {
               editConfig = ReminderEditConfig(reminder: reminder)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Details")
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        
                            do {
                                let updated = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
                                if updated {
                                    if reminder.reminderDate != nil || reminder.reminderTime != nil {
                                        let userData = Userdata(title: reminder.title, body: reminder.notes, date: reminder.reminderDate, time: reminder.reminderTime)
                                        NotificationManager.scheduleNotification(userData: userData)
                                    }
                                }
                            } catch {
                                print(error)
                            }
                        dismiss()
                    }
                    .disabled(!isFormValid)
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
