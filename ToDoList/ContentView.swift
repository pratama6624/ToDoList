//
//  ContentView.swift
//  ToDoList
//
//  Created by Pratama One on 11/06/25.
//

import SwiftUI

struct ContentView: View {
    
    // Mengikuti semua properti yang di publish dari DateManager
    @EnvironmentObject var dateManager: DateManager
    
    var body: some View {
        ZStack {
            VStack {
                // Entry Point
                DateHeaderVIew(dateManager: _dateManager)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DateManager())
}
