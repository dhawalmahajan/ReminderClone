//
//  Untitled.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 05/10/25.
//
import Foundation
import UserNotifications
struct Userdata {
    var title: String?
    var body: String?
    var date: Date?
    var time: Date?
}
class NotificationManager {
    static func scheduleNotification(userData: Userdata) {
        let content = UNMutableNotificationContent()
        content.title = userData.title ?? ""
        content.body = userData.body ?? ""
        var dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: userData.date ?? Date())
        
        if let reminderTime = userData.time {
            let reminderTimeComponents = reminderTime.dateComponents
            dateComponents.hour = reminderTimeComponents.hour
            dateComponents.minute = reminderTimeComponents.minute
        }
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "Reminder Notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}

