//
//  BoardMO+CoreDataProperties.swift
//  
//
//  Created by Елизавета on 22.05.2021.
//
//

import Foundation
import CoreData


extension BoardMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BoardMO> {
        return NSFetchRequest<BoardMO>(entityName: "Board")
    }

    @NSManaged public var colorSheme: Int16
    @NSManaged public var imageId: Int16
    @NSManaged public var mainColorId: Int16
    @NSManaged public var name: String?
    @NSManaged public var notifications: NSSet?
    @NSManaged public var parameters: NSSet?
    @NSManaged public var years: NSSet?

}

// MARK: Generated accessors for notifications
extension BoardMO {

    @objc(addNotificationsObject:)
    @NSManaged public func addToNotifications(_ value: NotificationMO)

    @objc(removeNotificationsObject:)
    @NSManaged public func removeFromNotifications(_ value: NotificationMO)

    @objc(addNotifications:)
    @NSManaged public func addToNotifications(_ values: NSSet)

    @objc(removeNotifications:)
    @NSManaged public func removeFromNotifications(_ values: NSSet)

}

// MARK: Generated accessors for parameters
extension BoardMO {

    @objc(addParametersObject:)
    @NSManaged public func addToParameters(_ value: BoardParameterMO)

    @objc(removeParametersObject:)
    @NSManaged public func removeFromParameters(_ value: BoardParameterMO)

    @objc(addParameters:)
    @NSManaged public func addToParameters(_ values: NSSet)

    @objc(removeParameters:)
    @NSManaged public func removeFromParameters(_ values: NSSet)

}

// MARK: Generated accessors for years
extension BoardMO {

    @objc(addYearsObject:)
    @NSManaged public func addToYears(_ value: YearMO)

    @objc(removeYearsObject:)
    @NSManaged public func removeFromYears(_ value: YearMO)

    @objc(addYears:)
    @NSManaged public func addToYears(_ values: NSSet)

    @objc(removeYears:)
    @NSManaged public func removeFromYears(_ values: NSSet)

}
