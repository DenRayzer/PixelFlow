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

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHeader()
        configureView()
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

    

}
