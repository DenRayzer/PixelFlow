//
//  Day.swift
//  PixelFlow
//
//  Created by Елизавета on 10.04.2021.
//

import Foundation

enum DayType {
    case null
    case first
    case second
    case third
    case fourth
    case fifth
    case sixth
    case seventh
    case eighth
}

struct Day {
    var date: Date
    var type: DayType
    var notes: [String]?
    
    init(date: Date, type: DayType = .null, notes: [String]? = nil) {
        self.date = date
        self.type = type
        self.notes = notes
    }
}
