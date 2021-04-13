//
//  TextButton.swift
//  PixelFlow
//
//  Created by Елизавета on 11.04.2021.
//

import UIKit

class TextButton: BasicButton {

    private var textMode: Label.LabelTextMode = .default

    convenience init(type: Label.LabelType, textMode: Label.LabelTextMode = .default, text: String?) {
        self.init(type: .custom)

        self.textMode = textMode
        commonInit(type: type, text: text)
    }

    private func commonInit(type: Label.LabelType, text: String?) {
        setTitle(text, for: .normal)

        titleLabel?.lineBreakMode = .byTruncatingTail

        if case .default(let color, let font, let alignment, let numberOfLines) = type {
            self.setTitleColor(color, for: .normal)
            self.titleLabel?.font = font
            self.titleLabel?.numberOfLines = numberOfLines

            switch alignment {
            case .center:
                self.contentHorizontalAlignment = .center
            case .left:
                self.contentHorizontalAlignment = .left
            case .right:
                self.contentHorizontalAlignment = .right
            case .justified, .natural:
                self.contentHorizontalAlignment = .fill
                @unknown default:
                return
            }

            self.titleLabel?.textAlignment = alignment
        }
    }

    override func setTitle(_ title: String?, for state: UIControl.State) {
        var text: String?

        switch textMode {
        case .default:
            text = title
        case .uppercase:
            text = title?.uppercased()
        case .lowercase:
            text = title?.lowercased()
        }

        super.setTitle(text, for: state)
    }
}

class MHSoftUIButton: UIButton {

    override open var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                 setState()
            } else {
                 resetState()
            }
        }
    }

    override open var isEnabled: Bool {
        didSet{
            if isEnabled == false {
                setState()
            } else {
                resetState()
            }
        }
    }

    func setState(){
        self.layer.shadowOffset = CGSize(width: -2, height: -2)
        self.layer.sublayers?[0].shadowOffset = CGSize(width: 2, height: 2)
        self.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 0, right: 0)
    }

    func resetState(){
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.sublayers?[0].shadowOffset = CGSize(width: -2, height: -2)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 2)
    }

    public func addSoftUIEffectForButton(cornerRadius: CGFloat = 15.0, themeColor: UIColor = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1.0)) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize( width: 2, height: 2)
        self.layer.shadowColor = UIColor(red: 223/255, green: 228/255, blue: 238/255, alpha: 1.0).cgColor

        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = bounds
        shadowLayer.backgroundColor = themeColor.cgColor
        shadowLayer.shadowColor = UIColor.white.cgColor
        shadowLayer.cornerRadius = cornerRadius
        shadowLayer.shadowOffset = CGSize(width: -2.0, height: -2.0)
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 2
        self.layer.insertSublayer(shadowLayer, below: self.imageView?.layer)
    }
}
