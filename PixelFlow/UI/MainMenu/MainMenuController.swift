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

    var boards: [Board] = []

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
        settingsButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showNewBoardView(_:))))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self = self else { return }
            self.boards = self.storageManager.getBoards()
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    @objc private func showNewBoardView(_ sender: UITapGestureRecognizer? = nil) {
        let vc = NewBoardController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
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
        tableView.layout.top.equal(to: navigationBar.layout.bottom, offset: 24)
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

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? MainMenuTableViewCell
        ThemeHelper.currentBoard = cell?.currentBoard
        measure("ХЫХЫХЫХ") { finish in
            ThemeHelper.currentBoard?.years.forEach { $0.configureMonths() }
            finish()
        }

        let vc = PixelSheetController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 60 }

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
        configurationForMenuAtLocation location: CGPoint)
        -> UIContextMenuConfiguration? {

            let favorite = UIAction(title: "Favorite",
                image: UIImage(systemName: "heart.fill")) { _ in
            }

            let share = UIAction(title: "Share",
                image: UIImage(systemName: "square.and.arrow.up.fill")) { action in
            }

            let delete = UIAction(title: "Delete",
                image: UIImage(systemName: "trash.fill"),
                attributes: [.destructive]) { action in
            }

            return UIContextMenuConfiguration(identifier: nil,
                previewProvider: nil) { _ in
                UIMenu(title: "Actions", children: [favorite, share, delete])
            }
    }

    @objc
    private func leftButton(_ sender: UITapGestureRecognizer? = nil) {

        guard let sender = sender?.view,
            let cell = sender.superview?.superview as? MainMenuTableViewCell else { return }
        let vc = CellMenuViewController()
        vc.board = cell.currentBoard
        vc.onEditAction = {
            vc.dismiss(animated: false) {
                let vc = NewBoardController(boardToChange: cell.currentBoard)
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
        if boards.count == 1 {
            vc.isLastBoard = true
            vc.onDeleteAction = { [weak self] _ in
                vc.dismiss(animated: false) {
                    self?.showMessageAlert(title: "Нельзя удалить единственную доску", message: "В приложении должна быть хотя бы одна активная доска.")
                }
            }
        } else {
            vc.onDeleteAction = { [weak self] isSucceed in
                if isSucceed {
                    self?.boards.removeAll(where: { $0.name == cell.currentBoard?.name ?? "" })
                    self?.tableView.reloadData()
                } else {
                    self?.showMessageAlert(title: "Возникла ошибка при удалении", message: "Попробуйте повторить попытку позже")
                }
            }
        }
        vc.modalPresentationStyle = .popover
        let popoverVC = vc.popoverPresentationController
        popoverVC?.delegate = self
        popoverVC?.sourceView = sender
        present(vc, animated: true, completion: nil)
    }

    private func showMessageAlert(title: String, message: String) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.font(family: .rubik(.medium), size: 18), NSAttributedString.Key.foregroundColor: UIColor.PF.regularText]), forKey: "attributedTitle")
        alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font: UIFont.font(family: .rubik(.regular), size: 14), NSAttributedString.Key.foregroundColor: UIColor.PF.regularText]), forKey: "attributedMessage")

        alert.view.tintColor = UIColor.PF.regularText
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }

}

extension MainMenuController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            .none
    }

}
