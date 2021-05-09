//
//  MainMenuTableViewCell.swift
//  PixelFlow
//
//  Created by Елизавета on 09.05.2021.
//

import UIKit

class MainMenuTableViewCell: UITableViewCell {
    static let identifier = "MainMenuTableViewCellId"

    var titleImage: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 50))
        view.contentMode = .center
        view.layout.width.equal(to: 30)
        view.image = #imageLiteral(resourceName: "yin_yang")
        return view
    }()

    var titleLabel = Label(type: .regularInfo, textMode: .default, text: "А что это было")

    var editButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        button.layout.width.equal(to: 40)
        button.layout.height.equal(to: 50)
        button.setImage(#imageLiteral(resourceName: "settings_dots"), for: .normal)
        return button
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        commonInit()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()

    }

    private func commonInit() {
        selectionStyle = .none
        backgroundColor = UIColor.PF.background

        contentView.addSubview(titleImage)
        titleImage.layout.centerY.equal(to: self)
        titleImage.layout.left.equal(to: self, offset: 16)

        contentView.addSubview(titleLabel)
        titleLabel.layout.centerY.equal(to: self)
        titleLabel.layout.left.equal(to: titleImage.layout.right, offset: 12)

        contentView.addSubview(editButton)
        editButton.layout.centerY.equal(to: self)
        editButton.layout.left.equal(to: titleLabel.layout.right, offset: 8)
        editButton.layout.right.equal(to: self, offset: -20)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
