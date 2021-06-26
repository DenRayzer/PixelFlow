//
//  PixelSheetLayout.swift
//  PixelFlow
//
//  Created by Елизавета on 04.04.2021.
//

import UIKit

class PixelSheetLayout: UIScrollView {
    var year: Year?
    private let itemsInRow = 12
    private var dayItemSize: Double = 0
    private var height: Double = (25 + 5) * 31
    var width: Double = (25 + 5) * 12
    var dayViews: [[PixelDayView]] = Array(repeating: [], count: 12)

    override init(frame: CGRect) {
        super.init(frame: frame)
        showsVerticalScrollIndicator = false
        // Drawing code
        translatesAutoresizingMaskIntoConstraints = false
        isScrollEnabled = true
        let a = screenWidth - mainHorizontalMargin * 2
        let b = itemsDistance * Double(itemsInRow - 1)
        dayItemSize = (a - b) / Double(itemsInRow)
        height = dayItemSize * 31 + itemsDistance * 30 + 80
        width = dayItemSize * 12 + itemsDistance * 11
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
        for col in 0 ... 11 {
            createMonth(col: col)
        }
    }

    private func createMonth(col: Int) {
        for row in 0 ... 30 {
            let x = (dayItemSize + itemsDistance) * Double(col)
            let y = (dayItemSize + itemsDistance) * Double(row)
            let dayView = PixelDayView(frame: CGRect(x: x, y: y, width: dayItemSize, height: dayItemSize))

            dayViews[col].append(dayView)
            addSubview(dayView)
        }
    }

    func configureCell(with year: Year) {
        self.year = year

        for month in 0 ... 11 {
            for day in 0 ... 30 {
                guard let yearDay = year.months[month][day] else {
                    dayViews[month][day].isHidden = true
                    continue
                }
                if yearDay.date > Date() {
                    dayViews[month][day].isUserInteractionEnabled = false
                    dayViews[month][day].backgroundColor = UIColor.PF.lightGray
                } else {
                    dayViews[month][day].backgroundColor = ThemeHelper.convertTypeToColor(for: .base, type: yearDay.type)
                }
                dayViews[month][day].day = yearDay
            }
        }
    }
}
