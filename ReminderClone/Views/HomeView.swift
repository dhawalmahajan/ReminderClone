//
//  HomeView.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 01/09/25.
//

import SwiftUI

struct HomeView: View {
    @State private var isPresented: Bool = false
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    var body: some View {
        NavigationStack {
            VStack {
               MyListView(myList: myListResults)
//                Spacer()
                Button {
                    isPresented = true
                } label: {
                    Text("Add list")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.headline)
                }.padding()
            }.sheet(isPresented: $isPresented) {
                NavigationView {
                    AddNewListView { name, color in
                        //save list to db
                        do {
                            try ReminderService.saveMyList(name, color)
                        }
                        catch {
                            print(error)
                        }
                    }
                    
                }
            }
        }.padding()
    }
}

#Preview {
    HomeView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
