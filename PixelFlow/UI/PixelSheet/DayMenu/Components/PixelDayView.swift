//
//  PixelDayView.swift
//  PixelFlow
//
//  Created by Елизавета on 04.04.2021.
//

import UIKit
import FittedSheets

class PixelDayView: UIView {
    var day: Day?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.PF.background
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.PF.stroke.cgColor
        backgroundColor = UIColor.PF.background
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(recognizer)
    }
    
    @objc
    func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        guard let day = day else { return }
        let controller = DayMenuController(for: day)
        
        controller.layout.dayInfoLabel.text = "\(day.date)"
        let options = SheetOptions(useFullScreenMode: false, useInlineMode: true)
        let sheetController = SheetViewController(controller: controller, sizes: [.marginFromTop(130)], options: options)
        sheetController.allowPullingPastMaxHeight = false
        
     //   sheetController.autoAdjustToKeyboard = false
        sheetController.gripColor = .clear

        let viewController = UIApplication.shared.windows.first!.rootViewController!
        sheetController.animateIn(to: viewController.view, in: viewController)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
