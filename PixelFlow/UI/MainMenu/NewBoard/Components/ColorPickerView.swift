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
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleAddNoteButtonTap(_:)))
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

        var count = 0
        UIColor.colorScheme.allValues.forEach { color in
            let view = Button(type: .bulging)
            view.layout.size.equal(to: CGSize(width: 40, height: 40))
            view.mainColor = color.cgColor
            if count < 5 {
                topStack.addArrangedSubview(view)
            } else {
                bottomStack.addArrangedSubview(view)
            }
            count += 1
        }
    }

    @objc
    func handleAddNoteButtonTap(_ sender: UITapGestureRecognizer? = nil) {
        print("vcvcv")
        removeFromSuperview()
    }
}

