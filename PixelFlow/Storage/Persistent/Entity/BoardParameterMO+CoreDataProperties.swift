//
//  BoardParameterMO+CoreDataProperties.swift
//  
//
//  Created by Елизавета on 03.06.2021.
//
//

import Foundation
import CoreData


extension BoardParameterMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BoardParameterMO> {
        return NSFetchRequest<BoardParameterMO>(entityName: "BoardParameter")
    }

    @NSManaged public var colorId: Int16
    @NSManaged public var name: String
    @NSManaged public var inOrder: Int16

}
