//
//  Year.swift
//  PixelFlow
//
//  Created by Elizaveta on 4/18/21.
//

import Foundation

struct Year {
    let year: Int
    var months: [[Day?]] = Array(repeating: Array(repeating: nil, count: 31), count: 12)
    
    init(year: Int) {
        self.year = year
        for month in 1...12 {
            for day in 1...31 {
                let formatter = DateFormatter()
                formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
                formatter.dateFormat = "dd/MM/yyyy"
                let dayStr = "\(day)/\(month)/\(year)"
                guard let currDay = formatter.date(from: dayStr) else { continue }
                months[month - 1][day - 1] = Day(date: currDay)
            }
        }
    }
    
}
