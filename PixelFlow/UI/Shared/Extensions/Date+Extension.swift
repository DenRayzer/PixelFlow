//
//  Date+Extension.swift
//  PixelFlow
//
//  Created by Елизавета on 22.05.2021.
//

import Foundation

extension Date {
    func getString(with format: String) -> String {
        return DateFormatter.localizedString(from: self, dateStyle: .none, timeStyle: .short)
        //   formatter.setLocalizedDateFormatFromTemplate(format)
//        formatter.dateFormat = format
//
//        formatter.locale = .current
//        return  formatter.string(from: self)
    }

    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }

}
