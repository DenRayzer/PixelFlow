//
//  AdditionalColor.swift
//  PixelFlow
//
//  Created by Елизавета on 22.05.2021.
//

import UIKit

class AdditionalColor {
    var color: DayType
    var date: Date

    internal init(color: DayType, date: Date) {
        self.color = color
        self.date = date
    }
}
