//
//  PixelDayView.swift
//  PixelFlow
//
//  Created by Елизавета on 04.04.2021.
//

import UIKit

class PixelDayView: UIView {

    var day: Day?
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = UIColor.PF.background
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    override func draw(_ rect: CGRect) {
                layer.cornerRadius = 5
                layer.borderWidth = 1
                layer.borderColor = UIColor.PF.stroke.cgColor
        backgroundColor = UIColor.PF.background
    }

  }
