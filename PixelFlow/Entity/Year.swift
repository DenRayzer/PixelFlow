//
//  Year.swift
//  PixelFlow
//
//  Created by Elizaveta on 4/18/21.
//

import Foundation

class Year {
    let year: Int16
    private let days: [Day]
    lazy var months: [[Day?]] = Array(repeating: Array(repeating: nil, count: 31), count: 12)

    init(year: Int16, days: [Day]) {
        self.year = year
        self.days = days
    }

    func configureMonths() {
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        formatter.dateFormat = "dd/MM/yyyy"
        //  measure("ЧПОК") { finish in
        //   DispatchQueue.global(qos: .userInteractive).async { [weak self] in
        for month in 1...12 {
//            DispatchQueue.global().async { [weak self] in
//                guard let self = self else { return }
            for day in 1...31 {
                    let dayStr = "\(day)/\(month)/\(String(describing: self.year))"
                    guard let currDay = formatter.date(from: dayStr) else { continue }
                    var dayToShow = Day(date: currDay)
                    if let storedDay = self.days.first(where: { $0.date.get(.day, .month, .year) == currDay.get(.day, .month, .year) }) {
                        dayToShow = storedDay
                        // do something with foo
                    }
                    self.months[month - 1][day - 1] = dayToShow
                }
           // }
        }
        //  finish()
        //  }
        //  }
    }
}

func measure(_ title: String, block: (@escaping () -> ()) -> ()) {
    let startTime = CFAbsoluteTimeGetCurrent()

    block {
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print("\(title):: Time: \(timeElapsed)")
    }
}
