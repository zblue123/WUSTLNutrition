//
//  CustomFood+CoreDataProperties.swift
//  WUSTLNutrition
//
//  Created by labuser on 11/19/17.
//  Copyright © 2017 labuser. All rights reserved.
//

import Foundation
import CoreData


extension CustomFood {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomFood> {
        return NSFetchRequest<CustomFood>(entityName: "CustomFood")
    }

    @NSManaged public var calories: Int16
    @NSManaged public var carbs: Int16
    @NSManaged public var fat: Int16
    @NSManaged public var name: String?
    @NSManaged public var protein: Int16
    @NSManaged public var sodium: Int16
    @NSManaged public var daysEaten: NSSet?
    @NSManaged public var num: Int16
    @NSManaged public var den: Int16

}

// MARK: Generated accessors for daysEaten
extension CustomFood {

    @objc(addDaysEatenObject:)
    @NSManaged public func addToDaysEaten(_ value: PastDay)

    @objc(removeDaysEatenObject:)
    @NSManaged public func removeFromDaysEaten(_ value: PastDay)

    @objc(addDaysEaten:)
    @NSManaged public func addToDaysEaten(_ values: NSSet)

    @objc(removeDaysEaten:)
    @NSManaged public func removeFromDaysEaten(_ values: NSSet)

}
