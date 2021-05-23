//
//  Board.swift
//  PixelFlow
//
//  Created by Елизавета on 15.05.2021.
//

import UIKit

class Board {
    var name: String
    var imageId: Int16
    var mainColorId: Int16
    var years: [Year]
    var colorSheme: ColorShemeType
    var parameters: [BoardParameter]
    var notifications: [NotificationSetting]

    internal init(name: String, imageId: Int16, mainColorId: Int16, years: [Year], colorShemeId: Int16, parameters: [BoardParameter], notifications: [NotificationSetting]) {
        self.name = name
        self.imageId = imageId
        self.mainColorId = mainColorId
        self.years = years
        self.parameters = parameters
        self.notifications = notifications
        var shemeType: ColorShemeType = .base
        ColorShemeType.allCases.forEach { i in
            if i.rawValue == colorShemeId {
                shemeType = i
            }
        }
        self.colorSheme = shemeType
    }
}
