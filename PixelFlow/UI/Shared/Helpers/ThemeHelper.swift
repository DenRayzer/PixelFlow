//
//  ThemeHelper.swift
//  PixelFlow
//
//  Created by Елизавета on 23.05.2021.
//

import UIKit

enum DayType: Int16 {
    case null = 0, first, second, third, fourth, fifth, sixth, seventh, eighth

    static var allCases = [null, first, second, third, fourth, fifth, sixth, seventh, eighth]
}

enum ColorShemeType: Int16 {
    case base = 0

    static var allCases = [base]
}

class ThemeHelper {
    static var currentBoard: Board?

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
            return UIColor.colorScheme.pink
        case .fourth:
            return UIColor.colorScheme.orange
        case .fifth:
            return UIColor.colorScheme.vinous
        case .sixth:
            return UIColor.colorScheme.dustyRose
        case .seventh:
            return UIColor.colorScheme.brown
        case .eighth:
            return UIColor.PF.background
        }
    }

    static func convertIntToColor(for colorScheme: Int16, colorType: Int16) -> UIColor? {
        guard let sheme = ColorShemeType(rawValue: colorScheme),
            let type = DayType(rawValue: colorType) else { return nil }
        return convertTypeToColor(for: sheme, type: type)
    }

    static func convertColorToType(for colorSheme: ColorShemeType, color: UIColor) -> DayType {
        switch colorSheme {
        case .base:
            return getBaseType(for: color)
        }
    }

    static private func getBaseType(for color: UIColor) -> DayType {
        switch color {
        case UIColor.colorScheme.lightGreen:
            return .first
        case UIColor.colorScheme.darkGreen:
            return .second
        case UIColor.colorScheme.pink:
            return .third
        case UIColor.colorScheme.orange:
            return .fourth
        case UIColor.colorScheme.vinous:
            return .fifth
        case UIColor.colorScheme.dustyRose:
            return .sixth
        case UIColor.colorScheme.brown:
            return .seventh
        default:  return .null
        }
    }
}

typealias Color = (color: UIColor, name: String, id: Int16)
enum BoardColor {
    case cyan
    case lilac
    case peach

    static let allValues = [cyan, lilac, peach]
}

extension BoardColor: RawRepresentable {
    init?(rawValue: Color) {
        switch rawValue {
        case (color: UIColor.PF.accentColor, "-cyan", id: 0): self = .cyan
        case (color: UIColor.PF.lilac, "-lilac", id: 1): self = .lilac
        case (UIColor.colorScheme.orange, "-peach", id: 2): self = .peach
        default: return nil
        }
    }

    var rawValue: Color {
        switch self {
        case .cyan:
            return (color: UIColor.PF.accentColor, "-cyan", id: 0)
        case .lilac:
            return (color: UIColor.PF.lilac, "-lilac", id: 1)
        case .peach:
            return (UIColor.colorScheme.orange, "-peach", id: 2)
        }
    }
}
