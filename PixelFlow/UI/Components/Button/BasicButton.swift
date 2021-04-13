//
//  BasicButton.swift
//  PixelFlow
//
//  Created by Елизавета on 11.04.2021.
//

import UIKit

class BasicButton: UIButton {
    typealias Touch = (UIButton)
    let touch = Delegated<Touch, Void>()

    override var isHighlighted: Bool {
        didSet {
            updateSelectionState()
        }
    }

    override var isSelected: Bool {
        didSet {
            updateSelectionState()
        }
    }

    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1 : 0.45
        }
    }

    fileprivate func updateSelectionState() {
        alpha = isHighlighted ? 0.65 : 1
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    private func commonInit() {
        let selector = #selector(type(of: self).buttonTouchAction(_:))
        addTarget(self, action: selector, for: .touchUpInside)
    }

    @objc
    func buttonTouchAction(_ sender: Any) {
        touch.call(self)
    }

    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let rect = super.titleRect(forContentRect: contentRect)
        return rect.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }
}
