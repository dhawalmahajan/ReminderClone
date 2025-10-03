//
//  Date+Extension.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 03/10/25.
//
import Foundation
extension Date {
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    var isTommorow: Bool {
        Calendar.current.isDateInTomorrow(self)
    }
    var dateComponents: DateComponents {
        Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: self)
    }
}
