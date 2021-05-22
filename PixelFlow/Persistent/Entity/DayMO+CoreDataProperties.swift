//
//  DayMO+CoreDataProperties.swift
//  
//
//  Created by Елизавета on 22.05.2021.
//
//

import Foundation
import CoreData


extension DayMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayMO> {
        return NSFetchRequest<DayMO>(entityName: "Day")
    }

    @NSManaged public var date: Date?
    @NSManaged public var colorId: Int16
    @NSManaged public var note: NSOrderedSet?
    @NSManaged public var additionalColor: AdditionalColorMO?

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
