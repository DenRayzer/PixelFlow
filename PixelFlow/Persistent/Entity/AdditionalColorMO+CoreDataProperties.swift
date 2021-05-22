//
//  AdditionalColorMO+CoreDataProperties.swift
//  
//
//  Created by Елизавета on 22.05.2021.
//
//

import Foundation
import CoreData


extension AdditionalColorMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AdditionalColorMO> {
        return NSFetchRequest<AdditionalColorMO>(entityName: "AdditionalColor")
    }

    @NSManaged public var colorId: Int16
    @NSManaged public var time: String?

}
