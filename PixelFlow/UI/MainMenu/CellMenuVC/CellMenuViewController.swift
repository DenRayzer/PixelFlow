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
        case (name: "Edit", image: #imageLiteral(resourceName: "edit_16")): self = .edit
        case (name: "Set main", image: #imageLiteral(resourceName: "home_16")): self = .setMain
        case (name: "Delete", image: #imageLiteral(resourceName: "delete_16")): self = .delete
        default: return nil
        }
    }
    var rawValue: (name: String, image: UIImage) {
        switch self {
        case .edit:
            return (name: "Edit", image: #imageLiteral(resourceName: "edit_16"))
        case .setMain:
            return (name: "Set main", image: #imageLiteral(resourceName: "home_16"))
        case .delete:
            return (name: "Delete", image: #imageLiteral(resourceName: "delete_16"))
        }
    }
}

class CellMenuViewController: UITableViewController {
    let dataStoreManager = StorageManager()
    var board: Board?
    var onDeleteAction: (_ isSucceed: Bool) -> Void = { _ in }
    var isLastBoard = false

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
        cell.textLabel?.text = MenuItem.allValues[indexPath.row].rawValue.name
        cell.imageView?.image = MenuItem.allValues[indexPath.row].rawValue.image

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CellMenuCell else { return }
        switch cell.item {
        case .edit:
            editBoard()
        case .setMain:
            setMAinBoard()
        case .delete:
            deleteBoard()
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }

    private func editBoard() {

    }

    private func setMAinBoard() {

    }

    private func deleteBoard() {
        guard let board = board, !isLastBoard else {
            onDeleteAction(false)
            return
        }
        NotificationManager().removeNotification(for: board.notifications.map { "\(board.name)-\($0.time))" })
        let isSucceed = dataStoreManager.deleteBoard(boardName: board.name)
        onDeleteAction(isSucceed)

        dismiss(animated: true)

    }
}

fileprivate class CellMenuCell: UITableViewCell {
    var item: MenuItem = .edit
    //       var label = Label()
    //  var imageView = UIImageView()

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

//        imageView?.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        imageView?.layout.left.equal(to: (textLabel?.layout.right)!, offset: 16)
        imageView?.layout.centerY.equal(to: self)
        imageView?.layout.right.equal(to: self, offset: -32)
    }
}

