//
//  NewBoardController.swift
//  PixelFlow
//
//  Created by Елизавета on 11.05.2021.
//

import UIKit

class NewBoardController: UIViewController {
    let navigationBar = Header(type: .navigationBar)
    private let layout = UIScrollView()
    let container = NewBoardLayout()
    private var board: Board?

    convenience init(boardToChange: Board?) {
        self.init()
        board = boardToChange
        container.isEdit = true

        container.nameField.textField.text = board?.name
        container.nameField.textField.isUserInteractionEnabled = false
        let image = UIImage(named: board?.imageName ?? "")
        image?.accessibilityIdentifier = board?.imageName ?? ""
        container.nameField.currentImage = image
        container.nameField.settingButton.setImage(image, for: .normal)

        board?.parameters.forEach { parameter in
            let parameterView = FieldWithButtonView()
            parameterView.textField.text = parameter.name
            parameterView.textField.isUserInteractionEnabled = false
            parameterView.settingButton.backgroundColor = ThemeHelper.convertTypeToColor(for: .base, type: parameter.color)
            container.savedParameterViews.append(parameterView)
            container.paremetersContainer.addArrangedSubview(parameterView)
        }

        board?.notifications.forEach { notification in
            let notificationView = NotificationSettingView()
            notificationView.timePicker.setDate(notification.time, animated: false)
            notificationView.toggle.isOn = notification.isOn

            container.notificationsViews.append(notificationView)
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHeader()
        configureView()
        container.configureParameterViews()
    }


    private func configureHeader() {
        navigationBar.titleButton.setTitle("pf_new_board".localize(), for: .normal)
        navigationBar.titleButton.titleLabel?.font = .font(family: .rubik(.medium), size: 18)
        view.addSubview(navigationBar)
        navigationBar.layout.horizontal.equal(to: view)
        navigationBar.layout.top.equal(to: view.safeAreaLayoutGuide, offset: 16)

        navigationBar.leftButtonAction = {
            self.dismiss(animated: true, completion: nil)
        }
    }

    private func configureView() {
        view.backgroundColor = UIColor.PF.background

        view.addSubview(layout)
        layout.layout.top.equal(to: navigationBar.layout.bottom, offset: 12)
        layout.layout.horizontal.equal(to: view)
        layout.layout.bottom.equal(to: view)
        layout.showsVerticalScrollIndicator = false
        layout.keyboardDismissMode = .onDrag

        container.saveBoardAction = { [weak self] board in
            print("save")
            StorageManager().saveBoard(board: board)
            self?.dismiss(animated: true)
        }

        container.updateBoardAction = { [weak self] boardToSave in
            guard let board = self?.board else { return }
            var isNotificationsEqual = true

            boardToSave.notifications.forEach { i in
                let isEqual = board.notifications.contains(where: { $0.time == i.time && $0.isOn == i.isOn })
                if !isEqual {
                    isNotificationsEqual = false
                    return
                }
            }
            if board.imageName == boardToSave.imageName,
                boardToSave.parameters.count == 0, isNotificationsEqual {
            } else {
                if !isNotificationsEqual {
                    let notificationsHelper = NotificationManager()
                    let notificationIds = board.notifications.compactMap { [weak self] in self?.isNotificationOn(notification: $0, notificationsHelper: notificationsHelper)
                    }
                    notificationsHelper.removeNotification(for: notificationIds)

                    boardToSave.notifications.forEach { notification in
                        if notification.isOn {
                            notificationsHelper.scheduleNotification(notification: notification, boardName: boardToSave.name)
                        }
                    }
                }
                StorageManager().updateBoard(board: boardToSave)
                self?.dismiss(animated: true)
            }
        }
        layout.addSubview(container)
        container.selectImageAction = { [weak self] in
            guard let self = self else { return }
            let pickerView = ImagePickerView()

            pickerView.selectImageAction = { [weak self] image, color in
                self?.container.nameField.settingButton.setImage(image, for: .normal)
                self?.container.boardColor = color
            }

            self.view.addSubview(pickerView)
            pickerView.layout.all.equal(to: self.view)
        }
        container.colorViewAction = { [weak self] in
            guard let self = self else { return }

            let pickerView = ColorPickerView()
            pickerView.colorViewAction = { [weak self] dayType in
                guard let self = self else { return }
                self.container.selectedParameter?.dayType = dayType

            }
            self.view.addSubview(pickerView)
            pickerView.layout.all.equal(to: self.view)
        }
        container.layout.width.equal(to: view.frame.width)
        container.layout.all.equal(to: layout)
    }

    func isNotificationOn(notification: NotificationSetting, notificationsHelper: NotificationManager) -> String? {
        if notification.isOn {
            return notificationsHelper.сonfigureId(for: notification, boardName: board?.name ?? "")
        }
        return nil
    }

}
