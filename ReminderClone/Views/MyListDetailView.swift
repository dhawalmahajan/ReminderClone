//
//  MyListDetailView.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 11/09/25.
//


import SwiftUI


struct MyListDetailView: View {
    let myList: MyList
    @StateObject private var viewModel = MyListDetailViewModel()
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Reminder.title, ascending: true)])
    private var reminderResults:FetchedResults<Reminder>
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
                    viewModel.openAddReminderSheet = true
                }
            }
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }.alert("New Reminder", isPresented: $viewModel.openAddReminderSheet) {
            TextField("", text: $viewModel.title)
            Button("Cancel", role: .cancel) {}
            Button("Done") {
                viewModel.saveReminder(to: myList)
            }.disabled(!viewModel.isFormValid)
        }
    }
}

#Preview {
    MyListDetailView(myList: PreviewData.myList)
}
