//
//  NotificationMO+CoreDataProperties.swift
//  
//
//  Created by Елизавета on 22.05.2021.
//
//

import Foundation
import CoreData


extension NotificationMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotificationMO> {
        return NSFetchRequest<NotificationMO>(entityName: "Notification")
    }

    @NSManaged public var isOn: Bool
    @NSManaged public var time: Date?

}
