//
//  Info.swift
//  WUSTLNutrition
//
//  Created by zblue on 10/2/17.
//  Copyright © 2017 zblue. All rights reserved.
//

import Foundation
import CoreData

let urlsToVisit = [
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=73%28a%29&locationName=BEAR%27S+DEN+%2D+Ciao+Down&naFlag=1")! : "Bear's Den - Ciao Down",
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=73%28f%29&locationName=BEAR%27S+DEN+%2D+Grizzly+Grill&naFlag=1")! : "Bear's Den - Grizzly Grill" ,
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=73%28e%29&locationName=BEAR%27S+DEN+%2D+L%27Chaim&naFlag=1")! : "Bear's Den - L'Chaim",
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=73%28b%29&locationName=BEAR%27S+DEN+%2D+OSO+Good&naFlag=1")! : "Bear's Den - OSO Good" ,
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=73%28c%29&locationName=BEAR%27S+DEN+%2D+Sizzle+%26+Stir&naFlag=1")! : "Bear's Den - Sizzle and Stir" ,
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=73%28d%29&locationName=BEAR%27S+DEN+%2D+WUrld+Fusion&naFlag=1")! : "Bear's Den - WUrld Fusion",
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=50&locationName=CAF%26Eacute+BERGSON&naFlag=1")! : "Cafe Bergson",
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=73&locationName=CHERRY+TREE+CAF%26Eacute&naFlag=1")! : "Cherry Tree Cafe",
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=51&locationName=DUC+%2D+1853+Diner&naFlag=1")! : "DUC - 1853 Diner",
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=51%28c%29&locationName=DUC+%2D+DeliciOSO&naFlag=1")! : "DUC - Delicioso",
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=51%28b%29&locationName=DUC+%2D+Trattoria+Verde&naFlag=1")! : "DUC - Trattoria Verde",
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=51%28a%29&locationName=DUC+%2D+Wash+U+Wok&naFlag=1")! : "DUC - Wash U Wok",
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=42&locationName=ETTA%27S&naFlag=1")! : "Etta's",
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=49&locationName=GROUNDS+FOR+CHANGE&naFlag=1")! : "Grounds for Change",
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=43&locationName=HOLMES+LOUNGE&naFlag=1")! : "Holmes Lounge",
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=44&locationName=+LAW+CAF%26Eacute%3B&naFlag=1")! : "Law Cafe",
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=61&locationName=MILLBROOK+MARKET+%26+COFFEE+CONNECTION&naFlag=1")! : "Millbrook Market",
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=45&locationName=NORTHERN+BITES&naFlag=1")! : "Northern Bites",
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=72&locationName=PAWS+%26+GO+MARKET&naFlag=1")! : "Paws and Go Market",
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=74&locationName=PREPACKS&naFlag=1")! : "Prepacks",
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=46&locationName=STANLEY%27S&naFlag=1")! : "Stanley's" ,
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=60%28b%29&locationName=THE+VILLAGE+%2D+Comfort&naFlag=1&WeeksMenus=This+Week%27s+Menus&myaction=read&dtdate=10%2F4%2F2017")! : "The Village - Comfort" ,
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=60%28a%29&locationName=THE+VILLAGE+%2D+Deli&naFlag=1")! : "The Village - Deli" ,
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=60&locationName=THE+VILLAGE+%2D+Grill&naFlag=1")! : "The Village - Grill" ,
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=60%28c%29&locationName=THE+VILLAGE+%2D+Stir+Fry&naFlag=1")! : "The Village - Stir Fry" ,
    URL(string: "http://menus.wustl.edu/shortmenu.asp?sName=+&locationNum=47&locationName=WEST+CAMPUS+CAF%26Eacute%3B&naFlag=1")! : "West Campus Cafe"
]

var foodsByLocation : [String: [Food]] = [
    "Bear's Den - Ciao Down" : [],
    "Bear's Den - Grizzly Grill" : [],
    "Bear's Den - L'Chaim": [],
    "Bear's Den - OSO Good": [] ,
    "Bear's Den - Sizzle and Stir": [] ,
    "Bear's Den - WUrld Fusion": [],
    "Cafe Bergson": [],
    "Cherry Tree Cafe": [],
    "DUC - 1853 Diner": [],
    "DUC - Delicioso": [],
    "DUC - Trattoria Verde": [],
    "DUC - Wash U Wok": [],
    "Etta's": [],
    "Grounds for Change": [],
    "Holmes Lounge": [],
    "Law Cafe": [],
    "Millbrook Market": [],
    "Northern Bites": [],
    "Paws and Go Market": [],
    "Prepacks": [],
    "Stanley's" : [],
    "The Village - Comfort" : [],
    "The Village - Deli" : [],
    "The Village - Grill" : [],
    "The Village - Stir Fry" : [],
    "West Campus Cafe": []
]

func resetFoodsByLocation() {
    foodsByLocation = [
        "Bear's Den - Ciao Down" : [],
        "Bear's Den - Grizzly Grill" : [],
        "Bear's Den - L'Chaim": [],
        "Bear's Den - OSO Good": [] ,
        "Bear's Den - Sizzle and Stir": [] ,
        "Bear's Den - WUrld Fusion": [],
        "Cafe Bergson": [],
        "Cherry Tree Cafe": [],
        "DUC - 1853 Diner": [],
        "DUC - Delicioso": [],
        "DUC - Trattoria Verde": [],
        "DUC - Wash U Wok": [],
        "Etta's": [],
        "Grounds for Change": [],
        "Holmes Lounge": [],
        "Law Cafe": [],
        "Millbrook Market": [],
        "Northern Bites": [],
        "Paws and Go Market": [],
        "Prepacks": [],
        "Stanley's" : [],
        "The Village - Comfort" : [],
        "The Village - Deli" : [],
        "The Village - Grill" : [],
        "The Village - Stir Fry" : [],
        "West Campus Cafe": []
    ]
}

var selectedLocation : String? = nil
var selectedFood : Food? = nil
var selectedDate : Date? = nil

var isPast = false

let attributes = ["Calories","Total Fat","Tot. Carb.","Sodium","Protein"]

var databaseFoods : [NSManagedObject] = []
var savedFoods : [String: Food] = [:]

var customDatabaseFoods: [NSManagedObject] = []
var customSavedFoods : [String: Food] = [:]

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        
        return result
    }
}

var isCustom = false

var isHistorical = false

var databaseDays : [NSManagedObject] = []
var savedDays : [Date : NutritionDay] = [:]

var databaseGoals : [NSManagedObject] = []

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        print("formatted string: \(dateFormatter.string(from: self))")
        return dateFormatter.string(from: self)
    }
    
    func dayInt() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return Int(dateFormatter.string(from: self))!
    }
    
}

var goals : [String: Int] = ["Total Protein": 50, "Total Calories": 3000, "Total Sodium": 2000, "Total Carbs": 100, "Total Fat": 80]

let currentDate = Calendar.current.startOfDay(for: Date())

typealias Rational = (num : Int, den : Int)

func rationalApproximationOf(x0 : Double, withPrecision eps : Double = 1.0E-6) -> [Int] {
    var x = x0
    var a = floor(x)
    var (h1, k1, h, k) = (1, 0, Int(a), 1)
    
    while x - a > eps * Double(k) * Double(k) {
        x = 1.0/(x - a)
        a = floor(x)
        (h1, k1, h, k) = (h, k, h1 + Int(a) * h, k1 + Int(a) * k)
    }
    return [h, k]
}

extension Double {
    var isInt: Bool {
        let intValue = Int(self)
        return  Double(intValue) == self
    }
}
