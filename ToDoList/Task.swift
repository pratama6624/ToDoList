//
//  Untitled.swift
//  ToDoList
//
//  Created by Pratama One on 15/06/25.
//

import SwiftUI

struct Task: Codable, Hashable, Identifiable {
    var id: UUID
    var title: String
    var date: Date
    var isComplete: Bool
    
    init(id: UUID = .init(), title: String, date: Date, isComplete: Bool) {
        self.id = id
        self.title = title
        self.date = date
        self.isComplete = isComplete
    }
}
