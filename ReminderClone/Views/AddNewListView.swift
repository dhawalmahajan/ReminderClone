//
//  AddNewListView.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 31/08/25.
//

import SwiftUI



struct AddNewListView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = AddNewListViewModel()
    let onSave:(String, UIColor) -> Void
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "line.3.horizontal.circle.fill")
                    .foregroundColor(viewModel.selectedColor)
                    .font(.system(size: 100))
                TextField("List Name", text: $viewModel.name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(30)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            ColorPickerView(selectedColor: $viewModel.selectedColor)
            Spacer()
        }.frame(maxWidth:.infinity,maxHeight:.infinity)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("New list")
                        .font(.headline)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                        
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                        //save the list
                        onSave(viewModel.name, UIColor(viewModel.selectedColor))
                    }.disabled(!viewModel.isFormValid)
                        
                }
            }
    }
        
}

#Preview {
    NavigationView {
        AddNewListView(onSave: {(_,_) in })
    }
}
