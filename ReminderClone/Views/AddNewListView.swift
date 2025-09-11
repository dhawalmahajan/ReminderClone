//
//  AddNewListView.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 31/08/25.
//

import SwiftUI

struct AddNewListView: View {
    @Environment(\.dismiss) private var dismiss
    @State var name: String = ""
    @State var selectedColor:Color = .yellow
    let onSave:(String, UIColor) -> Void
    private var isFormValid:Bool {
        return !name.isEmpty
    }
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "line.3.horizontal.circle.fill")
                    .foregroundColor(selectedColor)
                    .font(.system(size: 100))
                TextField("List Name",text: $name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(30)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            ColorPickerView(selectedColor: $selectedColor)
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
                        onSave(name, UIColor(selectedColor))
                    }.disabled(!isFormValid)
                        
                }
            }
    }
        
}

#Preview {
    NavigationView {
        AddNewListView(onSave: {(_,_) in })
    }
}
