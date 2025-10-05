//
//  MyListView.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 11/09/25.
//

import SwiftUI

struct MyListView: View {
    let myList: FetchedResults<MyList>
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationStack {
            if myList.isEmpty {
                Spacer()
                Text("No Reminders")
            } else {
                ForEach(myList) { myList in
                    NavigationLink(value: myList) {
                        VStack {
                            MyListCellView(myList: myList)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.leading],10)
                                .font(.title3)
                                .foregroundColor(colorScheme == .dark ? Color.offWhite : Color.darkGrayColor)
                            Divider()
                        }
                    }
                    .listRowBackground(colorScheme == .dark ? Color.darkGrayColor : Color.offWhite)
                    .scrollContentBackground(.hidden)
                    .navigationDestination(for: MyList.self) { myList in
                        MyListDetailView(myList: myList)
                            .navigationTitle(myList.name)
                    }
                }
            }
        }
    }
}

//#Preview {
//    MyListView()
//}
