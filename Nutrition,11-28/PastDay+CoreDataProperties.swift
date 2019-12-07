//
//  PastDay+CoreDataProperties.swift
//  WUSTLNutrition
//
//  Created by zblue on 11/19/17.
//  Copyright © 2017 zblue. All rights reserved.
//

import Foundation
import CoreData

extension PastDay {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PastDay> {
        return NSFetchRequest<PastDay>(entityName: "PastDay")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var totalCalories: Int16
    @NSManaged public var totalCarbs: Int16
    @NSManaged public var totalFat: Int16
    @NSManaged public var totalProtein: Int16
    @NSManaged public var totalSodium: Int16
    @NSManaged public var customFoodsEaten: NSSet?
    @NSManaged public var foodsEaten: NSSet?

}

extension PastDay {
    @objc(addCustomFoodsEatenObject:)
    @NSManaged public func addToCustomFoodsEaten(_ value: CustomFood)

    @objc(removeCustomFoodsEatenObject:)
    @NSManaged public func removeFromCustomFoodsEaten(_ value: CustomFood)

    @objc(addCustomFoodsEaten:)
    @NSManaged public func addToCustomFoodsEaten(_ values: NSSet)

    @objc(removeCustomFoodsEaten:)
    @NSManaged public func removeFromCustomFoodsEaten(_ values: NSSet)
}

extension PastDay {
    @objc(addFoodsEatenObject:)
    @NSManaged public func addToFoodsEaten(_ value: SavedFood)

    @objc(removeFoodsEatenObject:)
    @NSManaged public func removeFromFoodsEaten(_ value: SavedFood)

    @objc(addFoodsEaten:)
    @NSManaged public func addToFoodsEaten(_ values: NSSet)

    @objc(removeFoodsEaten:)
    @NSManaged public func removeFromFoodsEaten(_ values: NSSet)
}

extension NSManagedObject {
    func addObject(value: NSManagedObject, forKey key: String) {
        let items = self.mutableSetValue(forKey: key)
        items.add(value)
    }
    
    func removeObject(value: NSManagedObject, forKey key: String) {
        let items = self.mutableSetValue(forKey: key)
        items.remove(value)
    }
}
