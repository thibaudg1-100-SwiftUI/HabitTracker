//
//  ActivityDetailView.swift
//  habit-tracker
//
//  Created by RqwerKnot on 23/02/2022.
//

import SwiftUI

struct ActivityDetailView: View {
    
    var activity: ActivityItem
    
    @ObservedObject var activities: Activities
    
    var nbTimes: String {
        "\(activity.counter) times"
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text(activity.description)
            
            Text("Completed: " + nbTimes)
            
            HStack {
                Button {
                    if let index = activities.items.firstIndex(of: self.activity) {
                        var tempActivity = self.activity
                        print( tempActivity == self.activity) // check value equality
                        print (tempActivity.id, self.activity.id, separator: " | ") // check that UUID has been copied as well and that 2 instances now share the same UUID...
                        
                        tempActivity.counter += 1
                        print( tempActivity == self.activity) // check that they are not equal anymore
                        print (tempActivity.id, self.activity.id, separator: " | ") // but that their UUID remain the same...
                        
//                        tempActivity.id = UUID() // manually change UUID of one instance
                        print (tempActivity.id, self.activity.id, separator: " | ") // check that the UUID has actually been changed on one instance, and they remain obviously not equal
                        // that implies as well that ForEach from parent view will be trying to display a child View for an id that doesn't exist anymore in the collection, forcing UI to go back to initial parent screen... Conclusion : do not change manually UUIDs!
                        
                        activities.items[index] = tempActivity
                    }
                } label: {
                    Image(systemName: "plus")
                }
                
                Button {
                    if activity.counter > 0 {
                        if let index = activities.items.firstIndex(of: self.activity) {
                            var tempActivity = self.activity
                            tempActivity.counter -= 1
                            
                            activities.items[index] = tempActivity
                        }
                    }
                } label: {
                    Image(systemName: "minus")
                }
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
        .border(.teal, width: 5)
        .navigationTitle(activity.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        //        NavigationView {
        ActivityDetailView(activity: .exampleActivity, activities: .exampleActivities)
        //        }
    }
}
