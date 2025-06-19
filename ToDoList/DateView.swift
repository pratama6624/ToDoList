//
//  DateView.swift
//  ToDoList
//
//  Created by Pratama One on 13/06/25.
//

import SwiftUI

struct DateView: View {
    
    // Mengikuti semua properti yang di publish dari DateManager
    @EnvironmentObject var weekManager: DateManager
    var week: WeekModel
    
    var body: some View {
        HStack {
            // Loop untuk 1 minggu penuh
            ForEach(0..<7) { i in
                VStack {
                    // Ambil 3 digit name of day
                    Text(week.dates[i].toString(format: "EEE").uppercased())
                        .font(.system(size: 10))
                        .fontWeight(week.dates[i] == week.referenceDate ? .semibold : .light)
                        .foregroundStyle(week.dates[i] == week.referenceDate ? .white : .black)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                        .frame(height: 4)
                    
                    // Ambil Tanngal
                    Text(week.dates[i].toString(format: "d"))
                        .font(.system(size: 16))
                        .fontWeight(week.dates[i] == week.referenceDate ? .bold : .light)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(week.dates[i] == week.referenceDate ? .white : .black)
                }
                .frame(maxWidth: .infinity)
                .padding(5)
                .background(week.dates[i] == week.referenceDate ? .black : .clear)
                .clipShape(.rect(cornerRadius: 10))
                .onTapGesture {
                    withAnimation(.linear(duration: 0.1)) {
                        weekManager.selectedDate = week.dates[i]
                    }
                }
            }
        }
    }
    
}

#Preview {
    DateView(
        week: .init(index: 1, dates: [
            Date().yesterday.yesterday.yesterday,
            Date().yesterday.yesterday,
            Date().yesterday,
            Date(),
            Date().tomorrow,
            Date().tomorrow.tomorrow,
            Date().tomorrow.tomorrow.tomorrow
        ], referenceDate: Date())
    )
    .environmentObject(DateManager())
}
