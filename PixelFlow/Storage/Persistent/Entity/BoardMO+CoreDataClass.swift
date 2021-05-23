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
        imageId: Int = 0,
        notification: NotificationMO,
        parameters: NSSet,
        years: NSSet) {

        self.name = name
        self.imageId = Int16(imageId)
        addToNotifications(notification)
        addToParameters(parameters)
        addToYears(years)
    }

}
