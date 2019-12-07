//
//  ViewController.swift
//  WUSTLNutrition
//
//  Created by labuser on 10/1/17.
//  Copyright © 2017 labuser. All rights reserved.
//

import UIKit
import CoreData
import QuartzCore
import CoreGraphics
import ChameleonFramework
import Charts
//import SwiftCharts

class ViewController: UIViewController, UITabBarDelegate, UITabBarControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var foodsEatenLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var sodiumLabel: UILabel!
    @IBOutlet weak var carbLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var foodsEatenTableView: UITableView!
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 2{
            let destination = storyboard?.instantiateViewController(withIdentifier: "LocationNavigationViewController") as! UINavigationController
            self.present(destination, animated:true, completion: nil)
        }
        else if item.tag == 3{
            let destination = storyboard?.instantiateViewController(withIdentifier: "DateTableNavigationViewController") as! UINavigationController
            self.present(destination, animated:true, completion: nil)
        }
        else if item.tag == 4{
            print("hi there")
        }
    }
   
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var calLabel: UILabel!
    
    override func viewDidLoad() {
        isHistorical = false
        selectedLocation = nil
        super.viewDidLoad()
        
        print(selectedFood)
        print("day info: \(savedDays[currentDate]?.nutritionTotals)")
        calLabel.adjustsFontSizeToFitWidth = true
        proteinLabel.adjustsFontSizeToFitWidth = true
        sodiumLabel.adjustsFontSizeToFitWidth = true
        carbLabel.adjustsFontSizeToFitWidth = true
        fatLabel.adjustsFontSizeToFitWidth = true
 
        calLabel.textColor = FlatRed()
        self.navigationController?.navigationBar.barTintColor = FlatRed()
        self.navigationController?.navigationBar.tintColor = FlatWhite()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: FlatWhite()]

        
        //self.view.backgroundColor = FlatWhite()
       // NavigationTabBarController.tabBar.tintColor = FlatRed()
        //print(FlatRed().hexValue())
        //_ = ColorSchemeOf(ColorScheme.analogous, color: FlatRed()., isFlatScheme: true)
        //var colorArray = ColorSchemeOf(ColorScheme.Analogous, FlatRed(), true)
        //self.view.backgroundColor = FlatRed()
        // self.view.backgroundColor = UIColor.init(randomFlatColorOf: UIShadeStyle.light)
        //view.backgroundColor = UIColor.flatGreenDark
        
        //self.view.backgroundColor = UIColor(gradientStyle: UIGradientStyle.leftToRight, withFrame: self.view.frame, andColors: [FlatLime()])
       
        foodsEatenTableView.dataSource = self
        foodsEatenTableView.delegate = self
          //resetFoodsByLocation()
        //print(foodsByLocation)
        // Do any additional setup after loading the view, typically from a nib.
        //view.isHidden = true
        
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
         databaseStuff()
        
        
        //date info help pulled from
        //https://classictutorials.com/2015/07/how-to-get-current-day-month-and-year-in-nsdate-using-swift/
        
        
    
        //print("Current date is \(currentDateString)")
        populateLabels()
        

   
        crawl()
        //view.isHidden = false
        
        
        semaphore.wait()
        activityIndicator.stopAnimating()
        for i in 20...24 {
            makeRandomDay(day: i)
        }
        
    }
    
    func populateLabels() {
        if (savedDays[currentDate]?.foodsEaten.count)! > 0 || (savedDays[currentDate]?.customFoodsEaten.count)! > 0 {
            foodsEatenLabel.text = "Foods Eaten Today"
        } else {
            foodsEatenLabel.text = "No Foods Today"
        }
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        let currentDateString: String = dateFormatter.string(from: date)
        self.navigationController?.navigationBar.topItem?.title = currentDateString
        
        if let numVal = savedDays[currentDate]?.nutritionTotals["Total Calories"] {
            calLabel.text = "Calorie Count: \(numVal)"
        }
        else {
            calLabel.text = "No Calories Today"
        }
        let p = savedDays[currentDate]?.nutritionTotals["Total Protein"]
        let c = savedDays[currentDate]?.nutritionTotals["Total Carbs"]
        let f = savedDays[currentDate]?.nutritionTotals["Total Fat"]
        let s = savedDays[currentDate]?.nutritionTotals["Total Sodium"]
        proteinLabel.text = String(p!) + " g"
        carbLabel.text = String(c!) + " g"
        fatLabel.text = String(f!) + " g"
        sodiumLabel.text = String(s!) + " mg"
    }
    
    func databaseStuff() {
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let foodFetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "SavedFood")
        
        let daysFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PastDay")
        
        let customFoodFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CustomFood")
        
        let goalFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Goals")
        
        //3
        do {
            
            //print(databaseFoods as! [SavedFood])
            
            databaseFoods = try managedContext.fetch(foodFetchRequest)
            parseDatabaseFoods(data: databaseFoods  as! [SavedFood])
            
            databaseDays = try managedContext.fetch(daysFetchRequest)
            parseDatabaseDays(data: databaseDays as! [PastDay])
            
            customDatabaseFoods = try managedContext.fetch(customFoodFetchRequest)
            parseCustomDatabaseFoods(data: customDatabaseFoods as! [CustomFood])
            
            databaseGoals = try managedContext.fetch(goalFetchRequest)
            parseGoals(data: databaseGoals as! [Goals])
            
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    /*func pieChartStuff() {
        let labels = ["Carbohydrates", "Fats", "Protein"]
        let data = [
            (savedDays[currentDate]?.nutritionTotals["Total Carbs"]!)! * 4,
            (savedDays[currentDate]?.nutritionTotals["Total Fat"]!)! * 9,
            (savedDays[currentDate]?.nutritionTotals["Total Protein"]!)! * 4
        ]
        
        var entries : [PieChartDataEntry] = []
        let colors: [UIColor] = [UIColor.yellow, UIColor.green, UIColor.red]
        for i in 0..<labels.count {
            let percent = Double(data[i])/Double((savedDays[currentDate]?.nutritionTotals["Total Calories"]!)!) * 100.0
            let entry = PieChartDataEntry(value: percent, label: "\(Int(percent))"+labels[i])
            entries.append(entry)
        }
        
        let set = PieChartDataSet(values: entries, label: "Calories from Macronutrient Groups")
        set.colors = colors
        let theData = PieChartData(dataSet: set)
        pieChartView.data = theData
    }*/
    
   /* override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "SavedFood")
        
        //3
        do {
            databaseFoods = try managedContext.fetch(fetchRequest)
            parseDatabaseFoods(data: databaseFoods  as! [SavedFood])
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }*/
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if (savedDays[currentDate]?.foodsEaten.count)! > 0 && (savedDays[currentDate]?.customFoodsEaten.count)! > 0 {
            
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return (savedDays[currentDate]?.foodsEaten.count)!
        } else {
            return (savedDays[currentDate]?.customFoodsEaten.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Restaurant Foods"
        } else {
            return "Custom Foods"
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NutritionTableViewCell", for: indexPath) as! NutritionTableViewCell
        
        var pastFood : Food
        if indexPath.section == 0 {
            pastFood = (savedDays[currentDate]?.foodsEaten[indexPath.row])!
        } else {
            pastFood = (savedDays[currentDate]?.customFoodsEaten[indexPath.row])!
        }
        
        cell.foodNameLabel.text = pastFood.name

        if pastFood.den > 1 {
            cell.foodQuantityLabel.text = "\(pastFood.num)/\(pastFood.den)"
        } else {
            cell.foodQuantityLabel.text = String(pastFood.num)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isPast = true
        let destination = storyboard?.instantiateViewController(withIdentifier: "FoodViewNavigationController") as! UINavigationController
        if indexPath.section == 1{
            isCustom = true
        }
        selectedFood = indexPath.section == 0 ? savedDays[currentDate]?.foodsEaten[indexPath.row] : savedDays[currentDate]?.customFoodsEaten[indexPath.row]

        
        self.present(destination, animated: true, completion: nil)
    }
    
    // this method handles row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            var foodToRemove : Food
            if indexPath.section == 0 {
                foodToRemove = (savedDays[currentDate]?.foodsEaten[indexPath.row])!
                savedDays[currentDate]?.foodsEaten.remove(at: indexPath.row)
            } else {
                foodToRemove = (savedDays[currentDate]?.customFoodsEaten[indexPath.row])!
                savedDays[currentDate]?.customFoodsEaten.remove(at: indexPath.row)
            }
            deleteFood(foodToRemove: foodToRemove)
            populateLabels()
            tableView.reloadData()
            
        }
    }
    
    func deleteFood(foodToRemove: Food) {
        let quant = Double(foodToRemove.num) / Double(foodToRemove.den)
        savedDays[currentDate]?.nutritionTotals["Total Calories"]! -= Int(Double(foodToRemove.nutritionalInformation["Calories"]!) * quant)
        savedDays[currentDate]?.nutritionTotals["Total Protein"]! -= Int(Double(foodToRemove.nutritionalInformation["Protein"]!) * quant)
        savedDays[currentDate]?.nutritionTotals["Total Carbs"]! -= Int(Double(foodToRemove.nutritionalInformation["Tot. Carb."]!) * quant)
        savedDays[currentDate]?.nutritionTotals["Total Fat"]! -= Int(Double(foodToRemove.nutritionalInformation["Total Fat"]!) * quant)
        savedDays[currentDate]?.nutritionTotals["Total Sodium"]! -= Int(Double(foodToRemove.nutritionalInformation["Sodium"]!) * quant)
        saveToDate(day: savedDays[currentDate]!)
    }

}

