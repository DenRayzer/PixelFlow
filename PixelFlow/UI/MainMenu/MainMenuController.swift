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
    let storageManager = StorageManager()

    var boards: [Board] = []//["Настроение", "Доска с длинным названием, очень длинным", "Я рисую"]
    //   let images: [UIImage] = [#imageLiteral(resourceName: "smile-cyan"),#imageLiteral(resourceName: "heart-lilac"),#imageLiteral(resourceName: "apple-peach")]

    override func viewDidLoad() {
        super.viewDidLoad()
        boards = storageManager.getBoards()
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
        cell.currentBoard = boards[indexPath.row]
        cell.titleLabel.text = boards[indexPath.row].name
        cell.titleImage.image = UIImage(named: boards[indexPath.row].imageName)
        cell.editButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(leftButton(_:))))
//        let interaction = UIContextMenuInteraction(delegate: self)
//        cell.editButton.addInteraction(interaction)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? MainMenuTableViewCell
        ThemeHelper.currentBoard = cell?.currentBoard
        let vc = PixelSheetController()// cell?.currentBoard
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 60 }

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
        configurationForMenuAtLocation location: CGPoint)
        -> UIContextMenuConfiguration? {

            let favorite = UIAction(title: "Favorite",
                image: UIImage(systemName: "heart.fill")) { _ in
                // Perform action
            }

            let share = UIAction(title: "Share",
                image: UIImage(systemName: "square.and.arrow.up.fill")) { action in
                // Perform action
            }

            let delete = UIAction(title: "Delete",
                image: UIImage(systemName: "trash.fill"),
                attributes: [.destructive]) { action in
                // Perform action
            }

            return UIContextMenuConfiguration(identifier: nil,
                previewProvider: nil) { _ in
                UIMenu(title: "Actions", children: [favorite, share, delete])
            }
    }

    @objc
    private func leftButton(_ sender: UITapGestureRecognizer? = nil) {

        guard let sender = sender?.view else { return }
        print(" mfdkvmk")
        let vc = CellMenuViewController()
        vc.modalPresentationStyle = .popover
        let popoverVC = vc.popoverPresentationController
        popoverVC?.delegate = self
        popoverVC?.sourceView = sender
        popoverVC?.sourceRect = CGRect(x: sender.bounds.minX, y: sender.bounds.midY, width: 0, height: 0)
      //  vc.preferredContentSize = CGSize(width: 250,height: 250)
        present(vc, animated: true, completion: nil)
    }

}

extension MainMenuController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }

}
