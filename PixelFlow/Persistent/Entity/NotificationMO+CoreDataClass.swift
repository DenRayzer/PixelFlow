//
//  NotificationMO+CoreDataClass.swift
//  
//
//  Created by Елизавета on 16.05.2021.
//
//

import Foundation
import CoreData


public class NotificationMO: NSManagedObject {

    convenience init(dateComponents: DateComponents = DateComponents(calendar: Calendar.current, hour: 20, minute: 0)) {
        self.init()

        time = Calendar.current.date(from: dateComponents) ?? Date()
    }

}
