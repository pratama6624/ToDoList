//
//  DateManagerExtention.swift
//  ToDoList
//
//  Created by Pratama One on 12/06/25.
//

import Foundation

class DateManager: ObservableObject {
    
    // NOTE : DI SWIFT FORMAT CALENDAR.CURRENT DI LOCK UTC / BELUM GMT +7 SEPERTI DI INDO WIB,
    // JADI GUNAKAN KONVERSI MANUAL KE WIB +7 SECARA MANUAL SETIAP KALI DEBUGGING
    
    // Berisi 3 array [1 minggu lalu, minggu sekarang, 1 minggu depan]
    @Published var weeks: [WeekModel] = []
    // Selected date adalah tanggal sekarang
    @Published var selectedDate: Date {
        didSet {
            calsWeeks(with: selectedDate)
        }
    }
    
    // Selalu isi dengan tanggal sekarang saat pertama kali di inisialisasi
    init(with date: Date = Date()) {
        self.selectedDate = CalendarHelper.jakarta.startOfDay(for: date)
        print("selected date is \(self.selectedDate.toWIBString(withFormat: "EEEE, dd MMM yyyy HH:mm 'WIB'"))")
        // Panggil this function untuk mengisi weeks
        calsWeeks(with: selectedDate)
    }
    
    private func calsWeeks(with date: Date) {
        // Fungsi ini hanya untuk mengisi weeks (No return just void)
        /*
            [
                for: date - 7 hari, with: minggu sebelum,
                for: date, with: minggu sekarang,
                for: date + 7 hari, with: minggu depan
            ]
        */
        weeks = [
            week(for: CalendarHelper.jakarta.date(byAdding: .day, value: -7, to: date)!, with: -1, status: "minggu lalu / last week"),
            week(for: date, with: 0, status: "minggu sekarang / this week"),
            week(for: CalendarHelper.jakarta.date(byAdding: .day, value: 7, to: date)!, with: 1, status: "minggu depan / next week")
        ]
    }
    
    private func week(for date: Date, with index: Int, status: String) -> WeekModel {
        // 3 parameter di fungsi week dikirim secara bersamaan dari calsWeeks
        print("\ndate reference is \(date.toWIBString(withFormat: "EEEE, dd MMM yyyy HH:mm 'WIB'"))")
        // Kosongkan result diawal
        var result: [Date] = .init()
        // Cari start of the week (dalam kasus ini hari minggu dan juga default swift)
        guard let startOfWeek = CalendarHelper.jakarta.date(from: CalendarHelper.jakarta.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)) else {
            return .init(index: index, dates: [], referenceDate: date)
        }
        print("\(status)")
        print("start of week : \(startOfWeek.toWIBString(withFormat: "EEEE, dd MMM yyyy HH:mm 'WIB'"))")
        
        // 0 - 6 day berisi dari hari minggu sampai hari sabtu (patokan = start of week)
        (0...6).forEach( { day in
            if let weekday = CalendarHelper.jakarta.date(byAdding: .day, value: day, to: startOfWeek){
                // tambahkan ke result dari mulai start of the week (minggu) misal dimulai dari Sunday, 22 Jun 2025 12:00 AM WIB
                result.append((weekday))
                print("weekday is: \(weekday.toWIBString(withFormat: "EEEE, dd MMM yyyy HH:mm 'WIB'"))")
            }
        })
        
        // index -> untuk menentukan minggu lalu (-1) minggu sekarang (0) minggu depan (1)
        return .init(index: index, dates: result, referenceDate: date)
    }
    
    // Pilih tanggal sekarang
    func selectToday() {
        select(date: Date())
    }
    
    func select(date: Date) {
        selectedDate = CalendarHelper.jakarta.startOfDay(for: date)
    }
    
    func update(to direction: SliderTimeDirection) {
        switch direction {
        case .future:
            selectedDate = CalendarHelper.jakarta.date(byAdding: .day, value: 7, to: selectedDate)!
        case .past:
            selectedDate = CalendarHelper.jakarta.date(byAdding: .day, value: -7, to: selectedDate)!
        case .unknown:
            selectedDate = selectedDate
        }
        
        calsWeeks(with: selectedDate)
    }
}
