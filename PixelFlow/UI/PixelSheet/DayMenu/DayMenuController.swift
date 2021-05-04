//
//  DayMenuController.swift
//  PixelFlow
//
//  Created by Elizaveta on 4/24/21.
//

import UIKit

class DayMenuController: UIViewController {
    let layout = DayMenuLayout()
    private var day = Day(date: Date())
    private var delegate: DayMenuDelegate!

    convenience init(for day: Day, delegate: DayMenuDelegate) {
        self.init()
        self.day = day
        layout.setCheckedView(type: day.type)
        self.delegate = delegate
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        configureDayMenu()
    }

    private func configureDayMenu() {
        for dayItem in layout.dayInfoContainer.arrangedSubviews {
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            dayItem.addGestureRecognizer(recognizer)
        }
    }

    @objc
    func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        guard let view = sender?.view as? ColorInfoItem else { return }
        delegate.onDayMenuItemTap(dayType: view.type)
        view.colorView.addView(view: UIImageView(image: #imageLiteral(resourceName: "check")))
        layout.selectedItem?.colorView.addView(view: nil)
        layout.selectedItem = view
    }

    private func setupViews() {
        view.backgroundColor = UIColor.PF.background

        view.addSubview(layout)
        layout.layout.all.equal(to: view)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy, E"
        dateFormatter.locale = Locale.current
        layout.dayInfoLabel.text = dateFormatter.string(from: day.date).lowercased()
    }
}
