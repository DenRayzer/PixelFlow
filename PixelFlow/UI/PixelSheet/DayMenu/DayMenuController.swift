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
    
    convenience init(for day: Day) {
        self.init()
        self.day = day
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.PF.background

        view.addSubview(layout)
        layout.layout.all.equal(to: view)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy, E"
        dateFormatter.locale = Locale.current
        layout.dayInfoLabel.text =  dateFormatter.string(from: day.date)
    }
    
}
