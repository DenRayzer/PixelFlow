//
//  NoteInputView.swift
//  PixelFlow
//
//  Created by Elizaveta on 4/25/21.
//

import UIKit

class NoteInputView: TextInputView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
        print("vvvv")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        minHeight = 45
        placeholder = "ghbgodkgdfojb gdg g"
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.PF.stroke.cgColor
        backgroundColor = .clear
    }
}
