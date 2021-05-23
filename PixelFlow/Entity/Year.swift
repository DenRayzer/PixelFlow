//
//  Year.swift
//  PixelFlow
//
//  Created by Elizaveta on 4/18/21.
//

import Foundation

class Year {
    let year: Int16
    var months: [[Day?]] = Array(repeating: Array(repeating: nil, count: 31), count: 12)
    
    init(year: Int16, days: [Day]) {
        self.year = year
        for month in 1...12 {
            for day in 1...31 {
                let formatter = DateFormatter()
                formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
                formatter.dateFormat = "dd/MM/yyyy"
                let dayStr = "\(day)/\(month)/\(year)"
                guard let currDay = formatter.date(from: dayStr) else { continue }
                var dayToShow = Day(date: currDay)
                if let storedDay = days.first(where: {$0.date.get(.day, .month, .year) == currDay.get(.day, .month, .year)}) {
                    dayToShow = storedDay
                   // do something with foo
                }
                months[month - 1][day - 1] = dayToShow
            }
        }
    }
    
}
