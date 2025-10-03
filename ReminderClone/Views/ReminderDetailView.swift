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
                        
                    }
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
