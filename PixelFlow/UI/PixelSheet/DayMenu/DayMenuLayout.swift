//
//  DayMenuLayout.swift
//  PixelFlow
//
//  Created by Elizaveta on 4/24/21.
//

import UIKit

class DayMenuLayout: UIView {
    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.isScrollEnabled = true
        return scrollView
    }()

    var dayInfoLabel = Label(type: .title)
    private(set) lazy var container: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    private func setupViews() {

        // Drawing code
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(dayInfoLabel)
        dayInfoLabel.layout.top.equal(to: self, offset: 20)
        dayInfoLabel.layout.left.equal(to: self, offset: 16)
        
        addSubview(scrollView)
        scrollView.layout.top.equal(to: dayInfoLabel.layout.bottom, offset: 20)
        scrollView.layout.bottom.equal(to: self)
        scrollView.layout.horizontal.equal(to: self)

        setupColorItems()
    }

    private func setupColorItems() {
        scrollView.addSubview(container)
        container.layout.top.equal(to: scrollView, offset: 4)
        container.layout.left.equal(to: scrollView, offset: 16)
        container.layout.bottom.equal(to: scrollView, offset: 16)

        container.addArrangedSubview(ColorInfoItem(color: UIColor.colorScheme.lightGreen, text: "pf_day_mood_excellent".localize()))
        container.addArrangedSubview(ColorInfoItem(color: UIColor.colorScheme.darkGreen, text: "pf_day_mood_good".localize()))
        container.addArrangedSubview(ColorInfoItem(color: UIColor.colorScheme.pink, text: "pf_day_mood_lazy".localize()))
        container.addArrangedSubview(ColorInfoItem(color: UIColor.colorScheme.orange, text: "pf_day_mood_ordinary".localize()))
        container.addArrangedSubview(ColorInfoItem(color: UIColor.colorScheme.vinous, text: "pf_day_mood_bad".localize()))
        container.addArrangedSubview(ColorInfoItem(color: UIColor.colorScheme.dustyRose, text: "pf_day_mood_tired".localize()))
        container.addArrangedSubview(ColorInfoItem(color: UIColor.colorScheme.brown, text: "pf_day_mood_sick".localize()))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
