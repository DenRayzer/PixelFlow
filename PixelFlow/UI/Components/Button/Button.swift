//
//  Button.swift
//  PixelFlow
//
//  Created by Елизавета on 11.04.2021.
//

import UIKit

class Button: SoftUIView {
    enum CustomType {
        case custom
        case floating
        case bulging
    }

    convenience init(type: Button.CustomType, view: UIView? = nil, selectedView: UIView? = nil) {
        self.init()

        commonInit(type: type, view: view, selectedView: selectedView)
    }

    private func commonInit(type: Button.CustomType, view: UIView?, selectedView: UIView?) {
        mainColor = UIColor.PF.background.cgColor

        layer.masksToBounds = false

        addView(view: view, selectedView: selectedView)

        switch type {
        case .custom:
            break
        case .floating:
            configureFloatingButton()
        case .bulging:
            configureBulgingButton()
        }

    }
    
    func addView(view: UIView?, selectedView: UIView? = nil) {
        view?.translatesAutoresizingMaskIntoConstraints = false
        selectedView?.translatesAutoresizingMaskIntoConstraints = false
        setContentView(view, selectedContentView: selectedView)
        view?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        view?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        selectedView?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        selectedView?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    

    func configureBulgingButton() {
        cornerRadius = 10
        lightShadowColor = UIColor.white.cgColor
        darkShadowColor = UIColor.PF.darkShadow.withAlphaComponent(0.4).cgColor
        shadowOffset = .init(width: 2, height: 2)
        shadowRadius = 3
    }

    func configureFloatingButton() {
        cornerRadius = 16
        shadowRadius = 12
        lightShadowColor = UIColor.white.cgColor
        darkShadowColor = UIColor.PF.darkShadow.withAlphaComponent(0.5).cgColor
        shadowOffset = .init(width: 10, height: 10)
    }

}

/*
 playView.type = .pushButton
 playView.addTarget(self, action: #selector(playTapHandler), for: .touchDown)
 playView.cornerRadius = 10
 playView.mainColor = UIColor.PF.background.cgColor
 let playIcon = UIImage(systemName: "play.fill")
 let playImageView = UIImageView(image: playIcon)
 playImageView.translatesAutoresizingMaskIntoConstraints = false
 playImageView.tintColor = .darkGray
 playView.lightShadowColor = UIColor.white.cgColor
 playView.darkShadowColor = UIColor.PF.darkShadow.withAlphaComponent(0.4).cgColor
//   playView.shadowOpacity = 0.4
 playView.shadowOffset = .init(width: 2, height: 2)
 playView.shadowRadius = 3
 let stopIcon = UIImage(systemName: "stop.fill")
 let stopImageView = UIImageView(image: stopIcon)
 stopImageView.translatesAutoresizingMaskIntoConstraints = false
 stopImageView.tintColor = .darkGray

 playView.setContentView(playImageView, selectedContentView: stopImageView, selectedTransform: nil)

 playImageView.centerXAnchor.constraint(equalTo: playView.centerXAnchor).isActive = true
 playImageView.centerYAnchor.constraint(equalTo: playView.centerYAnchor).isActive = true
 stopImageView.centerXAnchor.constraint(equalTo: playView.centerXAnchor).isActive = true
 stopImageView.centerYAnchor.constraint(equalTo: playView.centerYAnchor).isActive = true
 */
