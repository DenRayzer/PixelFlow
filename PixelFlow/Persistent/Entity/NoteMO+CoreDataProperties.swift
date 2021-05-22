//
//  NoteMO+CoreDataProperties.swift
//  
//
//  Created by Елизавета on 22.05.2021.
//
//

import Foundation
import CoreData


extension NoteMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteMO> {
        return NSFetchRequest<NoteMO>(entityName: "Note")
    }

    @NSManaged public var note: String?
    @NSManaged public var time: Date?

}
