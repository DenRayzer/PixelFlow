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
    //NewBoardLayout()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHeader()
        view.addSubview(layout)
        layout.layout.top.equal(to: navigationBar.layout.bottom, offset: 12)
        layout.layout.horizontal.equal(to: view)
        layout.layout.bottom.equal(to: view)
        layout.showsVerticalScrollIndicator = false

        layout.addSubview(newBoardView)
//        layout.backgroundColor = .blue
//        newBoardView.backgroundColor = .red
        //  layout.contentSize = newBoardView.frame.size
        newBoardView.layout.width.equal(to: view.frame.width)
        newBoardView.layout.all.equal(to: layout)

        view.backgroundColor = UIColor.PF.background

        newBoardView.parametersViews.forEach { view in
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleColorViewTap(_:)))
            view.settingButton.addGestureRecognizer(recognizer)
        }
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

    @objc
    func handleColorViewTap(_ sender: UITapGestureRecognizer? = nil) {
        print("vfdmkmvdfk")

        let pickerView = ColorPickerView()
        view.addSubview(pickerView)
        pickerView.layout.all.equal(to: view)
    }

}
