//
//  UILayoutPriority.swift
//  PixelFlow
//
//  Created by Елизавета on 05.04.2021.
//

import UIKit

extension UILayoutPriority {

    static let maximum = UILayoutPriority(rawValue: 999)

    static let navigationMax = UILayoutPriority(rawValue: 999.9999)
    static let navigationMin = UILayoutPriority(rawValue: 000.0001)

    static let minimum = UILayoutPriority(rawValue: 1)

    static func required(offset: CGFloat = 0) -> UILayoutPriority {
        return UILayoutPriority(Float(900 + offset))
    }
}

extension NSLayoutConstraint {

    func prioritize(_ value: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = value
        return self
    }

    func deactivate() -> NSLayoutConstraint {
        self.isActive = false
        return self
    }

    func activate() -> NSLayoutConstraint {
        self.isActive = true
        return self
    }
}

extension UIEdgeInsets {

    init(side: CGFloat) {
        self.init(top: side, left: side, bottom: side, right: side)
    }

    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}

