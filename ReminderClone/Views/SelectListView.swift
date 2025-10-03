//
//  SelectListView.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 03/10/25.
//

import SwiftUI

struct SelectListView: View {
    @FetchRequest(sortDescriptors: [])
    private var myLIstFetchedResult: FetchedResults<MyList>
    
    @Binding var selectList: MyList?
    var body: some View {
        List(myLIstFetchedResult) { myLIst in
            HStack {
                HStack {
                    Image(systemName: "line.3.horizontal.circle.fill")
                        .foregroundColor(Color(myLIst.color))
                    Text(myLIst.name)
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    selectList = myLIst
                }
                Spacer()
                if selectList == myLIst {
                    Image(systemName: "checkmark")
                }
            }
            
        }
    }
}

#Preview {
    SelectListView(selectList: .constant(PreviewData.myList))
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
