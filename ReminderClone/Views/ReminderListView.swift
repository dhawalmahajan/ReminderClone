//
//  ReminderListView.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 03/10/25.
//

import SwiftUI

struct ReminderListView: View {
    let reminders: FetchedResults<Reminder>
    var body: some View {
        List(reminders) { reminder in
            ReminderCellView(reminder: reminder)
            
        }
    }
}

//#Preview {
//    ReminderListView()
//}
