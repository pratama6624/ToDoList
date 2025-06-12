//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Pratama One on 11/06/25.
//

import SwiftUI

@main
struct ToDoListApp: App {
    
    @StateObject var dateManager: DateManager = DateManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dateManager)
        }
    }
}
