//
//  Day.swift
//  PixelFlow
//
//  Created by Елизавета on 10.04.2021.
//

import Foundation

enum DayType {
    case good
    case bad
    case empty
}

struct Day {
    var date: Date
    var type: DayType
    var notes: [String]?
    
    init(date: Date, type: DayType = .empty, notes: [String]? = nil) {
        self.date = date
        self.type = type
        self.notes = notes
    }
}
