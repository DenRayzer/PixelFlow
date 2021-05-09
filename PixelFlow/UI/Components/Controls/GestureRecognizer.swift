//
//  GestureRecognizer.swift
//  PixelFlow
//
//  Created by Елизавета on 09.05.2021.
//

import UIKit

class GestureRecognizer<T: UIGestureRecognizer> {

    let gesture = Delegated<T, Void>()

    private(set) lazy var gestureRecognizer: T = {
        let recognizer = T.init(target: self, action: #selector(type(of: self).handleGesture(_:)))
        return recognizer
    }()

    init() { }
    init(of: T.Type) { }

    @objc
    func handleGesture(_ recognizer: UIGestureRecognizer) {
        guard let recognizer = recognizer as? T else { return }
        self.gesture.call(recognizer)
    }
}

