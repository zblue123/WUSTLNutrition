//
//  Scraper.swift
//  WUSTLNutrition
//
//  Created by zblue on 10/1/17.
//  Copyright © 2017 zblue. All rights reserved.
//


// taken from https://medium.com/swiftly-swift/how-to-make-a-web-crawler-in-swift-3ed4977a181b
import Foundation

let wordToSearch = "Recipe_Desc"
let maximumPagesToVisit = 100

let semaphore = DispatchSemaphore(value: 0)
var visitedPages: Set<URL> = []
var pagesToVisit = Set(urlsToVisit.keys)

func crawl() {
    
    guard visitedPages.count <= maximumPagesToVisit else {
        semaphore.signal()
        return
    }
    guard let pageToVisit = pagesToVisit.popFirst() else {
        semaphore.signal()
        return
    }
    
    if visitedPages.contains(pageToVisit) {
        crawl()
    } else {
        visit(page: pageToVisit)
    }
}
        
func visit(page url: URL) {
    visitedPages.insert(url)
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        defer { crawl() }
        guard
            let data = data,
            error == nil,
            let document = String(data: data, encoding: .utf8) else { return }
        parse(document: document, url: url)
    }
    
    task.resume()
}


func visitFood(page url: URL, location: String){
    if (visitedPages.contains(url)){
        return
    }
    visitedPages.insert(url)
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        defer { crawl() }
        guard
            let data = data,
            error == nil,
            let document = String(data: data, encoding: .utf8) else { return }
        parseFood(document: document, url: url, location: location)
    }
    
    task.resume()
}

func parse(document: String, url: URL) {
    func find(word: String) {
        var updatedDocument = document
        
        let matchFoodString = "onmouseover=\javascript:openDescWin('','"
        let closeFoodString = "'"
        
        let match_string = "onmouseout=\"javascript:closeDescWin()\" href='"
        let closing = "'"
        
        while updatedDocument.contains(matchFoodString) {
            if let range = updatedDocument.range(of: matchFoodString) {
                let remaingDocument = updatedDocument.substring(from: range.upperBound)
                if let range2 = remaingDocument.range(of: closeFoodString) {
                    var foodName = remaingDocument.substring(to: range2.upperBound)
                    foodName.remove(at: foodName.index(before: foodName.endIndex))
                    updatedDocument = updatedDocument.substring(from: range2.lowerBound)
                    if savedFoods.keys.contains(foodName) && !foodsByLocation[urlsToVisit[url]!]!.contains(savedFoods[foodName]!){
                        foodsByLocation[urlsToVisit[url]!]!.append(savedFoods[foodName]!)
                    } else {
                        if let range = updatedDocument.range(of: match_string) {
                            let remaingDocument = updatedDocument.substring(from: range.upperBound)
                            if let range2 = remaingDocument.range(of: closing) {
                                var s = remaingDocument.substring(to: range2.upperBound)
                                s.remove(at: s.index(before: s.endIndex))

                                let newUrl = URL(string:"http://menus.wustl.edu/" + s)                            
                                updatedDocument = updatedDocument.substring(from: range2.lowerBound)
                                visitFood(page: newUrl!, location: urlsToVisit[url]!)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func collectLinks() -> [URL] {
        func getMatches(pattern: String, text: String) -> [String] {
            // used to remove the 'href="' & '"' from the matches
            func trim(url: String) -> String {
                return String(url.characters.dropLast()).substring(from: url.index(url.startIndex, offsetBy: "href=\".characters.count))
            }
            
            let regex = try! NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
            let matches = regex.matches(in: text, options: [.reportCompletion], range: NSRange(location: 0, length: text.characters.count))
            return matches.map { trim(url: (text as NSString).substring(with: $0.range)) }
        }
        
        let pattern = "href=\"(http://.*?|https://.*?)\""
        let matches = getMatches(pattern: pattern, text: document)
        return matches.flatMap { URL(string: $0) }
    }
    
    find(word: wordToSearch)
    collectLinks().forEach { pagesToVisit.insert($0) }
}

//crawls for nutrition info
func parseFood(document: String, url: URL, location: String){
    var foodDict = [String: Int]()
    
    var match = "Calories&nbsp;"
    var closing = "<"
    
    if let range = document.range(of: match) {
        let remaingDocument = document.substring(from: range.upperBound)
        if let range2 = remaingDocument.range(of: closing) {
            var s = remaingDocument.substring(to: range2.upperBound)
            s.remove(at: s.index(before: s.endIndex))
            foodDict["Calories"] = (s as NSString).integerValue
            if (foodDict["Calories"] == 0) {
                return
            }
        }
    }
    
    match = "labelrecipe\"
    var foodName = ""
    if let range = document.range(of: match) {
        let remaingDocument = document.substring(from: range.upperBound)
        if let range2 = remaingDocument.range(of: closing) {
            var s = remaingDocument.substring(to: range2.upperBound)
            s.remove(at: s.index(before: s.endIndex))
            foodName = s
        }
    }
    
    
    for attribute in attributes {
        match = attribute+"&nbsp;</b></font><font face=\"arial\" size=\"4\">"
        let match_alt = attribute+"&nbsp;</b></font><font size=\"4\" face=\"arial\">"
        closing = (attribute=="Sodium" ? "mg" : "g")
        
        if let range = document.range(of: match) {
            let remaingDocument = document.substring(from: range.upperBound)
            if let range2 = remaingDocument.range(of: closing) {
                var s = remaingDocument.substring(to: range2.upperBound)
                s.remove(at: s.index(before: s.endIndex))
                foodDict[attribute] = (s as NSString).integerValue
            }
        } else if let range = document.range(of: match_alt) {
            let remaingDocument = document.substring(from: range.upperBound)
            if let range2 = remaingDocument.range(of: closing) {
                var s = remaingDocument.substring(to: range2.upperBound)
                s.remove(at: s.index(before: s.endIndex))
                foodDict[attribute] = (s as NSString).integerValue
            }
        }
        
    }
    
    let food = Food(nutritionalInformation: foodDict, name: foodName, num: 1, den: 1)
    savedFoods[foodName] = food
    save(name: foodName, calories: foodDict["Calories"]!, fat: foodDict["Total Fat"]!, carbs: foodDict["Tot. Carb."]!, sodium: foodDict["Sodium"]!, protein: foodDict["Protein"]!)
    if !foodsByLocation[location]!.contains(food) {
        foodsByLocation[location]!.append(food)
    } 
}
    




