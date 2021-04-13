//
//  PixelSheetLayout.swift
//  PixelFlow
//
//  Created by Елизавета on 04.04.2021.
//

import UIKit

class PixelSheetLayout: UIScrollView {
    private let itemsInRow = 12
    private var dayItemSize: Double = 0
    private var height: Double = (25+5)*31
    var width: Double = (25+5)*12

    override init(frame: CGRect) {
        super.init(frame: frame)
        showsVerticalScrollIndicator = false
        // Drawing code
        translatesAutoresizingMaskIntoConstraints = false
        isScrollEnabled = true
        let a = screenWidth - mainHorizontalMargin*2
        let b = itemsDistance*Double(itemsInRow - 1)
        dayItemSize = (a - b)/Double(itemsInRow)
        height = dayItemSize*31 + itemsDistance*30 + 80
        width = dayItemSize*12 + itemsDistance*11
        layout()
        print("screenWidth: \(screenWidth)")
        print("dayItemSize: \(dayItemSize)")

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func layout() {
        createDays()
        contentSize = CGSize(width: width, height: height)
    }

    private func createDays() {
        for col in 0...11 {
            createMonth(j: col)
        }

    }

    private func createMonth(j: Int) {
        for i in 0...30 {
            addSubview(PixelDayView(frame: CGRect(x: (dayItemSize+itemsDistance)*Double(j), y: (dayItemSize+itemsDistance)*Double(i), width: dayItemSize, height: dayItemSize)))
        }

    }

    override func draw(_ rect: CGRect) {

    }


}

