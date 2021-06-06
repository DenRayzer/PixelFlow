//
//  NewBoardLayout.swift
//  PixelFlow
//
//  Created by Елизавета on 11.05.2021.
//

import UIKit

class NewBoardLayout: UIView {
    var boardColor: BoardColor?
    private let parametersTitleLabel = Label(type: .regularInfo, textMode: .default, text: "pf_add_parameters_title".localize())
    private let notificationsTitleLabel = Label(type: .regularInfo, textMode: .default, text: "pf_add_notifications_title".localize())
    private(set) var addParameterButton: SoftUIView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "additional_color"))
        let button = Button(type: .bulging, view: image)
        button.layout.height.equal(to: 45)
        button.layout.width.equal(to: 45)

        return button
    }()

    let nameField: FieldWithButtonView = {
        let view = FieldWithButtonView()
        let image = UIImage(named: "yin-yang-cyan")
        image?.accessibilityIdentifier = "yin-yang-cyan"
        view.settingButton.setImage(image, for: .normal)
        return view
    }()

    private(set) var removeParameterButton: Button = {
        let image = UIImageView(image: #imageLiteral(resourceName: "remove"))
        let button = Button(type: .bulging, view: image)
        button.layout.height.equal(to: 45)
        button.layout.width.equal(to: 45)
        button.isHidden = true

        return button
    }()

    private(set) var addNotificationButton: Button = {
        let image = UIImageView(image: #imageLiteral(resourceName: "additional_color"))
        let button = Button(type: .bulging, view: image)
        button.layout.height.equal(to: 45)
        button.layout.width.equal(to: 45)

        return button
    }()

    private(set) var removeNotificationButton: Button = {
        let image = UIImageView(image: #imageLiteral(resourceName: "remove"))
        let button = Button(type: .bulging, view: image)
        button.layout.height.equal(to: 45)
        button.layout.width.equal(to: 45)
        button.isHidden = true

        return button
    }()

    private(set) lazy var paremetersContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 16
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return stack
    }()

    private(set) lazy var notificationsContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.spacing = 16
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return stack
    }()

    private(set) var saveButton: SoftUIView = {
        let label = Label(type: .title, textMode: .default, text: "pf_save".localize())
        label.textColor = UIColor.PF.accentColor
        let button = Button(type: .floating, view: label)
        button.layout.height.equal(to: 48)
        button.cornerRadius = 24

        return button
    }()

    var errorLabel: Label = {
        let label = Label(type: .custom, textMode: .default, text: "")
        label.textColor = UIColor.colorScheme.vinous
        label.textAlignment = .center
        return label
    }()

    var parametersViews: [FieldWithButtonView] = []
    var notificationsViews: [NotificationSettingView] = []
    var colorViewAction: () -> Void = { }
    var addParameterButtonAction: () -> Void = { }
    var addNotificationButtonAction: () -> Void = { }
    var selectImageAction: () -> Void = { }
    var selectedParameter: FieldWithButtonView?

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
        nameField.settingButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSetImageButton(_:))))

        addSubview(parametersTitleLabel)
        parametersTitleLabel.textAlignment = .center
        parametersTitleLabel.layout.top.equal(to: nameField.layout.bottom, offset: 24)
        parametersTitleLabel.layout.horizontal.equal(to: self, offset: 16)

        addSubview(paremetersContainer)
        paremetersContainer.layout.top.equal(to: parametersTitleLabel.layout.bottom, offset: 20)
        paremetersContainer.layout.horizontal.equal(to: self, offset: 16)

        if parametersViews.isEmpty {
            let view = FieldWithButtonView(isPlaceholderRegular: true)
            view.settingButton.backgroundColor = UIColor.colorScheme.allValues.first?.color
            parametersViews.append(view)
        }
        parametersViews.forEach { view in
            view.settingButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleColorViewAction(_:))))
            paremetersContainer.addArrangedSubview(view)
        }

        addSubview(addParameterButton)
        addParameterButton.layout.top.equal(to: paremetersContainer.layout.bottom, offset: 20)
        addParameterButton.layout.right.equal(to: self, offset: -16)
        addParameterButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddParameterButton(_:))))

        addSubview(removeParameterButton)
        removeParameterButton.layout.top.equal(to: paremetersContainer.layout.bottom, offset: 20)
        removeParameterButton.layout.right.equal(to: addParameterButton.layout.left, offset: -16)
        removeParameterButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveParameterButton(_:))))

        addSubview(notificationsTitleLabel)
        notificationsTitleLabel.textAlignment = .center
        notificationsTitleLabel.layout.top.equal(to: addParameterButton.layout.bottom, offset: 20)
        notificationsTitleLabel.layout.horizontal.equal(to: self, offset: 16)

        addSubview(notificationsContainer)
        notificationsContainer.layout.top.equal(to: notificationsTitleLabel.layout.bottom, offset: 20)
        notificationsContainer.layout.left.equal(to: self, offset: 16)
        notificationsViews.append(NotificationSettingView())
        notificationsViews.forEach { view in
            notificationsContainer.addArrangedSubview(view)
        }

        addSubview(addNotificationButton)
        addNotificationButton.layout.bottom.equal(to: notificationsContainer.layout.bottom)
        addNotificationButton.layout.right.equal(to: self, offset: -16)
        addNotificationButton.layout.left.equal(to: notificationsContainer.layout.right, offset: 16)
        addNotificationButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddNotificationButton(_:))))
        addSubview(removeNotificationButton)
        removeNotificationButton.layout.bottom.equal(to: notificationsContainer.layout.bottom)
        removeNotificationButton.layout.right.equal(to: addNotificationButton.layout.left, offset: -16)
        removeNotificationButton.layout.left.equal(to: notificationsContainer.layout.right, offset: 16)
        removeNotificationButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveNotificationButton(_:))))

        addSubview(errorLabel)
        errorLabel.layout.horizontal.equal(to: self, offset: 24)
        errorLabel.layout.top.greater(than: notificationsContainer.layout.bottom, offset: 35)

        addSubview(saveButton)
        saveButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSaveButtonTap(_:))))
        saveButton.layout.horizontal.equal(to: self, offset: 24)
        saveButton.layout.top.equal(to: errorLabel.layout.bottom, offset: 12)
        saveButton.layout.bottom.equal(to: self, offset: -30)
    }

    @objc
    func handleColorViewAction(_ sender: UITapGestureRecognizer? = nil) {
         dismissKeyboard()
        guard let selected = sender?.view as? UIButton else { return }
        selectedParameter = selected.superview as? FieldWithButtonView
        colorViewAction()
    }

    @objc
    func handleAddParameterButton(_ sender: UITapGestureRecognizer? = nil) {
        dismissKeyboard()
        guard let _ = parametersViews.last?.dayType else { return }
        if removeParameterButton.isHidden { removeParameterButton.isHidden = false }
        let view = FieldWithButtonView(isPlaceholderRegular: true)
        view.settingButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleColorViewAction(_:))))
        parametersViews.append(view)
        paremetersContainer.addArrangedSubview(view)

        addParameterButtonAction()
    }

    @objc
    func handleRemoveParameterButton(_ sender: UITapGestureRecognizer? = nil) {
        dismissKeyboard()
        paremetersContainer.subviews.last?.removeFromSuperview()
        parametersViews.removeLast()
        if paremetersContainer.subviews.count == 1 { removeParameterButton.isHidden = true }
    }

    @objc
    func handleSaveButtonTap(_ sender: UITapGestureRecognizer? = nil) {
        dismissKeyboard()
        //   func saveNewBoard() {
        if nameField.textField.text == "" || parametersViews.first?.textField.text == ""
            || parametersViews.first?.dayType == nil {
            errorLabel.text = "АШИБКАjfdjfd!!!!!!!!!"
        } else {
            print("\(nameField.settingButton.image(for: .normal)?.accessibilityIdentifier)")
            
            createBoard()
            errorLabel.text = ""
        }
        //  }
    }

    private func createBoard() {
        let components = Calendar.current.dateComponents([.year], from: Date())

        var years: [Year] = []
        for i in 0...5 { years.append(Year(year: Int16((components.year ?? 99) - i), days: [])) }
        var parameters: [BoardParameter] = []
        parametersViews.forEach { parameterView in
            parameters.append(BoardParameter(name: parameterView.textField.text ?? "",
                                             color: parameterView.dayType.rawValue,
                                             colorSheme: 0))
        }

        var notifications: [NotificationSetting] = []
        notificationsViews.forEach { notificationView in
            notifications.append(NotificationSetting(time: notificationView.timePicker.date, isOn: notificationView.toggle.isOn))
        }

        let board = Board(name: nameField.textField.text ?? "",
                          imageName: nameField.settingButton.image(for: .normal)?.accessibilityIdentifier ?? "",
                          mainColorId: (boardColor?.rawValue.id ?? 0),
                          years: years,
                          colorShemeId: 0,
                          parameters: parameters,
                          notifications: notifications)

        let storageManager = StorageManager()
        storageManager.saveBoard(board: board)
    }

    @objc
    func handleAddNotificationButton(_ sender: UITapGestureRecognizer? = nil) {
        dismissKeyboard()
        let view = NotificationSettingView()
        if removeNotificationButton.isHidden { removeNotificationButton.isHidden = false }
        //   view.toggle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleColorViewAction(_:))))
        notificationsViews.append(view)
        notificationsContainer.addArrangedSubview(view)

        addNotificationButtonAction()
    }

    @objc
    func handleRemoveNotificationButton(_ sender: UITapGestureRecognizer? = nil) {
        dismissKeyboard()
        notificationsContainer.subviews.last?.removeFromSuperview()
        notificationsViews.removeLast()

        if notificationsContainer.subviews.count == 1 { removeNotificationButton.isHidden = true }
    }

    @objc
    func handleSetImageButton(_ sender: UITapGestureRecognizer? = nil) {
        dismissKeyboard()
        
        selectImageAction()
    }

    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
