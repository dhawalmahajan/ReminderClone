//
//  HomeViewModel.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 05/10/25.
//
import SwiftUI
class HomeViewModel: ObservableObject {
    @Published var isPresented: Bool = false
    @Published var search: String = ""
    @Published var searching: Bool = false
    private var reminderStatBuilder = ReminderStatsBuilder()
    @Published var reminderStatValues: ReminderStatsValues = ReminderStatsValues()
    
    func updateStats(from myListResults: FetchedResults<MyList>) {
        reminderStatValues = reminderStatBuilder.build(myListResult: myListResults)
    }
}
