//
//  HomeView.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 01/09/25.
//

import SwiftUI

struct HomeView: View {
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    @FetchRequest(sortDescriptors: [])
    private var searchResult: FetchedResults<Reminder>
    
    
    @State private var isPresented: Bool = false
    @State private var search: String = ""
    @State private var searching: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    MyListView(myList: myListResults)
                    Button {
                        isPresented = true
                    } label: {
                        Text("Add list")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.headline)
                    }.padding()
                }
            }
            .onChange(of: search, perform: { searchTerm in
                searching = !searchTerm.isEmpty ? true : false
                searchResult.nsPredicate = ReminderService.getRemindersBySearchTerm(search).predicate
            })
            .overlay(alignment: .center, content: {
                ReminderListView(reminders: searchResult)
                    .opacity(searching ? 1.0 : 0.0)
            })
            .sheet(isPresented: $isPresented) {
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
            .padding()
        }
        .searchable(text: $search)
    }
}

#Preview {
    HomeView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}
