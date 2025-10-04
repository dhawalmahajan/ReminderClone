//
//  MyList+CoreDataClass.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 31/08/25.
//
//

import Foundation
import CoreData

@objc(MyList)
public class MyList: NSManagedObject {
    var remindersArray: [Reminder] {
        reminders?.allObjects.compactMap {
            $0 as? Reminder
        } ?? []
    }
}
