//
//  BoardParameter.swift
//  PixelFlow
//
//  Created by Елизавета on 15.05.2021.
//

import UIKit

class BoardParameter {
    var name: String
    var color: DayType

    internal init(name: String, color: Int16, colorSheme: Int16) {
        self.name = name
        self.color = DayType(rawValue: color) ?? DayType.null
    }
}
