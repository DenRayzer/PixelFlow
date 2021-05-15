//
//  ImagePickerView.swift
//  PixelFlow
//
//  Created by Елизавета on 15.05.2021.
//

import UIKit

class ImagePickerView: UIView {
    typealias Color = (color: UIColor, name: String)
    let colorSheme: [Color] = [(UIColor.PF.accentColor, "-cyan"), (UIColor.PF.lilac, "-lilac"), (UIColor.colorScheme.orange, "-peach")]
    let imageNames: [String] = ["apple", "cart", "heart", "home", "leaves", "money", "pill", "settings", "smile", "yin-yang"]
    let overlayView = UIView()
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.PF.background
        view.layer.cornerRadius = 10
        return view
    }()

    var colorViews: [Button] = []
    var selectedColor: UIColor?

    let topImageStack = UIStackView()
    let bottomImageStack = UIStackView()
    var currentSheme: Color = (UIColor.PF.accentColor, "-cyan")
    var selectedImage: UIImage = #imageLiteral(resourceName: "yin-yang-cyan")
    var selectImageAction: (UIImage) -> Void = {_ in }

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
        topImageStack.axis = .horizontal
        topImageStack.distribution = .fillEqually
        topImageStack.alignment = .center
        topImageStack.spacing = 24

        backgroundView.addSubview(topImageStack)
        topImageStack.layout.horizontal.equal(to: backgroundView, offset: 25)
        topImageStack.layout.top.equal(to: backgroundView, offset: 38)


        bottomImageStack.axis = .horizontal
        bottomImageStack.distribution = .fill
        bottomImageStack.alignment = .center
        bottomImageStack.spacing = 24
        backgroundView.addSubview(bottomImageStack)
        bottomImageStack.layout.centerX.equal(to: backgroundView)
        bottomImageStack.layout.top.equal(to: topImageStack.layout.bottom, offset: 22)
        addImages()

        let separator = UIView()
        separator.layout.height.equal(to: 1)
        separator.backgroundColor = UIColor.PF.stroke
        addSubview(separator)
        separator.layout.top.equal(to: bottomImageStack.layout.bottom, offset: 25)
        separator.layout.horizontal.equal(to: backgroundView, offset: 35)

        let topStack = UIStackView()
        topStack.axis = .horizontal
        topStack.distribution = .fillEqually
        topStack.alignment = .center
        topStack.spacing = 16

        backgroundView.addSubview(topStack)
        topStack.layout.centerX.equal(to: backgroundView)
        topStack.layout.top.equal(to: separator.layout.bottom, offset: 25)

        let bottomStack = UIStackView()
        bottomStack.axis = .horizontal
        bottomStack.distribution = .fill
        bottomStack.alignment = .center
        bottomStack.spacing = 16

        backgroundView.addSubview(bottomStack)
        bottomStack.layout.centerX.equal(to: backgroundView)
        bottomStack.layout.top.equal(to: topStack.layout.bottom, offset: 22)
        bottomStack.layout.bottom.equal(to: backgroundView, offset: -38)



        var count2 = 0
        colorSheme.forEach { color in
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

    private func addImages() {
        var count = 0
        imageNames.forEach { name in
            let button = UIButton()
            //           button.layout.size.equal(to: CGSize(width: 35, height: 35))
            let str = name + currentSheme.name
            let im = UIImage(named: str)

            button.setImage(im, for: .normal)

            button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleImageTap(_:))))

            if count < 5 {
                topImageStack.addArrangedSubview(button)
            } else {
                bottomImageStack.addArrangedSubview(button)
            }
            count += 1
        }
    }

    @objc
    func handleOverlayTap(_ sender: UITapGestureRecognizer? = nil) {
        removeFromSuperview()
    }

    @objc
    func handleImageTap(_ sender: UITapGestureRecognizer? = nil) {
        guard let button = sender?.view as? UIButton,
              let image = button.imageView?.image else { return }
        selectImageAction(image)
        removeFromSuperview()
    }

    @objc
    func handleColorTap(_ sender: UITapGestureRecognizer? = nil) {

        guard let view = sender?.view as? Button else { return }
        let selectedColor = UIColor(cgColor: view.mainColor)
        colorSheme.forEach { color in
            if color.color == selectedColor {
                currentSheme = color
                topImageStack.subviews.forEach { $0.removeFromSuperview() }
                bottomImageStack.subviews.forEach { $0.removeFromSuperview() }
                addImages()
            }
        }

    }
}
