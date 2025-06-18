//
//  DateSliderView.swift
//  ToDoList
//
//  Created by Pratama One on 12/06/25.
//

import SwiftUI

// Tipe generik
struct DateSliderView<DateViewContent: View>: View {
    
    // Mengikuti semua properti yang di publish dari DateManager
    @EnvironmentObject var weekManager: DateManager
    // Aktif tab untuk week (default 1 artinya di tengah / minggu saat ini kalo 0 itu minggu lalu dan 2 itu minggu depan)
    @State private var activeTab: Int = 1
    @State private var position = CGSize.zero
    @GestureState private var dragOffset = CGSize.zero
    // Untuk menyimpan state sementara dengan on change (0 = past, 1 now, dan 2 future)
    @State private var direction: SliderTimeDirection = .unknown
    
    let dateViewContent: (_ week: WeekModel) -> DateViewContent
    
    init(@ViewBuilder dateViewContent: @escaping (_ week: WeekModel) -> DateViewContent) {
        self.dateViewContent = dateViewContent
    }
    
    var body: some View {
        TabView(selection: $activeTab) {
            // Minggu lalu dengan index -1 tapi pakai tag 0 agar bisa ditrack oleh TabView
            dateViewContent(weekManager.weeks[0])
                .frame(maxWidth: .infinity)
                .tag(0)
            
            // Minggu sekarang dengan index 0 api pakai tag 1 agar bisa ditrack oleh TabView
            dateViewContent(weekManager.weeks[1])
                .frame(maxWidth: .infinity)
                .tag(1)
                // Disappear itu menghilang ya bree, jadi kalo hilang / geser ke arah swipe dengan tag 0 (past) / 2 (future)
                .onDisappear {
                    guard direction != .unknown else { return }
                    weekManager.update(to: direction)
                    // reset kembali ke minggu sekarang
                    direction = .unknown
                    activeTab = 1
                }
            
            // Minggu depan dengan index 1 api pakai tag 2 agar bisa ditrack oleh TabView
            dateViewContent(weekManager.weeks[2])
                .frame(maxWidth: .infinity)
                .tag(2)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        // Deteksi arah swipe (kiri 0 kearah past / minggu lalu dan kanan 2 kearah future / minggu depan)
        .onChange(of: activeTab) { _, value in
            if value == 0 {
                direction = .past
                print("PAST")
            } else if value == 2 {
                direction = .future
                print("FUTURE")
            }
        }
    }
}

#Preview {
    DateSliderView() { week in
        DateView(week: week)
    }
    .environmentObject(DateManager())
}
