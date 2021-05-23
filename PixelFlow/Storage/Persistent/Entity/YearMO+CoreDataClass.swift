//
//  YearMO+CoreDataClass.swift
//
//
//  Created by Елизавета on 16.05.2021.
//
//

import Foundation
import CoreData


public class YearMO: NSManagedObject {

    func save(yearInt: Int) {
        year = Int16(yearInt)
    }

}
