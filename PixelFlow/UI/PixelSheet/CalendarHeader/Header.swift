//
//  Header.swift
//  PixelFlow
//
//  Created by Елизавета on 11.04.2021.
//

import UIKit

class MonthNameView: UIView {
    var label = Label(type: .smallText, textMode: .lowercase)

    convenience init(text: String) {
        self.init()
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 14))
        addSubview(view)
        view.layout.all.equal(to: self)

        view.addSubview(label)
        label.layout.center.equal(to: view)
        label.text = text
    }
}

class Header: UIView {
    private(set) var headerHeight: CGFloat = 44
    private(set) var leftButton: SoftUIView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "left_arrow"))
        let button = Button(type: .bulging, view: imageView)
        button.layout.height.equal(to: 43)
        button.layout.width.equal(to: 43)
        return button
    }()

    private(set) var rightButton: SoftUIView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "right_arrow"))
        let button = Button(type: .bulging, view: imageView)
        button.layout.height.equal(to: 43)
        button.layout.width.equal(to: 43)
        return button
    }()

    private(set) var titleButton: TextButton = {
        let button = TextButton(type: .default(UIColor.PF.regularText, .font(family: .rubik(.regular), size: 22), .center, 1),
                                textMode: .uppercase,
                                text: "2021")
        button.titleLabel?.adjustsFontSizeToFitWidth = true

        return button
    }()

    private(set) lazy var monthsContainer: UIStackView = {
        let stack = UIStackView()
        stack.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 20)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 2

        stack.addArrangedSubview(MonthNameView(text: "pf_month_jan".localize()))
        stack.addArrangedSubview(MonthNameView(text: "pf_month_feb".localize()))
        stack.addArrangedSubview(MonthNameView(text: "pf_month_mar".localize()))
        stack.addArrangedSubview(MonthNameView(text: "pf_month_apr".localize()))
        stack.addArrangedSubview(MonthNameView(text: "pf_month_may".localize()))
        stack.addArrangedSubview(MonthNameView(text: "pf_month_jun".localize()))
        stack.addArrangedSubview(MonthNameView(text: "pf_month_jul".localize()))
        stack.addArrangedSubview(MonthNameView(text: "pf_month_aug".localize()))
        stack.addArrangedSubview(MonthNameView(text: "pf_month_sep".localize()))
        stack.addArrangedSubview(MonthNameView(text: "pf_month_oct".localize()))
        stack.addArrangedSubview(MonthNameView(text: "pf_month_nov".localize()))
        stack.addArrangedSubview(MonthNameView(text: "pf_month_dec".localize()))

        //  stack.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        let mainContainer = UIView()

        mainContainer.addSubview(titleButton)
        titleButton.layout.center.equal(to: mainContainer)

        mainContainer.addSubview(leftButton)
        leftButton.layout.left.equal(to: mainContainer, offset: CGFloat(mainHorizontalMargin))
        leftButton.layout.centerY.equal(to: mainContainer)

        mainContainer.addSubview(rightButton)
        rightButton.layout.right.equal(to: mainContainer, offset: -CGFloat(mainHorizontalMargin))
        rightButton.layout.centerY.equal(to: mainContainer)

        addSubview(mainContainer)
        mainContainer.layout.horizontal.equal(to: self)
        mainContainer.layout.top.equal(to: self)
        //      mainContainer.backgroundColor = .green
        mainContainer.layout.height.equal(to: 43)

        let monthsViewContainer = UIView()

        //    monthsViewContainer.backgroundColor = .cyan
        addSubview(monthsViewContainer)
        monthsViewContainer.layout.top.equal(to: mainContainer.layout.bottom)
        monthsViewContainer.layout.horizontal.equal(to: self)
        monthsViewContainer.layout.height.equal(to: 24)
        monthsViewContainer.layout.bottom.equal(to: self)
        monthsViewContainer.addSubview(monthsContainer)

        monthsContainer.layout.centerY.equal(to: monthsViewContainer)
        monthsContainer.layout.bottom.equal(to: monthsViewContainer)
        monthsContainer.layout.horizontal.equal(to: monthsViewContainer, offset: 8)
        //   monthsViewContainer.isHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func playTapHandler() {
    }
}
