//
//  ColorInfoItem.swift
//  PixelFlow
//
//  Created by Elizaveta on 4/24/21.
//

import UIKit

class ColorInfoItem: UIView {
    var isSelected = false
    var color: UIColor = UIColor.PF.background
    private let colorView: SoftUIView = {
        let button = Button(type: .bulging)
        button.layout.height.equal(to: 43)
        button.layout.width.equal(to: 40)
        return button
    }()
    var infoLabel = Label(type: .regularInfo)
    
    convenience init(color: UIColor, text: String) {
        self.init()
        self.color = color
        colorView.mainColor = color.cgColor
        infoLabel.text = text
        addSubview(colorView)
        colorView.layout.left.equal(to: self)
        colorView.layout.vertical.equal(to: self)
        
        addSubview(infoLabel)
        infoLabel.layout.left.equal(to: colorView.layout.right, offset: 16)
        infoLabel.layout.vertical.equal(to: colorView)
        infoLabel.layout.right.equal(to: self)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        colorView.addGestureRecognizer(recognizer)
    }

    @objc
    func handleTap(_ sender: UITapGestureRecognizer? = nil) {

        print("DAY DAY DAY ")
    }
}
