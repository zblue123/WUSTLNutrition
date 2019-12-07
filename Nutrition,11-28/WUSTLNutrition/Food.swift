//
//  Food.swift
//  WUSTLNutrition
//
//  Created by labuser on 10/1/17.
//  Copyright © 2017 labuser. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct Food {
    var nutritionalInformation : [String : Int]
    var name : String
    var num : Int
    var den : Int
}

extension Food: Equatable {}

func ==(lhs: Food, rhs: Food) -> Bool {
    return lhs.name == rhs.name
}

func getRandomFood() -> Food {
    let index: Int = Int(arc4random_uniform(UInt32(savedFoods.count)))
    var f = Array(savedFoods.values)[index]
    f.den = Int(arc4random_uniform(UInt32(3)))+1
    f.num = 1
    if f.den == f.num {
        f.den = 1
        f.num = 1
    }
    return f
}

func getRandomCustomFood() -> Food? {
    if customSavedFoods.count == 0 {
        return nil
    }
    let index: Int = Int(arc4random_uniform(UInt32(customSavedFoods.count)))
    var f = Array(customSavedFoods.values)[index]
    f.den = Int(arc4random_uniform(UInt32(10)))+1
    f.num = 1
    if f.den == f.num {
        f.den = 1
        f.num = 1
    }
    return f
}

func toDatabaseFormat(foodToConvert: Food) -> NSManagedObject {
    guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
            return NSManagedObject()
    }
    
    // 1
    let managedContext =
        appDelegate.persistentContainer.viewContext
    
    // 2
    let entity =
        NSEntityDescription.entity(forEntityName: "SavedFood",
                                   in: managedContext)!
    
    let food = NSManagedObject(entity: entity,
                               insertInto: managedContext)
    
    // 3
    let theDict = foodToConvert.nutritionalInformation
    food.setValue(foodToConvert.name, forKeyPath: "name")
    food.setValue(theDict["Calories"], forKey: "calories")
    food.setValue(theDict["Total Fat"], forKey: "fat")
    food.setValue(theDict["Tot. Carb."], forKey: "carbs")
    food.setValue(theDict["Sodium"], forKey: "sodium")
    food.setValue(theDict["Protein"], forKey: "protein")
    food.setValue(foodToConvert.num, forKey: "num")
    food.setValue(foodToConvert.den, forKey: "den")
    
    return food
}
