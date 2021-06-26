//
//  ColorPicker.swift
//  PixelFlow
//
//  Created by Елизавета on 12.05.2021.
//

import UIKit

class ColorPickerView: UIView {
    let overlayView = UIView()
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.PF.background
        view.layer.cornerRadius = 10
        return view
    }()

    var colorViews: [Button] = []
    var colorViewAction: (_ dayType: DayType) -> Void = { _ in }
    var selectedColor: UIColor?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        addSubview(overlayView)
        overlayView.layout.all.equal(to: self)
        // isUserInteractionEnabled = true

        addSubview(backgroundView)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleOverlayTap(_:)))
        overlayView.addGestureRecognizer(recognizer)
        backgroundView.layout.center.equal(to: self)
        createColors()
    }

    private func createColors() {
        let topStack = UIStackView()
        topStack.axis = .horizontal
        topStack.distribution = .fillEqually
        topStack.alignment = .center
        topStack.spacing = 12

        backgroundView.addSubview(topStack)
        topStack.layout.horizontal.equal(to: backgroundView, offset: 25)
        topStack.layout.top.equal(to: backgroundView, offset: 38)

        let bottomStack = UIStackView()
        bottomStack.axis = .horizontal
        bottomStack.distribution = .fill
        bottomStack.alignment = .center
        bottomStack.spacing = 12
        backgroundView.addSubview(bottomStack)
        bottomStack.layout.centerX.equal(to: backgroundView)
        bottomStack.layout.top.equal(to: topStack.layout.bottom, offset: 22)
        bottomStack.layout.bottom.equal(to: backgroundView, offset: -38)

        var count2 = 0
        UIColor.colorScheme.allValues.forEach { color in
            let view = Button(type: .bulging)
            view.layout.size.equal(to: CGSize(width: 40, height: 40))
            view.mainColor = color.color.cgColor
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleColorTap(_:))))
            if count2 < 5 {
                topStack.addArrangedSubview(view)
            } else {
                bottomStack.addArrangedSubview(view)
            }
            count2 += 1
        }
    }

    @objc
    func handleOverlayTap(_ sender: UITapGestureRecognizer? = nil) {
        removeFromSuperview()
    }

    @objc
    func handleColorTap(_ sender: UITapGestureRecognizer? = nil) {
        guard let view = sender?.view as? Button else { return }
         selectedColor = UIColor(cgColor: view.mainColor)
        let type: DayType = ThemeHelper.convertColorToType(for: .base, color: selectedColor ?? .blue)
            colorViewAction(type)
            removeFromSuperview()
        }
}

