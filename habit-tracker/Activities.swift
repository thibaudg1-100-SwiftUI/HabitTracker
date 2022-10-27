//
//  Activities.swift
//  habit-tracker
//
//  Created by RqwerKnot on 22/02/2022.
//

import Foundation

class Activities: ObservableObject {
    @Published var items = [ActivityItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded =  try? decoder.decode([ActivityItem].self, from: savedItems){
                self.items = decoded
                return
            }
        }
        self.items = [.exampleActivity]
    }
}

extension Activities {
    static let exampleActivities = Activities()
    
}
