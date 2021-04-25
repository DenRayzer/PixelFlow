//
//  Header.swift
//  PixelFlow
//
//  Created by Елизавета on 11.04.2021.
//

import UIKit

class Header: UIView {
    private(set) var headerHeight: CGFloat = 44
    private(set) var leftButton: SoftUIView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "LeftArrow"))
        let button = Button(type: .bulging, view: imageView)
        button.layout.height.equal(to: 43)
        button.layout.width.equal(to: 43)
        return button
    }()
    
    private(set) var rightButton: SoftUIView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        let button = Button(type: .bulging, view: imageView)
        button.layout.height.equal(to: 43)
        button.layout.width.equal(to: 43)
        return button
    }()

    private(set) var titleButton: TextButton = {
        let button = TextButton(type: .default(UIColor.PF.regularText, .font(family: .rubik(.regular), size: 22), .center, 1),
                                textMode: .uppercase,
                                text: "2021")
        button.titleLabel?.adjustsFontSizeToFitWidth = true

        return button
    }()

    override func draw(_ rect: CGRect) {
        addSubview(titleButton)
        titleButton.layout.center.equal(to: self)

        addSubview(leftButton)
        leftButton.layout.left.equal(to: self, offset: CGFloat(mainHorizontalMargin))
        leftButton.layout.centerY.equal(to: self)

        addSubview(rightButton)
        rightButton.layout.right.equal(to: self, offset: -CGFloat(mainHorizontalMargin))
        rightButton.layout.centerY.equal(to: self)
    }


    @objc func playTapHandler() {

    }

}
