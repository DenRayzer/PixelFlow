//
//  Label.swift
//  PixelFlow
//
//  Created by Елизавета on 11.04.2021.
//

import UIKit

class Label: UILabel {
    enum LabelTextMode {
        case `default`
        case uppercase
        case lowercase
    }

    enum LabelType {
        case custom
        case `default`(UIColor, UIFont, NSTextAlignment, Int)
    }

}


