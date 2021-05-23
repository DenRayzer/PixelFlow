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
//    override var text: String! { // Ensures that the placeholder text is never returned as the field's text
//        get {
//            if showingPlaceholder {
//                return "" // When showing the placeholder, there's no real text to return
//            } else { return super.text }
//        }
//        set { super.text = newValue }
//    }

    @IBInspectable var placeholderText: String = ""
    @IBInspectable var placeholderTextColor: UIColor = UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0) // Standard iOS placeholder color (#C7C7CD). See https://stackoverflow.com/questions/31057746/whats-the-default-color-for-placeholder-text-in-uitextfield
    private var showingPlaceholder: Bool = true // Keeps track of whether the field is currently showing a placeholder

    override func didMoveToWindow() {
        super.didMoveToWindow()
        if text.isEmpty {
            showPlaceholderText() // Load up the placeholder text when first appearing, but not if coming back to a view where text was already entered
        }
    }

    override func becomeFirstResponder() -> Bool {
        // If the current text is the placeholder, remove it
        if showingPlaceholder {
            text = nil
            textColor = nil // Put the text back to the default, unmodified color
            showingPlaceholder = false
        }
        return super.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        // If there's no text, put the placeholder back
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
