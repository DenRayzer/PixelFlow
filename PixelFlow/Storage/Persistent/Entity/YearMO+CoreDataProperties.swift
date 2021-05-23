//
//  YearMO+CoreDataProperties.swift
//  
//
//  Created by Елизавета on 22.05.2021.
//
//

import Foundation
import CoreData


extension YearMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<YearMO> {
        return NSFetchRequest<YearMO>(entityName: "Year")
    }

    @NSManaged public var year: Int16
    @NSManaged public var days: NSOrderedSet?

}

// MARK: Generated accessors for days
extension YearMO {

    @objc(insertObject:inDaysAtIndex:)
    @NSManaged public func insertIntoDays(_ value: DayMO, at idx: Int)

    @objc(removeObjectFromDaysAtIndex:)
    @NSManaged public func removeFromDays(at idx: Int)

    @objc(insertDays:atIndexes:)
    @NSManaged public func insertIntoDays(_ values: [DayMO], at indexes: NSIndexSet)

    @objc(removeDaysAtIndexes:)
    @NSManaged public func removeFromDays(at indexes: NSIndexSet)

    @objc(replaceObjectInDaysAtIndex:withObject:)
    @NSManaged public func replaceDays(at idx: Int, with value: DayMO)

    @objc(replaceDaysAtIndexes:withDays:)
    @NSManaged public func replaceDays(at indexes: NSIndexSet, with values: [DayMO])

    @objc(addDaysObject:)
    @NSManaged public func addToDays(_ value: DayMO)

    @objc(removeDaysObject:)
    @NSManaged public func removeFromDays(_ value: DayMO)

    @objc(addDays:)
    @NSManaged public func addToDays(_ values: NSOrderedSet)

    @objc(removeDays:)
    @NSManaged public func removeFromDays(_ values: NSOrderedSet)

}
