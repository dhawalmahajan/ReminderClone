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
    private var reminderStatBuilder = ReminderStatsBuilder()
    @State private var reminderStatValues: ReminderStatsValues = ReminderStatsValues()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                   
                    HStack {
                        ReminderStatView(icon: "calendar.badge.plus", title: "Today", count: reminderStatValues.todayCount)
                        ReminderStatView(icon: "tray.circle.fill", title: "All", count: reminderStatValues.allCount)
                    }
                    HStack {
                        ReminderStatView(icon: "calendar.circle.fill", title: "Scheduled", count: reminderStatValues.scheduledCount)
                        ReminderStatView(icon: "checkmark.circle.fill", title: "Completed", count: reminderStatValues.completedCount)
                    }
                    Text("My List")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .bold()
                        .padding()
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
            .onChange(of: search, perform: { searchTerm in
                searching = !searchTerm.isEmpty ? true : false
                searchResult.nsPredicate = ReminderService.getRemindersBySearchTerm(search).predicate
            })
            .overlay(alignment: .center, content: {
                ReminderListView(reminders: searchResult)
                    .opacity(searching ? 1.0 : 0.0)
            })
            .onAppear {
                reminderStatValues = reminderStatBuilder.build(myListResult: myListResults)
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
