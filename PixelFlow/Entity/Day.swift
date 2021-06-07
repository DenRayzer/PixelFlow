//
//  Day.swift
//  PixelFlow
//
//  Created by Елизавета on 10.04.2021.
//

import Foundation

class Day {
    var date: Date
    var type: DayType
    var notes: [Note]
    var additionalColors: [AdditionalColor]

    init(date: Date, typeId: Int16 = 0, notes: [Note] = [], additionalColors: [AdditionalColor] = []) {
        self.date = date
        self.notes = notes
        self.additionalColors = additionalColors
        self.type = DayType(rawValue: typeId) ?? .null
    }
}
