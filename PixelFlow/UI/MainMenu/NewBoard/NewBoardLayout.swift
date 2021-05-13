//
//  NewBoardLayout.swift
//  PixelFlow
//
//  Created by Елизавета on 11.05.2021.
//

import UIKit

class NewBoardLayout: UIView {
    let nameField = FieldWithButtonView()
    private let parametersTitleLabel = Label(type: .regularInfo, textMode: .default, text: "pf_add_parameters_title".localize())
    private let notificationsTitleLabel = Label(type: .regularInfo, textMode: .default, text: "pf_add_notifications_title".localize())
    var addParameterButton: SoftUIView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "additional_color"))
        let button = Button(type: .bulging, view: image)
        button.layout.height.equal(to: 45)
        button.layout.width.equal(to: 45)

        return button
    }()
    var addNotificationButton: SoftUIView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "additional_color"))
        let button = Button(type: .bulging, view: image)
        button.layout.height.equal(to: 45)
        button.layout.width.equal(to: 45)

        return button
    }()

    private(set) lazy var paremetersContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 10
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return stack
    }()

    private(set) lazy var notificationsContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.spacing = 10
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return stack
    }()

    var parametersViews: [FieldWithButtonView] = []
    var notificationsViews: [NotificationSettingView] = []
    var colorViewAction: () -> Void = { }

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureViews() {

        addSubview(nameField)
        nameField.layout.top.equal(to: self, offset: 30)
        nameField.layout.horizontal.equal(to: self, offset: 16)

        addSubview(parametersTitleLabel)
        parametersTitleLabel.textAlignment = .center
        parametersTitleLabel.layout.top.equal(to: nameField.layout.bottom, offset: 24)
        parametersTitleLabel.layout.horizontal.equal(to: self, offset: 16)

        addSubview(paremetersContainer)
        paremetersContainer.layout.top.equal(to: parametersTitleLabel.layout.bottom, offset: 20)
        paremetersContainer.layout.horizontal.equal(to: self, offset: 16)
        //   paremetersContainer.layout.width.equal(to: layout.width)
        parametersViews.append(FieldWithButtonView(isPlaceholderRegular: true))
        parametersViews.append(FieldWithButtonView(isPlaceholderRegular: true))
        parametersViews.append(FieldWithButtonView(isPlaceholderRegular: true))
        parametersViews.append(FieldWithButtonView(isPlaceholderRegular: true))
        parametersViews.append(FieldWithButtonView(isPlaceholderRegular: true))
        parametersViews.append(FieldWithButtonView(isPlaceholderRegular: true))
        parametersViews.append(FieldWithButtonView(isPlaceholderRegular: true))
        parametersViews.append(FieldWithButtonView(isPlaceholderRegular: true))
        parametersViews.append(FieldWithButtonView(isPlaceholderRegular: true))
        parametersViews.append(FieldWithButtonView(isPlaceholderRegular: true))
        parametersViews.append(FieldWithButtonView(isPlaceholderRegular: true))
        parametersViews.append(FieldWithButtonView(isPlaceholderRegular: true))
        parametersViews.append(FieldWithButtonView(isPlaceholderRegular: true))
        parametersViews.append(FieldWithButtonView(isPlaceholderRegular: true))
        parametersViews.append(FieldWithButtonView(isPlaceholderRegular: true))
        parametersViews.append(FieldWithButtonView(isPlaceholderRegular: true))
        parametersViews.append(FieldWithButtonView(isPlaceholderRegular: true))
        parametersViews.forEach { view in
            paremetersContainer.addArrangedSubview(view)
        }

        addSubview(addParameterButton)
        addParameterButton.layout.top.equal(to: paremetersContainer.layout.bottom, offset: 20)
        addParameterButton.layout.right.equal(to: self, offset: -16)

        addSubview(notificationsTitleLabel)
        notificationsTitleLabel.textAlignment = .center
        notificationsTitleLabel.layout.top.equal(to: addParameterButton.layout.bottom, offset: 20)
        notificationsTitleLabel.layout.horizontal.equal(to: self, offset: 16)

        addSubview(notificationsContainer)
        notificationsContainer.layout.top.equal(to: notificationsTitleLabel.layout.bottom, offset: 20)
        notificationsContainer.layout.left.equal(to: self, offset: 16)
        notificationsContainer.layout.bottom.equal(to: self, offset: -30)
        //   paremetersContainer.layout.width.equal(to: layout.width)
        notificationsViews.append(NotificationSettingView())
        notificationsViews.forEach { view in
            notificationsContainer.addArrangedSubview(view)
        }

        addSubview(addNotificationButton)
        addNotificationButton.layout.bottom.equal(to: notificationsContainer.layout.bottom)
        addNotificationButton.layout.right.equal(to: self, offset: -16)
        addNotificationButton.layout.left.equal(to: notificationsContainer.layout.right, offset: 16)
//        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleAddNoteButtonTap(_:)))
//        nameField.settingButton.addGestureRecognizer(recognizer)
    }
}
