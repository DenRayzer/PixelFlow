//
//  DayMenuController.swift
//  PixelFlow
//
//  Created by Elizaveta on 4/24/21.
//

import UIKit

class DayMenuController: UIViewController {
    let layout = DayMenuLayout()
    let storageManager: StorageManager = StorageManager()

    private var day = Day(date: Date())
    private var delegate: DayMenuDelegate!

    convenience init(for day: Day, delegate: DayMenuDelegate) {
        self.init()
        self.day = day
        layout.setCheckedView(type: day.type)
        layout.additionalColors = day.additionalColors
        layout.notes = day.notes
        self.delegate = delegate

        layout.setupViews()
        layout.setCheckedView(type: day.type)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        configureDayMenu()
    }

    private func configureDayMenu() {
        for dayItem in layout.dayInfoContainer.arrangedSubviews {
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(mainColorTap(_:)))
            dayItem.addGestureRecognizer(recognizer)
        }
    }

    @objc
    func mainColorTap(_ sender: UITapGestureRecognizer? = nil) {
        guard let view = sender?.view as? ColorInfoItem else { return }
        if layout.activeAdditionalColor == nil {
            delegate.onDayMenuItemTap(dayType: view.type)
            view.colorView.addView(view: UIImageView(image: #imageLiteral(resourceName: "check")))
            layout.selectedItem?.colorView.addView(view: nil)
            layout.selectedItem = view
            day.type = view.type
            storageManager.saveDay(day: day)
        } else {
            guard let activeAdditionalColor = layout.activeAdditionalColor else { return }
            activeAdditionalColor.changeColorView(with: view.type)
            layout.additionalColors.append(AdditionalColor(colorId: view.type.rawValue, date: activeAdditionalColor.date))
            layout.activeAdditionalColor = nil
            day.additionalColors = layout.additionalColors
            storageManager.saveDay(day: day)
        }
    }

    private func setupViews() {
        view.backgroundColor = UIColor.PF.background

        view.addSubview(layout)
        layout.layout.all.equal(to: view)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy, E"
        dateFormatter.locale = Locale.current
        layout.dayInfoLabel.text = dateFormatter.string(from: day.date).lowercased()
        layout.saveNoteAction = { [weak self] notes in
            guard let self = self else { return }
            self.day.notes = notes
            self.storageManager.saveDay(day: self.day)
        }
    }
}
