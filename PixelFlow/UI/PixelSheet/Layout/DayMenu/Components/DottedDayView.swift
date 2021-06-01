//
//  DottedDayView.swift
//  PixelFlow
//
//  Created by Elizaveta on 5/5/21.
//

import UIKit

class DottedDayView: UIView {
    let dottedView = UIView()
    let timeLabel: Label = Label(type: .regularInfo, textMode: .default)
    let type: DayType = .null
    let date: Date = Date()
    
    let coloredView: Button = {
        let button = Button(type: .bulging)
        button.type = .normal
        button.isHidden = true
        button.layout.size.equal(to: CGSize(width: 35, height: 35))
        return button
    }()

    convenience init(isDotted: Bool, type: DayType = .null, date: Date = Date()) {
        self.init()

        addSubview(coloredView)
        coloredView.layout.vertical.equal(to: self)
        coloredView.layout.right.equal(to: self)

        addSubview(timeLabel)
        timeLabel.layout.centerY.equal(to: self)
        timeLabel.layout.left.equal(to: self)
        timeLabel.text = date.getString(with: "HH:mm")
        timeLabel.layout.right.equal(to: coloredView.layout.left, offset: -16)
        
        if isDotted {
            configureDottedView()
        } else {
            changeColorView(with: type)
        }
    }

    private func configureDottedView() {
        dottedView.layout.size.equal(to: CGSize(width: 35, height: 35))
        let layer = CAShapeLayer()
        let bounds = CGRect(x: 0, y: 0, width: 35, height: 35)
        layer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 5, height: 5)).cgPath
        layer.strokeColor = UIColor.PF.accentColor.cgColor
        layer.fillColor = nil
        layer.lineDashPattern = [8, 6]
        dottedView.layer.addSublayer(layer)
        
        let animation = CABasicAnimation(keyPath: "lineDashPhase")
        animation.fromValue = 0
        animation.toValue = layer.lineDashPattern?.reduce(0) { $0 - $1.intValue } ?? 0
        animation.duration = 1
        animation.repeatCount = .infinity
        layer.add(animation, forKey: "line")
        
        addSubview(dottedView)
        dottedView.layout.vertical.equal(to: self)
        dottedView.layout.right.equal(to: self)
    }
    
    func changeColorView(with dayType: DayType) {
        let color = ThemeHelper.convertTypeToColor(for: Constants.currentBoardColorSheme, type: dayType)
        dottedView.isHidden = true
        coloredView.isHidden = false
        coloredView.mainColor = color.cgColor
    }
}
