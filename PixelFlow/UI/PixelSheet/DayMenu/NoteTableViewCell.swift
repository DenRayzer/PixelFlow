//
//  ColorItemTableViewCell.swift
//  PixelFlow
//
//  Created by Elizaveta on 4/25/21.
//

import UIKit
import GrowingTextView

protocol GrowingCellProtocol: AnyObject {
    func updateHeightOfRow(_ cell: NoteTableViewCell, _ textView: UITextView)
}

class NoteTableViewCell: UITableViewCell {
    let field = GrowingTextView()//UITextView()
    weak var cellDelegate: GrowingCellProtocol?

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
      //  field.layout.height.greater(than: 70, priority: .defaultHigh, removeExisting: true)

        //field.textContainer.heightTracksTextView = true
        field.isScrollEnabled = false
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.PF.stroke.cgColor
        field.layer.cornerRadius = 10
        field.backgroundColor = UIColor.PF.background
        field.placeholder = "Вы можете оставить заметку об этом дне"
        field.minHeight = 70
        field.font = .font(family: .rubik(.regular), size: 14)
        field.textColor = UIColor.PF.regularText
        backgroundColor = .clear
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension NoteTableViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let deletate = cellDelegate {
            deletate.updateHeightOfRow(self, textView)
        }
    }
}
