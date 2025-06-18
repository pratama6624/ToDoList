//
//  DateExtension.swift
//  ToDoList
//
//  Created by Pratama One on 12/06/25.
//

import Foundation

extension Date {
    // Rubah UTC ke format +7 WIB jakarta indonesia (dari UTC ke +7 GMT WIB Jakarta auto gagal karena dilock swift)
    // Karena di lock oleh swift maka akan tetap mengikuti UTC (GMT -7 jam)
    func toWIBString(withFormat format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(identifier: "Asia/Jakarta")
        return formatter.string(from: self)
    }
    
    func monthToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: self)
    }
    
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.calendar = CalendarHelper.jakarta
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
    // Mengambil tanggal kemarin
    // Karena UTC selalu -7 dari GMT +7 maka ubah manual agar tidak membingungkan
    var yesterday: Date {
        CalendarHelper.jakarta.date(byAdding: .day, value: -1, to: self)!
    }
    
    // Mengambil tanggal besok
    // Karena UTC selalu -7 dari GMT +7 maka ubah manual agar tidak membingungkan
    var tomorrow: Date {
        CalendarHelper.jakarta.date(byAdding: .day, value: 1, to: self)!
    }
}
