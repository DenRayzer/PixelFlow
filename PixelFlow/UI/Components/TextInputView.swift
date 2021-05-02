//
//  TextInputView.swift
//  PixelFlow
//
//  Created by Elizaveta on 4/25/21.
//

import GrowingTextView
import UIKit

class TextInputView: GrowingTextView {
    let beginEditing = Delegated<TextInputView, Void>()
    let textDidChange = Delegated<TextInputView, Void>()
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = UIColor.PF.background
        tintColor = UIColor.PF.accentColor
        textColor = UIColor.PF.regularText
        font = UIFont.font(family: .rubik(.regular), size: 14)
        textContainerInset = UIEdgeInsets(horizontal: 10, vertical: 10)
        inputAccessoryView = KeyboardCloser()

        keyboardType = .default
        returnKeyType = .default

        delegate = self
    }

    func setHeight(with value: CGFloat) {
        minHeight = value
        maxHeight = value
    }
}

extension TextInputView: GrowingTextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView === self else { return }
        beginEditing.call(self)
    }

    func textViewDidChange(_ textView: UITextView) {
        guard textView === self else { return }
        textDidChange.call(self)
    }
}
