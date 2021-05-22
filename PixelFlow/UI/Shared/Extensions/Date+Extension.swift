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


}
