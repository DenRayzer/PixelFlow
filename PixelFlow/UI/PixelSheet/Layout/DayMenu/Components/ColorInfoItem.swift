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

    convenience init(type: DayType) {
        self.init()
        self.type = type
        let info = DayTypeInfo.getDayInfo(for: type)
        color = info.color
        colorView.mainColor = color.cgColor
        infoLabel.text = info.text
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

class DayTypeInfo {
    static func getDayInfo(for type: DayType) -> (color: UIColor, text: String) {
        switch type {
        case .null:
            return (UIColor.PF.background, "Не выбрано")
        case .first:
            return (UIColor.colorScheme.lightGreen, "pf_day_mood_excellent".localize())
        case .second:
            return (UIColor.colorScheme.darkGreen, "pf_day_mood_good".localize())
        case .third:
            return (UIColor.colorScheme.pink, "pf_day_mood_lazy".localize())
        case .fourth:
            return (UIColor.colorScheme.orange, "pf_day_mood_ordinary".localize())
        case .fifth:
            return (UIColor.colorScheme.vinous, "pf_day_mood_bad".localize())
        case .sixth:
            return (UIColor.colorScheme.dustyRose, "pf_day_mood_tired".localize())
        case .seventh:
            return (UIColor.colorScheme.brown, "pf_day_mood_sick".localize())
        case .eighth:
            return (UIColor.PF.background, "Не выбрано")
        }
    }
}
