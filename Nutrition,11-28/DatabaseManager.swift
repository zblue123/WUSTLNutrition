//
//  DatabaseManager.swift
//  WUSTLNutrition
//
//  Created by zblue on 10/31/17.
//  Copyright © 2017 zblue. All rights reserved.
//

import Foundation
import UIKit
import CoreData


func save(name: String, calories: Int, fat: Int, carbs: Int, sodium: Int, protein: Int) {
    DispatchQueue.main.async {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
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
        food.setValue(name, forKeyPath: "name")
        food.setValue(calories, forKey: "calories")
        food.setValue(fat, forKey: "fat")
        food.setValue(carbs, forKey: "carbs")
        food.setValue(sodium, forKey: "sodium")
        food.setValue(protein, forKey: "protein")
        food.setValue(1, forKey: "num")
        food.setValue(1, forKey: "den")
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}

func saveGoals(calories: Int, fat: Int, carbs: Int, sodium: Int, protein: Int) {
    DispatchQueue.main.async {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        clearGoals(managedContext: managedContext)
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Goals",
                                       in: managedContext)!
        
        let goal = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        
        // 3
        goal.setValue(calories, forKey: "calories")
        goal.setValue(fat, forKey: "fat")
        goal.setValue(carbs, forKey: "carbs")
        goal.setValue(sodium, forKey: "sodium")
        goal.setValue(protein, forKey: "protein")
        
        // 4
        do {
            try managedContext.save()
            //databaseFoods.append(food)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}



func saveCustomFood(name: String, calories: Int, fat: Int, carbs: Int, sodium: Int, protein: Int) {
    //if savedFoods.keys.contains(name){ return }
    //print("save called on \(name)")
    DispatchQueue.main.async {
        save(name: name, calories: calories, fat: fat, carbs: carbs, sodium: sodium, protein: protein)
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "CustomFood",
                                       in: managedContext)!
        
        let food = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        
        // 3
        food.setValue(name, forKeyPath: "name")
        food.setValue(calories, forKey: "calories")
        food.setValue(fat, forKey: "fat")
        food.setValue(carbs, forKey: "carbs")
        food.setValue(sodium, forKey: "sodium")
        food.setValue(protein, forKey: "protein")
        food.setValue(1, forKey: "num")
        food.setValue(1, forKey: "den")
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}

func saveToDate(day: NutritionDay) {
    DispatchQueue.main.async {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        clearDay(day: day, managedContext: managedContext)
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "PastDay",
                                       in: managedContext)!
        
        let newDay = PastDay(context: managedContext)
        
        for f in day.foodsEaten {
            newDay.addObject(value: toDatabaseFormat(foodToConvert: f), forKey: "foodsEaten")
        }
        
        for f in day.customFoodsEaten {
            newDay.addObject(value: toDatabaseFormat(foodToConvert: f), forKey: "customFoodsEaten")
        }
        
        newDay.setValue(currentDate, forKey: "date")
        newDay.setValue(day.nutritionTotals["Total Calories"], forKey: "totalCalories")
        newDay.setValue(day.nutritionTotals["Total Fat"], forKey: "totalFat")
        newDay.setValue(day.nutritionTotals["Total Protein"], forKey: "totalProtein")
        newDay.setValue(day.nutritionTotals["Total Carbs"], forKey: "totalCarbs")
        newDay.setValue(day.nutritionTotals["Total Sodium"], forKey: "totalSodium")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}

func clearGoals(managedContext: NSManagedObjectContext) {
    let goalFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PastDay")
    do {
        let result = try managedContext.fetch(goalFetchRequest)
        for object in result {
            managedContext.delete(object)
        }
    } catch let error as NSError {
        print("Could not delete. \(error), \(error.userInfo)")
    }
}

func clearDay(day: NutritionDay, managedContext: NSManagedObjectContext) {
    let customFoodFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PastDay")
    do {
        let result = try managedContext.fetch(customFoodFetchRequest)
        let dayResult = result as! [PastDay]
        for object in dayResult {
            if object.date as Date? == day.date {
                managedContext.delete(object)
            }
        }
    } catch let error as NSError {
        print("Could not delete. \(error), \(error.userInfo)")
    }
}

func parseDatabaseFoods(data: [SavedFood]) {
    for savedFood in data {
        let foodToAdd = parseFood(savedFood: savedFood)
        savedFoods[savedFood.name!] = foodToAdd
    }
}

func parseFood(savedFood: SavedFood) -> Food {
    var dict: [String: Int] = [:]
    dict["Calories"] = Int(savedFood.calories)
    dict["Total Fat"] = Int(savedFood.fat)
    dict["Tot. Carb."] = Int(savedFood.carbs)
    dict["Protein"] = Int(savedFood.protein)
    dict["Sodium"] = Int(savedFood.sodium)
    return Food(nutritionalInformation: dict, name: savedFood.name!, num: Int(savedFood.num)==0 ? 1 : Int(savedFood.num), den: Int(savedFood.den)==0 ? 1 : Int(savedFood.den))
}

func parseCustomDatabaseFoods(data: [CustomFood]) {
    for customFood in data {
        var dict: [String: Int] = [:]
        dict["Calories"] = Int(customFood.calories)
        dict["Total Fat"] = Int(customFood.fat)
        dict["Tot. Carb."] = Int(customFood.carbs)
        dict["Protein"] = Int(customFood.protein)
        dict["Sodium"] = Int(customFood.sodium)
        dict["Quantity"] = 1
        let foodToAdd = Food(nutritionalInformation: dict, name: customFood.name!, num: Int(customFood.num)==0 ? 1 : Int(customFood.num), den: Int(customFood.den)==0 ? 1 : Int(customFood.den))
        customSavedFoods[customFood.name!] = foodToAdd
    }
}



func parseDatabaseDays(data: [PastDay]) {
    for day: PastDay in data {
        if let date = day.date {
            var items = day.mutableSetValue(forKey: "foodsEaten")
            var foodArr : [Food] = []
            var custFoodArr : [Food] = []
            
            for f in items {
                foodArr.append(parseFood(savedFood: f as! SavedFood))
            }
            
            items = day.mutableSetValue(forKey: "customFoodsEaten")
            for f in items {
                custFoodArr.append(parseFood(savedFood: f as! SavedFood))
            }
            
            var nutDict : [String: Int] = [:]
            nutDict["Total Calories"] = Int(day.totalCalories)
            nutDict["Total Carbs"] = Int(day.totalCarbs)
            nutDict["Total Protein"] = Int(day.totalProtein)
            nutDict["Total Fat"] = Int(day.totalFat)
            nutDict["Total Sodium"] = Int(day.totalSodium)
            
            savedDays[date as Date] = NutritionDay(date: date as Date,
                                                        foodsEaten: foodArr, customFoodsEaten: custFoodArr,
                                                        nutritionTotals: nutDict)
        }
        
    }
    if !savedDays.keys.contains(currentDate) {
        var dayDict : [String: Int] = [:]
        dayDict["Total Calories"] = 0
        dayDict["Total Carbs"] = 0
        dayDict["Total Protein"] = 0
        dayDict["Total Fat"] = 0
        dayDict["Total Sodium"] = 0
        
        let today = NutritionDay(date: currentDate,
                                foodsEaten: [],
                                customFoodsEaten: [],
                                nutritionTotals: dayDict)
        savedDays[currentDate] = today
        saveToDate(day: today)
    }
}

func parseGoals(data: [Goals]) {
    let goalData = data as [Goals]
    for goal in goalData {
        goals["Total Calories"] = Int(goal.calories)
        goals["Total Carbs"] = Int(goal.carbs)
        goals["Total Fat"] = Int(goal.fat)
        goals["Total Protein"] = Int(goal.protein)
        goals["Total Sodium"] = Int(goal.sodium)
    }
}
