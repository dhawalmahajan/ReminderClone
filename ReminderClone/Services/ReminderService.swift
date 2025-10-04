//
//  ReminderService.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 01/09/25.
//

import Foundation
import CoreData
import UIKit

class ReminderService {
    static var viewContext: NSManagedObjectContext  {
        CoreDataProvider.shared.persistentContainer.viewContext
    }
    static func save() throws{
        try viewContext.save()
    }
    
    static func saveMyList(_ name: String,_ color: UIColor) throws {
        let myList = MyList(context: viewContext)
        myList.name = name
        myList.color = color
        try save()
    }
    static func saveReminderToMyList(myList: MyList, title: String) throws {
        let reminder = Reminder(context: viewContext)
        reminder.title = title
        myList.addToReminders(reminder)
        try save()
    }
    static func getRemindersByList(myList: MyList) -> NSFetchRequest<Reminder>{
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "list = %@ AND isCompleted = false ", myList)
        return request
    }
    static func updateReminder(reminder: Reminder, editConfig: ReminderEditConfig) throws -> Bool{
        let reminderToUpdate = reminder
        reminderToUpdate.isCompleted = editConfig.isCompleted
        reminderToUpdate.title = editConfig.title
        reminderToUpdate.notes = editConfig.notes
        reminderToUpdate.reminderDate = editConfig.hasDate ? editConfig.reminderDate : nil
        reminderToUpdate.reminderTime = editConfig.hasTime ? editConfig.reminderTime : nil
        try save()
        return true
    }
    static func deleteReminder(_ reminder: Reminder) throws{
        viewContext.delete(reminder)
       try save()
    }
    static func getRemindersBySearchTerm(_ searchTerm:String) -> NSFetchRequest<Reminder>{
        let request: NSFetchRequest<Reminder> = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchTerm)
        return request
    }
    static func reminderByStatType(_ statType: ReminderStatType) -> NSFetchRequest<Reminder> {
        let request: NSFetchRequest<Reminder> = Reminder.fetchRequest()
        request.sortDescriptors = []
        switch statType {
            case .complete:
                request.predicate = NSPredicate(format: "isCompleted == true")
            case .all:
                request.predicate = NSPredicate(format: "isCompleted = false")
            case .today:
                let today = Date()
                let tommorow = Calendar.current.date(byAdding: .day, value: 1, to: today)
                request.predicate = NSPredicate(format: "(reminderDate>= %@) AND (reminderDate < %@)", today as NSDate, tommorow! as NSDate)
            case .scheduled:
                request.predicate = NSPredicate(format: "(reminderDate != nil OR reminderTime != nil) AND isCompleted = false")
        }
        
        return request
    }
}
