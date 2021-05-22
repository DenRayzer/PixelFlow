//
//  Day.swift
//  PixelFlow
//
//  Created by Елизавета on 10.04.2021.
//

import Foundation

enum DayType: Int {
    case null = 1, first, second, third, fourth, fifth, sixth, seventh, eighth
}

enum ColorShemeType: Int {
    case base = 0
}

struct Day {
    var date: Date
    var type: DayType
    var notes: [String]?
    var additionalColors: [AdditionalColor]?
    
    init(date: Date, type: DayType = .null, notes: [String]? = nil, additionalColors: [AdditionalColor]? = nil) {
        self.date = date
        self.type = type
        self.notes = notes
        self.additionalColors = additionalColors
    }
}
