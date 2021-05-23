//
//  DayMO+CoreDataProperties.swift
//  
//
//  Created by Елизавета on 23.05.2021.
//
//

import Foundation
import CoreData


extension DayMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayMO> {
        return NSFetchRequest<DayMO>(entityName: "Day")
    }

    @NSManaged public var colorId: Int16
    @NSManaged public var date: Date
    @NSManaged public var additionalColor: NSOrderedSet?
    @NSManaged public var note: NSOrderedSet?

}

// MARK: Generated accessors for additionalColor
extension DayMO {

    @objc(insertObject:inAdditionalColorAtIndex:)
    @NSManaged public func insertIntoAdditionalColor(_ value: AdditionalColorMO, at idx: Int)

    @objc(removeObjectFromAdditionalColorAtIndex:)
    @NSManaged public func removeFromAdditionalColor(at idx: Int)

    @objc(insertAdditionalColor:atIndexes:)
    @NSManaged public func insertIntoAdditionalColor(_ values: [AdditionalColorMO], at indexes: NSIndexSet)

    @objc(removeAdditionalColorAtIndexes:)
    @NSManaged public func removeFromAdditionalColor(at indexes: NSIndexSet)

    @objc(replaceObjectInAdditionalColorAtIndex:withObject:)
    @NSManaged public func replaceAdditionalColor(at idx: Int, with value: AdditionalColorMO)

    @objc(replaceAdditionalColorAtIndexes:withAdditionalColor:)
    @NSManaged public func replaceAdditionalColor(at indexes: NSIndexSet, with values: [AdditionalColorMO])

    @objc(addAdditionalColorObject:)
    @NSManaged public func addToAdditionalColor(_ value: AdditionalColorMO)

    @objc(removeAdditionalColorObject:)
    @NSManaged public func removeFromAdditionalColor(_ value: AdditionalColorMO)

    @objc(addAdditionalColor:)
    @NSManaged public func addToAdditionalColor(_ values: NSOrderedSet)

    @objc(removeAdditionalColor:)
    @NSManaged public func removeFromAdditionalColor(_ values: NSOrderedSet)

}

// MARK: Generated accessors for note
extension DayMO {

    @objc(insertObject:inNoteAtIndex:)
    @NSManaged public func insertIntoNote(_ value: NoteMO, at idx: Int)

    @objc(removeObjectFromNoteAtIndex:)
    @NSManaged public func removeFromNote(at idx: Int)

    @objc(insertNote:atIndexes:)
    @NSManaged public func insertIntoNote(_ values: [NoteMO], at indexes: NSIndexSet)

    @objc(removeNoteAtIndexes:)
    @NSManaged public func removeFromNote(at indexes: NSIndexSet)

    @objc(replaceObjectInNoteAtIndex:withObject:)
    @NSManaged public func replaceNote(at idx: Int, with value: NoteMO)

    @objc(replaceNoteAtIndexes:withNote:)
    @NSManaged public func replaceNote(at indexes: NSIndexSet, with values: [NoteMO])

    @objc(addNoteObject:)
    @NSManaged public func addToNote(_ value: NoteMO)

    @objc(removeNoteObject:)
    @NSManaged public func removeFromNote(_ value: NoteMO)

    @objc(addNote:)
    @NSManaged public func addToNote(_ values: NSOrderedSet)

    @objc(removeNote:)
    @NSManaged public func removeFromNote(_ values: NSOrderedSet)

}
