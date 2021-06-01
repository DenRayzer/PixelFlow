//
//  ViewController.swift
//  PixelFlow
//
//  Created by Elizaveta on 5/6/21.
//

import UIKit

class MainMenuController: UIViewController {
    let navigationBar = Header(type: .navigationBar)
    let tableView = UITableView()

    let boards = ["Настроение", "Доска с длинным названием, очень длинным", "Я рисую"]
    let images: [UIImage] = [#imageLiteral(resourceName: "smile-cyan"),#imageLiteral(resourceName: "heart-lilac"),#imageLiteral(resourceName: "apple-peach")]

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHeader()
        configureTableView()
        view.backgroundColor = UIColor.PF.background

        let imageView = UIImageView(image: #imageLiteral(resourceName: "additional_color"))
        let settingsButton = Button(type: .floating, view: imageView)
        view.addSubview(settingsButton)
        settingsButton.cornerRadius = 25
        settingsButton.layout.height.equal(to: 50)
        settingsButton.layout.width.equal(to: 50)
        settingsButton.layout.bottom.equal(to: view, offset: -24)
        settingsButton.layout.right.equal(to: view, offset: -24)
    }

    private func configureHeader() {
        navigationBar.titleButton.setTitle("pf_your_boards".localize(), for: .normal)
        navigationBar.titleButton.titleLabel?.font = .font(family: .rubik(.medium), size: 18)
        view.addSubview(navigationBar)
        navigationBar.layout.horizontal.equal(to: view)
        navigationBar.layout.top.equal(to: view.safeAreaLayoutGuide, offset: 16)

        navigationBar.leftButtonAction = {
            self.dismiss(animated: true, completion: nil)
        }
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.layout.top.equal(to: navigationBar.layout.bottom, offset: 12)
        tableView.layout.bottom.equal(to: view)
        tableView.layout.horizontal.equal(to: view)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(MainMenuTableViewCell.self, forCellReuseIdentifier: MainMenuTableViewCell.identifier)

    }

}

extension MainMenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        boards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainMenuTableViewCell.identifier, for: indexPath) as? MainMenuTableViewCell else { return UITableViewCell() }

        cell.titleLabel.text = boards[indexPath.row]
        cell.titleImage.image = images[indexPath.row]
        cell.editButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(leftButton(_:))))

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 60 }

    @objc
    private func leftButton(_ sender: Any?) {
        print("bgfbfdg")
    }

}
