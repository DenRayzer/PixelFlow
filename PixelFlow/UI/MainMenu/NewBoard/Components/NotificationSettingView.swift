//
//  NotificationSettingView.swift
//  PixelFlow
//
//  Created by Елизавета on 11.05.2021.
//

import UIKit

class NotificationSettingView: UIView {

    let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.layer.borderWidth = 1
        picker.layer.borderColor = UIColor.PF.stroke.cgColor
        picker.layer.cornerRadius = 10


        picker.subviews.first?.subviews.forEach { grayView in
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor.white
            grayView.insertSubview(view, at: 0)
            view.topAnchor.constraint(equalTo: grayView.safeAreaLayoutGuide.topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: grayView.safeAreaLayoutGuide.bottomAnchor).isActive = true
            view.leadingAnchor.constraint(equalTo: grayView.safeAreaLayoutGuide.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: grayView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        }

        picker.tintColor = UIColor.PF.regularText
        picker.datePickerMode = .time
        return picker
    }()
    func openTimePicker() {
        timePicker.datePickerMode = UIDatePicker.Mode.time
    }

    static func makeDate(year: Int, month: Int, day: Int, hr: Int, min: Int, sec: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        let components = DateComponents(year: year, month: month, day: day, hour: hr, minute: min, second: sec)
        return calendar.date(from: components)!
    }

    let toggle: Toggle = {
        let toggle = Toggle()
        toggle.layout.size.equal(to: CGSize(width: 40, height: 25))
        toggle.isOn = true
        return toggle
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        addSubview(timePicker)
        timePicker.layout.vertical.equal(to: self)
        timePicker.layout.left.equal(to: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        addSubview(toggle)
        toggle.layout.centerY.equal(to: self)
        toggle.layout.left.equal(to: timePicker.layout.right, offset: 16)
        toggle.layout.right.equal(to: self)

        layout.height.equal(to: 45)

    }
}

