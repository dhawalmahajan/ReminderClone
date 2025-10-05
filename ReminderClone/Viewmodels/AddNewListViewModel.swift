//
//  AddNewListViewModel.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 05/10/25.
//

import SwiftUI
class AddNewListViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var selectedColor: Color = .yellow
    
    var isFormValid: Bool {
        !name.isEmpty
    }
}
