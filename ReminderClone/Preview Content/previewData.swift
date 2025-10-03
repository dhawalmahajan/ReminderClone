//
//  previewData.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 11/09/25.
//

class PreviewData {
    static var myList: MyList {
        let context = CoreDataProvider.shared.persistentContainer.viewContext
        let request = MyList.fetchRequest()
        return (try? context.fetch(request).first) ?? MyList()
        
    }
    static var reminder: Reminder {
        let context = CoreDataProvider.shared.persistentContainer.viewContext
        let request = Reminder.fetchRequest()
        return (try? context.fetch(request).first) ?? Reminder(context: context )
    }
}
