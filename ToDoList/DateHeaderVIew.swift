//
//  DateHeaderVIew.swift
//  ToDoList
//
//  Created by Pratama One on 12/06/25.
//

import SwiftUI
import Foundation

struct DateHeaderVIew: View {
    
    @EnvironmentObject var dateManager: DateManager
    
    var body: some View {
        ZStack {
            VStack {
                nameHeaderTextView()
                
                DateSliderView { week in
                    DateView(week: week)
                }
                .frame(height: 60, alignment: .top)
                
                Divider()
                
                HStack {
                    Spacer()
                    Text(dateManager.selectedDate.toString(format: "EEEE, dd.MM.yyyy"))
                        .font(.system(size: 10, design: .rounded))
                        .foregroundStyle(Color.gray)
                }
            }
            .padding(20)
        }
    }
    
    @ViewBuilder
    private func nameHeaderTextView() -> some View {
        HStack {
            VStack(alignment: .listRowSeparatorLeading, spacing: 0) {
                Text("Hi, Pratama")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .padding(4)
                
                Text(dateManager.selectedDate == Calendar.current.startOfDay(for: Date()) ? "What's up for today" : "Planning for future?")
                    .font(.caption)
                    .fontWeight(.light)
                    .foregroundStyle(.black)
                    .padding(4)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(dateManager.selectedDate.monthToString())
                    .font(.system(size: 10))
                    .fontWeight(.heavy)
                    .foregroundStyle(.black)
                
                Button {
                    withAnimation(.linear(duration: 0.1)) {
                        dateManager.selectToday()
                    }
                } label: {
                    Text("Today")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(4)
                        .background(.black)
                        .cornerRadius(4)
                }
            }
        }
    }
}

#Preview {
    DateHeaderVIew()
        .environmentObject(DateManager())
}
