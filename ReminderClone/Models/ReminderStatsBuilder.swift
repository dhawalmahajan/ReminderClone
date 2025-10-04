//
//  ReminderStatsBuilder.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 04/10/25.
//
import SwiftUI
enum ReminderStatType {
    case today
    case all
    case scheduled
    case complete
}
struct ReminderStatsValues {
    var todayCount:Int = 0
    var scheduledCount:Int = 0
    var allCount:Int = 0
    var completedCount:Int = 0
}
struct ReminderStatsBuilder {
    func build(myListResult: FetchedResults<MyList>) -> ReminderStatsValues {
        let remindersArray = myListResult.map {
            $0.remindersArray
        }.reduce([], +)
        let completedCount = calculateCompletedCount(reminders: remindersArray)
        let allCount = calculateAllCount(reminders: remindersArray)
        let todayCount = calculateTodayCount(reminders: remindersArray)
        let scheduledCount = calculateScheduleCount(reminders: remindersArray)
        return ReminderStatsValues(todayCount: todayCount,scheduledCount: scheduledCount,allCount: allCount,completedCount: completedCount)
    }
    private func calculateScheduleCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return ((reminder.reminderDate != nil || reminder.reminderTime != nil) && !reminder.isCompleted) ? result + 1 : result
        }
    }
    private func calculateTodayCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            let today = reminder.reminderDate?.isToday ?? false
            return today ? result + 1 : result
        }
    }
    private func calculateAllCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return !reminder.isCompleted ? result + 1 : result
        }
    }
    private func calculateCompletedCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return reminder.isCompleted ? result + 1 : result
        }
    }
}
