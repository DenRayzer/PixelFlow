//
//  DottedDayView.swift
//  PixelFlow
//
//  Created by Elizaveta on 5/5/21.
//

import UIKit

class DottedDayView: UIView {
    let dottedView = UIView()
    let timeLabel = Label(type: .regularInfo, textMode: .default)
    
    let coloredView: Button = {
        let button = Button(type: .bulging)
        button.type = .normal
        button.isHidden = true
     //   button.layout.height.equal(to: 43)
     //   button.layout.width.equal(to: 43)
        button.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bounds = CGRect(x: 0, y: 0, width: 92, height: 35)
        configureColorView()
        addSubview(coloredView)
        
        addSubview(timeLabel)
        timeLabel.layout.centerY.equal(to: self)
        timeLabel.layout.left.equal(to: self)
        timeLabel.layout.right.equal(to: dottedView.layout.left, offset: -16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureColorView() {
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
        layout.size.equal(to: CGSize(width: 92, height: 35))
    }
    
    func changeColorView(with color: UIColor) {
     //   dottedView.removeFromSuperview()
        dottedView.isHidden = true
        coloredView.isHidden = false
        coloredView.mainColor = color.cgColor
        coloredView.layout.vertical.equal(to: self)
        coloredView.layout.right.equal(to: self)
        coloredView.layout.left.equal(to: timeLabel.layout.right, offset: 16)
    }
}
