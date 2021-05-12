//
//  Toggle.swift
//  PixelFlow
//
//  Created by Елизавета on 11.05.2021.
//

import UIKit

class Toggle: UIControl {

    typealias ValueChanged = (toggle: Toggle, isOn: Bool)
    let valueChanged = Delegated<ValueChanged, Void>()
    weak var delegate: ToggleDelegate?

    var isOn: Bool = false {
        didSet {
            self.updateIsOn(old: oldValue)
        }
    }

    private lazy var backgroundLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = rgb(230, 230, 230).cgColor
        return layer
    }()

    private lazy var gradientLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.PF.accentColor.cgColor
        return layer
    }()

    private lazy var thumbLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.white.cgColor
        return layer
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.commonInit()
    }

    private func commonInit() {
        self.clipsToBounds = true
        self.layer.addSublayer(self.backgroundLayer)
        self.layer.addSublayer(self.gradientLayer)
        self.layer.addSublayer(self.thumbLayer)
        self.updateIsOn(old: self.isOn)

        let selector = #selector(type(of: self).tapGestureAction(_:))
        let tap = UITapGestureRecognizer(target: self, action: selector)
        self.addGestureRecognizer(tap)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = self.bounds.midY
        self.backgroundLayer.frame = self.bounds
        self.gradientLayer.frame = self.bounds
        self.gradientLayer.cornerRadius = self.bounds.midY

        let side = min(self.bounds.height, self.bounds.width) - 4
        self.thumbLayer.frame.size = CGSize(width: side, height: side)
        self.thumbLayer.cornerRadius = side / 2
        self.updateIsOn(old: self.isOn)
    }

    @objc func tapGestureAction(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            self.isOn = !self.isOn
            self.sendActions(for: .valueChanged)
            self.valueChanged.call((self, self.isOn))
            delegate?.tapGestureAction()
        }
    }

    private func frame(forState state: Bool) -> CGRect {
        let x = !state ? 2 : self.frame.width - self.thumbLayer.frame.width - 2
        return CGRect(origin: CGPoint(x: x, y: 2),
                      size: self.thumbLayer.frame.size)
    }

    func removeAnimations() {
        self.gradientLayer.removeAllAnimations()
        self.thumbLayer.removeAllAnimations()
        self.layer.removeAllAnimations()
    }

    private func updateIsOn(old: Bool) {

        if old == self.isOn {
            self.thumbLayer.frame = self.frame(forState: self.isOn)
            self.gradientLayer.isHidden = !self.isOn
            let scale: CGFloat = self.isOn ? 1 : 0
            self.gradientLayer.transform = CATransform3DMakeScale(scale, scale, 1)
        } else {
            let startScale: CGFloat = old ? 1 : 0
            let endScale: CGFloat = self.isOn ? 1 : 0

            self.gradientLayer.isHidden = false
            self.gradientLayer.transform = CATransform3DMakeScale(endScale, endScale, 1)
            self.thumbLayer.frame = self.frame(forState: self.isOn)

            CATransaction.begin()
            var animation = CABasicAnimation(keyPath: "frame")
            animation.duration = 0.3
            animation.isRemovedOnCompletion = true
            animation.fillMode = CAMediaTimingFillMode.forwards
            animation.fromValue = self.frame(forState: old)
            animation.toValue = self.frame(forState: self.isOn)
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            self.thumbLayer.add(animation, forKey: "frameAnimation")

            animation = CABasicAnimation(keyPath: "transform.scale")
            animation.duration = 0.15
            animation.isRemovedOnCompletion = true
            animation.fillMode = CAMediaTimingFillMode.forwards
            animation.fromValue = startScale
            animation.toValue = endScale
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            self.gradientLayer.add(animation, forKey: "transformAnimation")
            CATransaction.setCompletionBlock {
                self.gradientLayer.isHidden = !self.isOn
            }
            CATransaction.commit()
        }
    }
}

protocol ToggleDelegate: AnyObject {
    func tapGestureAction()
}

