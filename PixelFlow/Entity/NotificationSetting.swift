//
//  NotificationSetting.swift
//  PixelFlow
//
//  Created by Елизавета on 15.05.2021.
//

import Foundation

class NotificationSetting {
    var time: Date
    var isOn: Bool

    internal init(time: Date, isOn: Bool) {
        self.time = time
        self.isOn = isOn
    }
}
