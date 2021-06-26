//
//  CellMenuViewController.swift
//  PixelFlow
//
//  Created by Елизавета on 05.06.2021.
//

import UIKit

fileprivate enum MenuItem: RawRepresentable {
    case edit
    case setMain
    case delete

    static let allValues = [edit, setMain, delete]

    init?(rawValue: (name: String, image: UIImage)) {
        switch rawValue {
        case (name: "Редактировать", image: #imageLiteral(resourceName: "edit_16")): self = .edit
        case (name: "Главная доска", image: #imageLiteral(resourceName: "home_16")): self = .setMain
        case (name: "Удалить", image: #imageLiteral(resourceName: "delete_16")): self = .delete
        default: return nil
        }
    }
    var rawValue: (name: String, image: UIImage) {
        switch self {
        case .edit:
            return (name: "Редактировать", image: #imageLiteral(resourceName: "edit_16"))
        case .setMain:
            return (name: "Главная доска", image: #imageLiteral(resourceName: "home_16"))
        case .delete:
            return (name: "Удалить", image: #imageLiteral(resourceName: "delete_16"))
        }
    }
}

class CellMenuViewController: UITableViewController {
    let dataStoreManager = StorageManager()
    var board: Board?
    var onDeleteAction: (_ isSucceed: Bool) -> Void = { _ in }
    var onEditAction: () -> Void = { }
    var isLastBoard = false
    var isMain = false

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none
        tableView.register(CellMenuCell.self, forCellReuseIdentifier: "cell")
        tableView.isScrollEnabled = false

    }

    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: 200, height: tableView.contentSize.height)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MenuItem.allValues.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellMenuCell
        cell.item = MenuItem.allValues[indexPath.row]
        if cell.item == .setMain && board?.name == StorageManager.getMainBoardName() {
            cell.textLabel?.text = MenuItem.allValues[indexPath.row].rawValue.name + "  ✓"
            isMain = true
        } else {
            cell.textLabel?.text = MenuItem.allValues[indexPath.row].rawValue.name
        }
        cell.imageView?.image = MenuItem.allValues[indexPath.row].rawValue.image
        cell.selectionStyle = .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CellMenuCell else { return }
        switch cell.item {
        case .edit:
            editBoard()
        case .setMain:
            if !isMain {
                cell.textLabel?.text = MenuItem.allValues[indexPath.row].rawValue.name + "  ✓"
            }
            setMAinBoard()
        case .delete:
            deleteBoard()
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }

    private func editBoard() {
        onEditAction()
    }

    private func setMAinBoard() {
        guard let board = board else { return }
        isMain = true
        StorageManager.setMainBoardName(name: board.name)
        dismiss(animated: true)
    }

    private func deleteBoard() {
        guard let board = board, !isLastBoard, !(StorageManager.getMainBoardName() == board.name) else {
            onDeleteAction(false)
            return
        }

        let alertController = UIAlertController(title: "Вы уверены, что хотите удалить доску '\(board.name)'?", message: "Данные будут потеряны навсегда.", preferredStyle: .alert)

        let OKAction = UIAlertAction(title: "Удалить", style: .default) { (action: UIAlertAction!) in

            NotificationManager().removeNotification(for: board.notifications.map { "\(board.name)-\($0.time))" })
            let isSucceed = self.dataStoreManager.deleteBoard(boardName: board.name)
            self.onDeleteAction(isSucceed)
            self.dismiss(animated: true)
            print("Ok button tapped");
        }
        alertController.addAction(OKAction)

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { (action: UIAlertAction!) in
            print("Cancel button tapped");
            self.dismiss(animated: true)
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)


    }
}

fileprivate class CellMenuCell: UITableViewCell {
    var item: MenuItem = .edit

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        commonInit()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()

    }

    private func commonInit() {
        textLabel?.font = .font(family: .rubik(.regular), size: 14)
        textLabel?.textColor = UIColor.PF.regularText
        textLabel?.layout.left.equal(to: self, offset: 16)
        textLabel?.layout.centerY.equal(to: self)


        imageView?.layout.left.equal(to: (textLabel?.layout.right)!, offset: 16)
        imageView?.layout.centerY.equal(to: self)
        imageView?.layout.right.equal(to: self, offset: -32)
    }
}

