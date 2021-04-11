//
//  PixelDayView.swift
//  PixelFlow
//
//  Created by Елизавета on 04.04.2021.
//

import UIKit

class PixelDayView: UIView {

    var day: Day?

    override func draw(_ rect: CGRect) {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.PF.stroke.cgColor
        backgroundColor = UIColor.PF.background
    }
  }
