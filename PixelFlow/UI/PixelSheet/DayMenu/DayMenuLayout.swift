//
//  DayMenuLayout.swift
//  PixelFlow
//
//  Created by Elizaveta on 4/24/21.
//

import UIKit

class DayMenuLayout: UIView {
    var dayInfoLabel = Label(type: .title)
    var additionalDayColorButton: BasicButton = {
        let button = BasicButton()
        button.setImage(#imageLiteral(resourceName: "additional_color"), for: .normal)
        return button
    }()
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
    
    private(set) lazy var additionalDayColorsContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.spacing = 12
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        return stack
    }()

    var notes = ["vvv"]

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
    var activeAdditionalColor: DottedDayView?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }
    
    private func addNewDayColor() {
        if activeAdditionalColor != nil || additionalDayColorsContainer.subviews.count == dayInfoContainer.subviews.count - 1 { return }
        
        let dottedRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDottedTap(_:)))
        let coloredRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleColoredTap(_:)))
        
        let newView = DottedDayView()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale.current
//        layout.dayInfoLabel.text = dateFormatter.string(from: day.date).lowercased()
        newView.timeLabel.text = dateFormatter.string(from: Date())
        newView.dottedView.addGestureRecognizer(dottedRecognizer)
        newView.coloredView.addGestureRecognizer(coloredRecognizer)
        activeAdditionalColor = newView
        additionalDayColorsContainer.addArrangedSubview(newView)
    }
        
    
    @objc
    func handleDottedTap(_ sender: UITapGestureRecognizer? = nil) {
        let view = sender?.view //activeAdditionalColor
        view?.superview?.removeFromSuperview()
      //  view?.changeColorView(with: .cyan)
        activeAdditionalColor = nil
    }
    
    @objc
    func handleColoredTap(_ sender: UITapGestureRecognizer? = nil) {
        let view = sender?.view //activeAdditionalColor
        view?.superview?.removeFromSuperview()
      //  view?.changeColorView(with: .cyan)
        activeAdditionalColor = nil
    }
        
    private func setupViews() {
        addSubview(dayInfoLabel)
        dayInfoLabel.layout.top.equal(to: self, offset: 20)
        dayInfoLabel.layout.left.equal(to: self, offset: 16)
        dayInfoLabel.layout.height.equal(to: 20)
        
        addSubview(additionalDayColorButton)
        additionalDayColorButton.layout.top.equal(to: self, offset: 20)
        additionalDayColorButton.layout.right.equal(to: self, offset: -24)
        additionalDayColorButton.touch.delegate(to: self) { _,_ in self.addNewDayColor() }

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
        
        dayInfoContainer.layout.left.equal(to: headerView)
        dayInfoContainer.layout.vertical.equal(to: headerView, offset: (4,20))
        
        headerView.addSubview(additionalDayColorsContainer)
        additionalDayColorsContainer.layout.right.equal(to: headerView, offset: -19)
        additionalDayColorsContainer.layout.top.equal(to: headerView, offset: 4)
       // additionalDayColorsContainer.layout.width.equal(to: 45)
    //    additionalDayColorsContainer.addArrangedSubview(ColorInfoItem(type: .first))
        
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
