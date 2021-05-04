//
//  Label.swift
//  PixelFlow
//
//  Created by Елизавета on 11.04.2021.
//

import UIKit

class Label: UILabel {
    enum LabelTextMode {
        case `default`
        case uppercase
        case lowercase
    }

    enum LabelType {
        case custom
        case `default`(UIColor, UIFont, NSTextAlignment, Int)
    }

    private(set) var textMode: LabelTextMode = .default

    override var text: String? {
        set {
            super.text = self.textForLabel(from: newValue)
        }
        get {
            return super.text
        }
    }

    convenience init(type: LabelType,
                     textMode: LabelTextMode = .default,
                     text: String? = nil) {
        self.init()

        commonInit(type: type, textMode: textMode, text: text)
    }

    private func commonInit(type: LabelType, textMode: LabelTextMode, text: String?) {
        self.textMode = textMode
        self.text = text

        if case let .default(color, font, alignment, numberOfLines) = type {
            self.textColor = color
            self.font = font
            self.textAlignment = alignment
            self.numberOfLines = numberOfLines
        }
    }

    private func textForLabel(from text: String?) -> String? {
        switch textMode {
        case .default:
            return text
        case .uppercase:
            return text?.uppercased()
        case .lowercase:
            return text?.lowercased()
        }
    }
}

extension Label.LabelType {
    static let title = Label.LabelType
        .default(UIColor.PF.regularText,
                 .font(family: .rubik(.medium), size: 18),
                 .left, 1)
    static let regularInfo = Label.LabelType
        .default(UIColor.PF.regularText,
                 .font(family: .rubik(.regular), size: 16),
                 .left, 1)
    static let smallText = Label.LabelType
        .default(UIColor.PF.regularText,
                 .font(family: .rubik(.regular), size: 11),
                 .center, 1)
}
