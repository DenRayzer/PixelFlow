//
//  Board.swift
//  PixelFlow
//
//  Created by Елизавета on 15.05.2021.
//

import UIKit

class Board {
    var name: String
    var imageName: String
    var mainColorName: String
    var years: [Year]
    var colorSheme: ColorShemeType
    var parameters: [BoardParameter]
    var notifications: [NotificationSetting]

    internal init(name: String, imageName: String, mainColorName: String, years: [Year], colorSheme: ColorShemeType, parameters: [BoardParameter], notifications: [NotificationSetting]) {
        self.name = name
        self.imageName = imageName
        self.mainColorName = mainColorName
        self.years = years
        self.colorSheme = colorSheme
        self.parameters = parameters
        self.notifications = notifications
    }
}
