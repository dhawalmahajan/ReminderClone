//
//  MyListDetailViewModel.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 05/10/25.
//
import SwiftUI
class MyListDetailViewModel: ObservableObject {
    @Published var openAddReminderSheet: Bool = false
    @Published var title: String = ""
    
    var isFormValid: Bool {
        !title.isEmpty
    }
    
    func saveReminder(to myList: MyList) {
        guard isFormValid else { return }
        do {
            try ReminderService.saveReminderToMyList(myList: myList, title: title)
            title = ""
        } catch {
            print(error.localizedDescription)
        }
    }
}
