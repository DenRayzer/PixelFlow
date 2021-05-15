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
    let newBoardView = NewBoardLayout()

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

        layout.addSubview(newBoardView)
        newBoardView.selectImageAction = { [weak self] in
            guard let self = self else { return }
            let pickerView = ImagePickerView()

            pickerView.selectImageAction = { [weak self] image in
                self?.newBoardView.nameField.settingButton.setImage(image, for: .normal)
            }

            self.view.addSubview(pickerView)
            pickerView.layout.all.equal(to: self.view)
        }
        newBoardView.colorViewAction = { [weak self] in
            guard let self = self else { return }
            
            let pickerView = ColorPickerView()
            pickerView.colorViewAction = { [weak self] color in
                guard let self = self else { return }
                self.newBoardView.selectedParameter?.buttonColor = color ?? UIColor.PF.background
                
            }
            self.view.addSubview(pickerView)
            pickerView.layout.all.equal(to: self.view)
        }
        newBoardView.layout.width.equal(to: view.frame.width)
        newBoardView.layout.all.equal(to: layout)
    }

}
