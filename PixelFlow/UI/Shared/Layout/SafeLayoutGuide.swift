//
//  SafeLayoutGuide.swift
//  PixelFlow
//
//  Created by Елизавета on 05.04.2021.
//

import UIKit

class __SafeLayoutGuide: UILayoutGuide {

    override init() {
        super.init()
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        self.identifier = "$$new$$.__safe_layout_guide__"
    }

    func applyOn(view: UIView, controller topViewController: UIViewController) {
        let topAnchor: NSLayoutYAxisAnchor
        let offset: CGFloat

        if let navigation = topViewController.navigationController,
            !navigation.navigationBar.isHidden {
            topAnchor = topViewController.topLayoutGuide.bottomAnchor
            offset = 0
        } else {
            topAnchor = view.topAnchor
            offset = 20
        }

        view.addLayoutGuide(self)

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: topAnchor, constant: offset),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor).prioritize(.maximum),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

class __NavigationLayoutGuide: UILayoutGuide {

    override init() {
        super.init()
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        self.identifier = "$$new$$.__custom_navigation_guide__"
    }

    func applyOn(view: UIView, controller topViewController: UIViewController) {
        let topAnchor: NSLayoutYAxisAnchor
        let offset: CGFloat

        if #available(iOS 11, *) {
            topAnchor = view.safeAreaLayoutGuide.topAnchor
            offset = 68
        } else if let navigation = topViewController.navigationController,
            !navigation.navigationBar.isHidden {
            topAnchor = topViewController.topLayoutGuide.bottomAnchor
            offset = 68
        } else {
            topAnchor = view.topAnchor
            offset = 88
        }

        view.addLayoutGuide(self)

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: topAnchor, constant: offset),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor).prioritize(.maximum),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

