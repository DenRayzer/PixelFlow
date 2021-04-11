//
//  UIWindow+Extension.swift
//  PixelFlow
//
//  Created by Елизавета on 05.04.2021.
//
import UIKit

extension UIWindow {

    var topViewController: UIViewController? {
        return self.topViewController(root: self.rootViewController)
    }

    private func topViewController(root: UIViewController?) -> UIViewController? {
        guard let root = root else { return nil }

        guard let presented = root.presentedViewController else {
            return root
        }

        if let navigation = presented as? UINavigationController {
            return self.topViewController(root: navigation.topViewController)
        } else {
            return self.topViewController(root: presented)
        }
    }
}

