//
//  NutritionDay.swift
//  WUSTLNutrition
//
//  Created by labuser on 11/5/17.
//  Copyright © 2017 labuser. All rights reserved.
//

import Foundation

struct NutritionDay {
    var date : Date 
    var foodsEaten : [Food]
    var customFoodsEaten : [Food]
    var nutritionTotals : [String: Int]
    
    mutating func addFoodRandomQuantity(food: Food, isCustom: Bool) {
        var newTotals = self.nutritionTotals
        let quant = Double(food.num)/Double(food.den)
        newTotals["Total Calories"]! += Int(Double(food.nutritionalInformation["Calories"]!) * quant)
        newTotals["Total Carbs"]! += Int(Double(food.nutritionalInformation["Tot. Carb."]!) * quant)
        newTotals["Total Protein"]! += Int(Double(food.nutritionalInformation["Protein"]!) * quant)
        newTotals["Total Fat"]! += Int(Double(food.nutritionalInformation["Total Fat"]!) * quant)
        newTotals["Total Sodium"]! += Int(Double(food.nutritionalInformation["Sodium"]!) * quant)
        self.nutritionTotals = newTotals
        isCustom ? self.customFoodsEaten.append(food) : self.foodsEaten.append(food)
    }
}

func makeRandomDay(day: Int)  {
    let date = makeDate(day: day, month: 11)
    var dayDict : [String: Int] = [:]
    dayDict["Total Calories"] = 0
    dayDict["Total Carbs"] = 0
    dayDict["Total Protein"] = 0
    dayDict["Total Fat"] = 0
    dayDict["Total Sodium"] = 0
    
    var day = NutritionDay(date: date, foodsEaten: [], customFoodsEaten: [], nutritionTotals: dayDict)
    
    let customFoodQaunt = Int(arc4random_uniform(UInt32(3)))
    for _ in 0...customFoodQaunt {
        if let f = getRandomCustomFood() {
            print(day.nutritionTotals)
            print("+food: \(f.nutritionalInformation)")
            day.addFoodRandomQuantity(food: f, isCustom: true)
            print(day.nutritionTotals)
        }
    }
    
    let foodQuant = Int(arc4random_uniform(UInt32(3)))
    for _ in 0...foodQuant {
        day.addFoodRandomQuantity(food: getRandomFood(), isCustom: false)
    }
    
   savedDays[date] = day
}


func makeDate(day: Int, month: Int) -> Date {
    // Specify date components
    var dateComponents = DateComponents()
    dateComponents.year = 2017
    dateComponents.month = month
    dateComponents.day = day
    dateComponents.timeZone = TimeZone(abbreviation: "CST")
    dateComponents.hour = 0
    dateComponents.minute = 0
    
    // Create date from components
    let userCalendar = Calendar.current // user calendar
    return userCalendar.date(from: dateComponents)!
}

