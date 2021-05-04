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
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .leading
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

    func configureMonthsContainer() {
    }

    override func draw(_ rect: CGRect) {
        let view = UIView()
        addSubview(view)
        view.layout.horizontal.equal(to: self)
        view.layout.top.equal(to: self, offset: 8)
        
        let monthsContainer = monthsContainer//Label(type: .smallText)
      //  monthsContainer.text = "fff"
        addSubview(monthsContainer)
        monthsContainer.layout.bottom.equal(to: self, offset: -16)
        monthsContainer.layout.horizontal.equal(to: self, offset: CGFloat(mainHorizontalMargin) - 2)
      //  view.layout.bottom.equal(to: monthsContainer.layout.top)
        
        view.addSubview(titleButton)
        titleButton.layout.center.equal(to: view)

        view.addSubview(leftButton)
        leftButton.layout.left.equal(to: view, offset: CGFloat(mainHorizontalMargin))
        leftButton.layout.centerY.equal(to: view)

        view.addSubview(rightButton)
        rightButton.layout.right.equal(to: view, offset: -CGFloat(mainHorizontalMargin))
        rightButton.layout.centerY.equal(to: view)
    }


    @objc func playTapHandler() {

    }

}
