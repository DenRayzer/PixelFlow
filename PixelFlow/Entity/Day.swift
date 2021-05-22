//
//  Day.swift
//  PixelFlow
//
//  Created by Елизавета on 10.04.2021.
//

import Foundation

struct Day {
    var date: Date
    var type: DayType
    var notes: [Note]?
    var additionalColors: [AdditionalColor]?
    
    init(date: Date, type: DayType = .null, notes: [Note]? = nil, additionalColors: [AdditionalColor]? = nil) {
        self.date = date
        self.type = type
        self.notes = notes
        self.additionalColors = additionalColors
    }
}
