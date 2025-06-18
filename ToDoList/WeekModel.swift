//
//  WeekModel.swift
//  ToDoList
//
//  Created by Pratama One on 12/06/25.
//

import Foundation

// Untuk date manager
// index (-1 adalah minggu lalu, 0 adalah minggu sekarang, 1 adalah minggu depan)
// dates (hasil dari 7 hari dalam 1 minggu dari start of week)
// reference date (referensi tanggal untuk menghasilkan start of week)
struct WeekModel {
    let index: Int
    let dates: [Date]
    let referenceDate: Date
}
