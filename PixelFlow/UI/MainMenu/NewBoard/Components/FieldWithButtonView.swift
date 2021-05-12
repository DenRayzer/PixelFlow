//
//  FieldWithButtonView.swift
//  PixelFlow
//
//  Created by Елизавета on 11.05.2021.
//

import UIKit

class FieldWithButtonView: UIView {
    let textField: UITextField = {
        let field = UITextField()
        field.font = .font(family: .rubik(.medium), size: 16)
        field.placeholder = "pf_name_field_placeholder".localize()
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.PF.stroke.cgColor
        field.layer.cornerRadius = 10

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = .always
        field.rightView = paddingView
        field.rightViewMode = .always

        return field
    }()

    let settingButton: UIButton = {
        let view = UIButton()
        view.layout.size.equal(to: CGSize(width: 45, height: 45))
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.PF.stroke.cgColor
        view.layer.cornerRadius = 10
        return view
    }()

    convenience init(isPlaceholderRegular: Bool) {
        self.init()
        configureView()

        if isPlaceholderRegular { textField.font = .font(family: .rubik(.regular), size: 16) }
    }

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

        addSubview(settingButton)
        settingButton.layout.vertical.equal(to: self)
        settingButton.layout.left.equal(to: textField.layout.right, offset: 16)
        settingButton.layout.right.equal(to: self)
    }
}
