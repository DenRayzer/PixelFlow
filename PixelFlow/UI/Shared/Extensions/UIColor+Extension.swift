//
//  UIColor+Extension.swift
//  PixelFlow
//
//  Created by Елизавета on 04.04.2021.
//

import UIKit

extension UIColor {
    enum PF {
        static let stroke = rgb(212, 212, 221)
        static let background = rgb(240, 240, 243)
        static let darkShadow = rgb( 174, 174, 192)
        static let regularText = rgb( 128, 139, 159)
        static let accentColor = rgb( 131, 219, 214)
    }

    enum colorScheme {
        static let lightGreen = rgb(160, 217, 147)
        static let darkGreen = rgb(17, 128, 135)
        static let pink = rgb(212, 212, 221)
        static let orange = rgb(244, 195, 150)
        static let vinous = rgb(182, 46, 81)
        static let dustyRose = rgb(163, 129, 162)
        static let brown = rgb(88, 50, 78)
    }
}

func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
    return rgba(r, g, b, 1)
}

func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}


extension UIColor {
    public convenience init(RGB: Int) {
        var rgb = RGB
        rgb = rgb > 0xffffff ? 0xffffff : rgb
        let r = CGFloat(rgb >> 16) / 255.0
        let g = CGFloat(rgb >> 8 & 0x00ff) / 255.0
        let b = CGFloat(rgb & 0x0000ff) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    public func getTransformedColor(saturation: CGFloat, brightness: CGFloat) -> UIColor {
        var hsb = getHSBColor()
        hsb.s *= saturation
        hsb.b *= brightness
        if hsb.s > 1 { hsb.s = 1 }
        if hsb.b > 1 { hsb.b = 1 }
        return hsb.uiColor
    }
    private func getHSBColor() -> HSBColor {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return HSBColor(h: h, s: s, b: b, alpha: a)
    }
}

private struct HSBColor {
    var h: CGFloat
    var s: CGFloat
    var b: CGFloat
    var alpha: CGFloat
    init(h: CGFloat, s: CGFloat, b: CGFloat, alpha: CGFloat) {
        self.h = h
        self.s = s
        self.b = b
        self.alpha = alpha
    }
    var uiColor: UIColor {
        get {
            return UIColor(hue: h, saturation: s, brightness: b, alpha: alpha)
        }
    }
}
