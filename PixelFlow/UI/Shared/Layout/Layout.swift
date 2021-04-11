//
//  Layout.swift
//  PixelFlow
//
//  Created by Елизавета on 04.04.2021.
//

import UIKit

class Layout: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
    }

    func layout() { }

}
