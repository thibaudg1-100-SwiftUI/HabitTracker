//
//  ActivityItem.swift
//  habit-tracker
//
//  Created by RqwerKnot on 22/02/2022.
//

import Foundation

struct ActivityItem: Identifiable, Equatable, Codable {
    var id = UUID()
    
    let title: String
    let description: String
    var counter: Int = 0
}

extension ActivityItem {
    static let exampleActivity = ActivityItem(title: "titleExample", description: "descriptionExample")
}
