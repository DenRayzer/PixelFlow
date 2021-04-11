//
//  UIColor+Extension.swift
//  PixelFlow
//
//  Created by Елизавета on 04.04.2021.
//

import UIKit

extension UIColor {
    enum PF {
        static let stroke = rgb(224, 224, 231)
        static let background = rgb(240, 240, 243)
    }
}

func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
    return rgba(r, g, b, 1)
}

func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}
