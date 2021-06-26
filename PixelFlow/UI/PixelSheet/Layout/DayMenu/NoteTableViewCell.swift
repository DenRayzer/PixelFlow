//
//  ColorItemTableViewCell.swift
//  PixelFlow
//
//  Created by Elizaveta on 4/25/21.
//

import UIKit

protocol GrowingCellProtocol: AnyObject {
    func updateHeightOfRow(_ cell: NoteTableViewCell, _ textView: UITextView)
}

class NoteTableViewCell: UITableViewCell {
    let field = TextViewWithPlaceholder()
    weak var cellDelegate: GrowingCellProtocol?
    var didEndEditing: (String)-> Void = { _ in }
    var note: Note? {
        didSet {
            if note?.text != "" {
                field.text = note?.text
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        commonInit()
        field.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
        field.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func commonInit() {
        contentView.addSubview(field)
        field.layout.all.equal(to: contentView, offset: UIEdgeInsets(horizontal: 16, vertical: 8))
        field.layout.bottom.equal(to: contentView, offset: -16)
        field.layout.height.greater(than: 70, priority: .defaultHigh, removeExisting: true)

        field.isScrollEnabled = false
        field.placeholderText = "Вы можете оставить заметку об этом дне"
        field.textContainerInset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.PF.stroke.cgColor
        field.layer.cornerRadius = 10
        field.backgroundColor = UIColor.PF.background
        field.font = .font(family: .rubik(.regular), size: 14)
        field.textColor = UIColor.PF.regularText
        backgroundColor = UIColor.PF.background
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        note = nil
    }
}

extension NoteTableViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let delegate = cellDelegate {
            delegate.updateHeightOfRow(self, textView)
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        note?.text = field.text
        didEndEditing(field.text)
    }
}

import UIKit
@IBDesignable class TextViewWithPlaceholder: UITextView {

    @IBInspectable var placeholderText: String = ""
    @IBInspectable var placeholderTextColor: UIColor = UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0) // Standard iOS placeholder
    private var showingPlaceholder: Bool = true

    override func didMoveToWindow() {
        super.didMoveToWindow()
        if text.isEmpty {
            showPlaceholderText()
        }
    }

    override func becomeFirstResponder() -> Bool {

        if showingPlaceholder {
            text = nil
            textColor = nil
            showingPlaceholder = false
        }
        return super.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
 
        if text.isEmpty {
            showPlaceholderText()
        }
        return super.resignFirstResponder()
    }

    private func showPlaceholderText() {
        showingPlaceholder = true
        textColor = placeholderTextColor
        text = placeholderText
    }
}
