//
//  PixelSheetCell.swift
//  PixelFlow
//
//  Created by Елизавета on 10.04.2021.
//

import UIKit

class PixelSheetCell: UICollectionViewCell {

    var pixelLayout = PixelSheetLayout()
    var year: Year? {
        didSet {
            guard let year = year else { return }
            pixelLayout.configureCell(with: year)
        }
    }

    override func prepareForReuse() {
        year = nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    private func setupLayout() {

        addSubview(pixelLayout)
        pixelLayout.layout.vertical.equal(to: self)

        pixelLayout.layout.horizontal.equal(to: self, offset: CGFloat(mainHorizontalMargin))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
