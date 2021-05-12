//
//  NotificationSettingView.swift
//  PixelFlow
//
//  Created by Елизавета on 11.05.2021.
//

import UIKit

class NotificationSettingView: UIView {
    let textField: UITextField = {
        let field = UITextField()
        field.font = .font(family: .rubik(.medium), size: 16)
        field.placeholder = "pf_name_field_placeholder".localize()
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.PF.stroke.cgColor
        field.layer.cornerRadius = 10

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 43, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = .always
        field.rightView = paddingView
        field.rightViewMode = .always

        return field
    }()

    let toggle: Toggle = {
        let toggle = Toggle()
        toggle.layout.size.equal(to: CGSize(width: 40, height: 25))
        return toggle
    }()

//    convenience init(isPlaceholderRegular: Bool) {
//        self.init()
//        configureView()
//
//        if isPlaceholderRegular { textField.font = .font(family: .rubik(.regular), size: 16) }
//    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        addSubview(textField)
        textField.layout.vertical.equal(to: self)
        textField.layout.left.equal(to: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        textField.placeholder = dateFormatter.string(from: Date())

        addSubview(toggle)
        toggle.layout.centerY.equal(to: self)
        toggle.layout.left.equal(to: textField.layout.right, offset: 16)
        toggle.layout.right.equal(to: self)

        layout.height.equal(to: 45)

    }
}

