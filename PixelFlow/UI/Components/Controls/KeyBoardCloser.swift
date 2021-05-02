//
//  KeyBoardCloser.swift
//  PixelFlow
//
//  Created by Elizaveta on 4/25/21.
//

import UIKit

class KeyboardCloser: UIView {

    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        self.commonInit()
    }

    private func commonInit() {
        self.backgroundColor = .white

        var separator = UIView()
        separator.backgroundColor = .lightGray
        self.addSubview(separator)
        separator.layout.top.equal(to: self.layout.top)
        separator.layout.left.equal(to: self.layout.left)
        separator.layout.right.equal(to: self.layout.right)
        separator.layout.height.equal(to: 0.5)

        separator = UIView()
        separator.backgroundColor = .lightGray
        self.addSubview(separator)
        separator.layout.bottom.equal(to: self.layout.bottom)
        separator.layout.left.equal(to: self.layout.left)
        separator.layout.right.equal(to: self.layout.right)
        separator.layout.height.equal(to: 0.5)

        let button = TextButton(type: .title, text: "close".localize())
        let selector = #selector(type(of: self).closeAction(_:))
        button.addTarget(self, action: selector, for: .touchUpInside)
        self.addSubview(button)
        button.layout.centerY.equal(to: self.layout.centerY)
        button.layout.right.equal(to: self.layout.right, offset: -16)
        button.layout.height.equal(to: 40)
    }

    @objc final func closeAction(_ button: UIButton) {
        UIApplication.shared
            .delegate?
            .window??
            .endEditing(true)
    }
}
