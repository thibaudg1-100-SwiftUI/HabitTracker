//
//  ContentView.swift
//  habit-tracker
//
//  Created by RqwerKnot on 22/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var activities = Activities()
    
    @State private var showForm = false
    
    @State private var title = ""
    @State private var description = ""
    @State private var done = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(activities.items) { activity in
                    
                        NavigationLink {
                            ActivityDetailView(activity: activity, activities: activities)
                        } label: {
                            Text("\(activity.title)")
                        }
                    
                }
                .onDelete { offsets in
                    activities.items.remove(atOffsets: offsets)
                }
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showForm.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showForm, onDismiss: {
            if done && !title.isEmpty {
                let newActivity = ActivityItem(title: title, description: description)
                activities.items.append(newActivity)
            }
            (title, description) = ("", "")
        }) {
            NewActivityForm(title: $title, description: $description, done: $done)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
