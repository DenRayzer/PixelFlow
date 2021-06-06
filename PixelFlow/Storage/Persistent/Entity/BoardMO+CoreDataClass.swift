//
//  BoardMO+CoreDataClass.swift
//
//
//  Created by Елизавета on 16.05.2021.
//
//

import Foundation
import CoreData


public class BoardMO: NSManagedObject {

    func save(name: String = "pf_mood_board".localize(),
        imageName: String = "yin-yang-cyan",
        notifications: NSSet,
        parameters: NSSet,
        years: NSSet) {

        self.name = name
        self.imageName = imageName
        addToNotifications(notifications)
        addToParameters(parameters)
        addToYears(years)
    }

}
