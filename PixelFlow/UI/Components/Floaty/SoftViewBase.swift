//
//  SoftViewBase.swift
//  PixelFlow
//
//  Created by Elizaveta on 5/8/21.
//

import UIKit

open class SoftViewBase: UIView {
    private var backgroundLayer: CALayer!
    private var darkOuterShadowLayer: CAShapeLayer!
    private var lightOuterShadowLayer: CAShapeLayer!
    private var darkInnerShadowLayer: CAShapeLayer!
    private var lightInnerShadowLayer: CAShapeLayer!
    
    private var contentView: UIView?
    private var selectedContentView: UIView?
    private var selectedTransform: CGAffineTransform?
    
    var isSelected: Bool = false {
        didSet {
            updateShadowLayers()
            updateContentView()
        }
    }

    open var type: SoftUIViewType = .pushButton {
        didSet { updateShadowLayers() }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        createSubLayers()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        createSubLayers()
    }

    open var mainColor: CGColor = SoftUIView.defalutMainColorColor {
        didSet { updateMainColor() }
    }

    open var darkShadowColor: CGColor = SoftUIView.defalutDarkShadowColor {
        didSet { updateDarkShadowColor() }
    }

    open var lightShadowColor: CGColor = SoftUIView.defalutLightShadowColor {
        didSet { updateLightShadowColor() }
    }

    open var shadowOffset: CGSize = SoftUIView.defalutShadowOffset {
        didSet { updateShadowOffset() }
    }

    open var shadowOpacity: Float = SoftUIView.defalutShadowOpacity {
        didSet { updateShadowOpacity() }
    }

    open var shadowRadius: CGFloat = SoftUIView.defalutShadowRadius {
        didSet { updateShadowRadius() }
    }

    open var cornerRadius: CGFloat = SoftUIView.defalutCornerRadius {
        didSet { updateSublayersShape() }
    }

    override open var bounds: CGRect {
        didSet { updateSublayersShape() }
    }

//    open override var isSelected: Bool {
//        didSet {
//            updateShadowLayers()
//            updateContentView()
//        }
//    }

    func updateMainColor() {
        backgroundLayer.backgroundColor = mainColor
        darkOuterShadowLayer.fillColor = mainColor
        lightOuterShadowLayer.fillColor = mainColor
        darkInnerShadowLayer.fillColor = mainColor
        lightInnerShadowLayer.fillColor = mainColor
    }

    func updateDarkShadowColor() {
        darkOuterShadowLayer.shadowColor = darkShadowColor
        darkInnerShadowLayer.shadowColor = darkShadowColor
    }

    func updateLightShadowColor() {
        lightOuterShadowLayer.shadowColor = lightShadowColor
        lightInnerShadowLayer.shadowColor = lightShadowColor
    }

    func updateShadowOffset() {
        darkOuterShadowLayer.shadowOffset = shadowOffset
        lightOuterShadowLayer.shadowOffset = shadowOffset.inverse
        darkInnerShadowLayer.shadowOffset = shadowOffset
        lightInnerShadowLayer.shadowOffset = shadowOffset.inverse
    }

    func updateShadowOpacity() {
        darkOuterShadowLayer.shadowOpacity = shadowOpacity
        lightOuterShadowLayer.shadowOpacity = shadowOpacity
        darkInnerShadowLayer.shadowOpacity = shadowOpacity
        lightInnerShadowLayer.shadowOpacity = shadowOpacity
    }

    func updateShadowRadius() {
        darkOuterShadowLayer.shadowRadius = shadowRadius
        lightOuterShadowLayer.shadowRadius = shadowRadius
        darkInnerShadowLayer.shadowRadius = shadowRadius
        lightInnerShadowLayer.shadowRadius = shadowRadius
    }

//    func updateShadowLayers() {
//        darkOuterShadowLayer.isHidden = isSelected
//        lightOuterShadowLayer.isHidden = isSelected
//        darkInnerShadowLayer.isHidden = !isSelected
//        lightInnerShadowLayer.isHidden = !isSelected
//    }

    func updateSublayersShape() {
        backgroundLayer.frame = bounds
        backgroundLayer.cornerRadius = cornerRadius

        darkOuterShadowLayer.path = createOuterShadowPath()
        lightOuterShadowLayer.path = createOuterShadowPath()

        darkInnerShadowLayer.path = createInnerShadowPath()
        darkInnerShadowLayer.mask = createInnerShadowMask()

        lightInnerShadowLayer.path = createInnerShadowPath()
        lightInnerShadowLayer.mask = createInnerShadowMask()
    }

    func createOuterShadowPath() -> CGPath {
        return UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    }

    func createInnerShadowLayer(shadowColor: CGColor, shadowOffset: CGSize) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.backgroundColor = UIColor.clear.cgColor
        layer.fillColor = mainColor
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.fillRule = .evenOdd
        return layer
    }

    func createInnerShadowMask() -> CALayer {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        return layer
    }

    func createInnerShadowPath() -> CGPath {
        let path = UIBezierPath(roundedRect: bounds.insetBy(dx: -100, dy: -100), cornerRadius: cornerRadius)
        path.append(UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius))
        return path.cgPath
    }

    override open var backgroundColor: UIColor? {
        get { .clear }
        set { }
    }

    func createOuterShadowLayer(shadowColor: CGColor, shadowOffset: CGSize) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.backgroundColor = UIColor.clear.cgColor
        layer.fillColor = mainColor
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        return layer
    }

    func createSubLayers() {
        lightOuterShadowLayer = {
            let shadowLayer = createOuterShadowLayer(shadowColor: lightShadowColor, shadowOffset: shadowOffset.inverse)
            layer.addSublayer(shadowLayer)
            return shadowLayer
        }()

        darkOuterShadowLayer = {
            let shadowLayer = createOuterShadowLayer(shadowColor: darkShadowColor, shadowOffset: shadowOffset)
            layer.addSublayer(shadowLayer)
            return shadowLayer
        }()

        backgroundLayer = {
            let backgroundLayer = CALayer()
            layer.addSublayer(backgroundLayer)
            backgroundLayer.frame = bounds
            backgroundLayer.cornerRadius = cornerRadius
            backgroundLayer.backgroundColor = mainColor
            return backgroundLayer
        }()

        darkInnerShadowLayer = {
            let shadowLayer = createInnerShadowLayer(shadowColor: darkShadowColor, shadowOffset: shadowOffset)
            layer.addSublayer(shadowLayer)
            shadowLayer.isHidden = true
            return shadowLayer
        }()

        lightInnerShadowLayer = {
            let shadowLayer = createInnerShadowLayer(shadowColor: lightShadowColor, shadowOffset: shadowOffset.inverse)
            layer.addSublayer(shadowLayer)
            shadowLayer.isHidden = true
            return shadowLayer
        }()

        updateSublayersShape()
    }
    
    func updateShadowLayers() {
        darkOuterShadowLayer.isHidden = isSelected
        lightOuterShadowLayer.isHidden = isSelected
        darkInnerShadowLayer.isHidden = !isSelected
        lightInnerShadowLayer.isHidden = !isSelected
    }
    
    func updateContentView() {
        if isSelected, selectedContentView != nil {
            showSelectedContentView()
        } else if isSelected, selectedTransform != nil {
            showSelectedTransform()
        } else {
            showContentView()
        }
    }
    
    func showContentView() {
        contentView?.isHidden = false
        contentView?.transform = .identity
        selectedContentView?.isHidden = true
    }

    func showSelectedContentView() {
        contentView?.isHidden = true
        contentView?.transform = .identity
        selectedContentView?.isHidden = false
    }

    func showSelectedTransform() {
        contentView?.isHidden = false
        selectedTransform.map { contentView?.transform = $0 }
        selectedContentView?.isHidden = true
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch type {
        case .pushButton:
            isSelected = true
        case .toggleButton:
            isSelected = !isSelected
        case .normal:
            break
        }
        super.touchesBegan(touches, with: event)
    }

//    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        switch type {
//        case .pushButton:
//            isSelected = !isSelected//isTracking
//        case .normal, .toggleButton:
//            break
//        }
//        super.touchesMoved(touches, with: event)
//    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch type {
        case .pushButton:
            isSelected = false
        case .normal, .toggleButton:
            break
        }
        super.touchesEnded(touches, with: event)
    }

    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch type {
        case .pushButton:
            isSelected = false
        case .normal, .toggleButton:
            break
        }
        super.touchesCancelled(touches, with: event)
    }
    
}
