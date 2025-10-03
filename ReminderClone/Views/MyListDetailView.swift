//
//  MyListDetailView.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 11/09/25.
//

import SwiftUI

struct MyListDetailView: View {
    let myList: MyList
    @State private var openAddReminderSheet: Bool = false
    @State private var title: String = ""
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Reminder.title, ascending: true)])
    private var reminderResults:FetchedResults<Reminder>
    private var isFormValid: Bool {
        return !title.isEmpty
    }
    init(myList: MyList) {
        self.myList = myList
        _reminderResults = FetchRequest(fetchRequest: ReminderService.getRemindersByList(myList: myList))
    }
    var body: some View {
        VStack {
            //Display list of reminders
           ReminderListView(reminders: reminderResults)
            HStack {
                Image(systemName: "plus.circle.fill")
                Button("New Reminder") {
                    openAddReminderSheet = true
                }
            }
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }.alert("New Reminder", isPresented: $openAddReminderSheet) {
            TextField("", text: $title)
            Button("Cancel", role: .cancel) {}
            Button("Done") {
                if(isFormValid) {
                    do {
                        try ReminderService.saveReminderToMyList(myList: myList, title: title)
                    } catch  {
                        print(error.localizedDescription)
                    }
                }
            }.disabled(!isFormValid)
        }
    }
}

#Preview {
    MyListDetailView(myList: PreviewData.myList)
}
