//
//  AdditionalColor.swift
//  PixelFlow
//
//  Created by Елизавета on 22.05.2021.
//

import UIKit

class AdditionalColor {
    var colorType: DayType
    var date: Date

    internal init(colorId: Int16, date: Date) {
        var type: DayType = .null
        DayType.allCases.forEach { i in
            if i.rawValue == colorId {
                type = i
            }
        }
        self.colorType = type
        self.date = date
    }
}
