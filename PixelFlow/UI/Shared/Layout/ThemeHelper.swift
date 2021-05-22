//
//  ThemeHelper.swift
//  PixelFlow
//
//  Created by Елизавета on 23.05.2021.
//

import UIKit

enum DayType: Int {
    case null = 1, first, second, third, fourth, fifth, sixth, seventh, eighth
}

enum ColorShemeType: Int {
    case base = 0
}

class ThemeHelper {
    static func convertTypeToColor(for colorSheme: ColorShemeType, type: DayType) -> UIColor {
        switch colorSheme {
        case .base:
            return getBaseColor(for: type)
        }
    }

    static private func getBaseColor(for type: DayType) -> UIColor {
        switch type {
        case .null:
           return UIColor.PF.background
        case .first:
           return UIColor.colorScheme.lightGreen
        case .second:
           return UIColor.colorScheme.darkGreen
        case .third:
            return  UIColor.colorScheme.pink
        case .fourth:
            return  UIColor.colorScheme.orange
        case .fifth:
            return  UIColor.colorScheme.vinous
        case .sixth:
            return  UIColor.colorScheme.dustyRose
        case .seventh:
            return  UIColor.colorScheme.brown
        case .eighth:
            return UIColor.PF.background
        }
    }
}
