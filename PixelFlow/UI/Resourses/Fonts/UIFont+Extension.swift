//
//  UIFont+Extension.swift
//  PixelFlow
//
//  Created by Елизавета on 11.04.2021.
//

import UIKit

extension UIFont {

    enum Family {
        case rubik(Style)
    }
    enum Style {
        case regular
        case medium
    }

    static func font(family: Family, size: CGFloat) -> UIFont {
        let fontName: String

        switch family {
        case .rubik(let style):
            switch style {
            case .regular:
                fontName = "Rubik-Regular"
            case .medium:
                fontName = "Rubik-Medium"
            }
        }

        guard let font = UIFont(name: fontName, size: size) else { preconditionFailure("No font for '\(fontName)'") }
        return font
    }
}
