//
//  CalendarHelper.swift
//  ToDoList
//
//  Created by Pratama One on 16/06/25.
//

import Foundation

// Untuk helper merubah date ke GMT +7 WIB Jakarta Asia (Karena Calendar.current di swift di lock ke UTC maka auto gagal)
struct CalendarHelper {
    static let jakarta: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "id_ID")
        calendar.timeZone = TimeZone(identifier: "Asia/Jakarta")!
        return calendar
    }()
}
