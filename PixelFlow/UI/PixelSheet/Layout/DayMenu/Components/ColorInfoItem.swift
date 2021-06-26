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
    var type: DayType = .null

    let colorView: Button = {
        let button = Button(type: .bulging)
        button.layout.height.equal(to: 43)
        button.layout.width.equal(to: 40)
        return button
    }()

    var infoLabel = Label(type: .regularInfo)

    convenience init(parameter: BoardParameter) {
        self.init()
        self.type = parameter.color

        color = ThemeHelper.convertTypeToColor(for: ThemeHelper.currentBoard?.colorSheme ?? .base, type: parameter.color) //info.color
        colorView.mainColor = color.cgColor
        infoLabel.text = parameter.name
        addSubview(colorView)
        colorView.layout.left.equal(to: self, offset: 16)
        colorView.layout.vertical.equal(to: self)

        addSubview(infoLabel)
        infoLabel.layout.left.equal(to: colorView.layout.right, offset: 16)
        infoLabel.layout.vertical.equal(to: colorView)
        infoLabel.layout.right.equal(to: self)
    }

    func setSelected() {
        colorView.addView(view: UIImageView(image: #imageLiteral(resourceName: "check")), selectedView: nil)
        isSelected = true
    }

    private func setData() {
    }
}


