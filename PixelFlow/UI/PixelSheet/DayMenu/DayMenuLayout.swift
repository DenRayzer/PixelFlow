//
//  DayMenuLayout.swift
//  PixelFlow
//
//  Created by Elizaveta on 4/24/21.
//

import UIKit

class DayMenuLayout: UIView {
    var dayInfoLabel = Label(type: .title)
    var selectedItem: ColorInfoItem?

    private(set) lazy var dayInfoContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.spacing = 10
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return stack
    }()

    var notes = ["vvv"]
    private(set) lazy var notesContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.spacing = 10
        stack.isUserInteractionEnabled = true
        return stack
    }()

    private(set) lazy var addNoteButton: SoftUIView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "new_note"))
        let selectedImage = UIImageView(image: #imageLiteral(resourceName: "new_note_selected"))
        let button = Button(type: .bulging, view: image, selectedView: selectedImage)
        button.layout.height.equal(to: 45)
        button.layout.width.equal(to: 45)

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleAddNoteButtonTap(_:)))
        button.addGestureRecognizer(recognizer)
        return button
    }()

    var notesTableView = ContentSizedTableView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    private func setupViews() {
        addSubview(dayInfoLabel)
        dayInfoLabel.layout.top.equal(to: self, offset: 20)
        dayInfoLabel.layout.left.equal(to: self, offset: 16)
        dayInfoLabel.layout.height.equal(to: 20)

        setupNotesTableView()
        setupColorItems()
    }

    @objc
    func handleAddNoteButtonTap(_ sender: UITapGestureRecognizer? = nil) {
        notes.append("vcvcv")
        notesTableView.reloadData()
    }

    private func setupColorItems() {
        dayInfoContainer.addArrangedSubview(ColorInfoItem(type: .first))
        dayInfoContainer.addArrangedSubview(ColorInfoItem(type: .second))
        dayInfoContainer.addArrangedSubview(ColorInfoItem(type: .third))
        dayInfoContainer.addArrangedSubview(ColorInfoItem(type: .fourth))
        dayInfoContainer.addArrangedSubview(ColorInfoItem(type: .fifth))
        dayInfoContainer.addArrangedSubview(ColorInfoItem(type: .sixth))
        dayInfoContainer.addArrangedSubview(ColorInfoItem(type: .seventh))
    }

    private func setupNotesTableView() {
        addSubview(notesTableView)
        notesTableView.layout.top.equal(to: dayInfoLabel.layout.bottom, offset: 20)
        notesTableView.layout.bottom.equal(to: self)
        notesTableView.layout.horizontal.equal(to: self)

        let headerView = UIView()
        headerView.layout.height.equal(to: 150)
        headerView.addSubview(dayInfoContainer)
        headerView.addSubview(addNoteButton)
        addNoteButton.layout.right.equal(to: headerView, offset: -16)
        addNoteButton.layout.bottom.equal(to: headerView, offset: -20)
        
        let view = UIView()
        let layer = CAShapeLayer()
        let bounds = CGRect(x: 0, y: 0, width: 43, height: 43)
        layer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 5, height: 5)).cgPath
        layer.strokeColor = UIColor.PF.accentColor.cgColor
        layer.fillColor = nil
        layer.lineDashPattern = [8, 6]
        view.layer.addSublayer(layer)
       // layer.lineDashPattern?.reduce(0) { $0 - $1.intValue }
        
        let animation = CABasicAnimation(keyPath: "lineDashPhase")
        animation.fromValue = 0
        animation.toValue = layer.lineDashPattern?.reduce(0) { $0 - $1.intValue } ?? 0
        animation.duration = 1
        animation.repeatCount = .infinity
        layer.add(animation, forKey: "line")
        
        
        headerView.addSubview(view)
        view.layout.right.equal(to: headerView, offset: -60)
        view.layout.top.equal(to: headerView, offset: 60)
//        headerView.addSubview(view)
//        view.layout.right.equal(to: headerView, offset: 16)
//        view.layout.top.equal(to: headerView, offset: 16)
        view.backgroundColor = .red
        
        
        
        dayInfoContainer.layout.horizontal.equal(to: headerView)

        dayInfoContainer.layout.vertical.equal(to: headerView, offset: (4,20))
        notesTableView.tableHeaderView = headerView // dayInfoContainer
        headerView.layout.width.equal(to: notesTableView)

        notesTableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "MyCell")
        notesTableView.delegate = self
        notesTableView.dataSource = self
        notesTableView.tableFooterView = UIView()
        //    notesTableView.estimatedRowHeight = 50
        notesTableView.separatorStyle = .none
        notesTableView.showsVerticalScrollIndicator = false
        notesTableView.backgroundColor = .clear

        notesTableView.keyboardDismissMode = .onDrag
    }

    private func setupNotes() {
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DayMenuLayout: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notesTableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! NoteTableViewCell
        cell.cellDelegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                notes.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
            }
        }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
            -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                // delete the item here
                completionHandler(true)
            }
            deleteAction.image = UIImage(systemName: "trash")
            deleteAction.backgroundColor = .systemRed
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
    }
    
    func setCheckedView(type: DayType) {
        for view in dayInfoContainer.arrangedSubviews {
            let view = view as? ColorInfoItem
            if view?.type == type {
                view?.setSelected()
                selectedItem = view
            }
        }
    }
}

extension DayMenuLayout: GrowingCellProtocol {
    func updateHeightOfRow(_ cell: NoteTableViewCell, _ textView: UITextView) {
        let size = textView.bounds.size
        let newSize = notesTableView.sizeThatFits(CGSize(width: size.width,
                                                         height: CGFloat.greatestFiniteMagnitude))
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            notesTableView.beginUpdates()
            notesTableView.endUpdates()
            UIView.setAnimationsEnabled(true)
            if let thisIndexPath = notesTableView.indexPath(for: cell) {
                notesTableView.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
            }
        }
    }
}

final class ContentSizedTableView: UITableView {
    override var intrinsicContentSize: CGSize { CGSize(width: contentSize.width, height: contentSize.height) }
}
