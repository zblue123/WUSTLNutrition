//
//  PastDayViewController.swift
//  WUSTLNutrition
//
//  Created by labuser on 11/16/17.
//  Copyright © 2017 labuser. All rights reserved.
//

import UIKit
import ChameleonFramework

class PastDayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var sodiumLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var carbLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var foodsEatenLabel: UILabel!
    @IBOutlet weak var foodsEatenTableView: UITableView!
    
    @IBAction func backToDateList(_ sender: Any) {
        let destination = storyboard?.instantiateViewController(withIdentifier: "DateTableViewController") as! UIViewController
        self.navigationController?.pushViewController(destination, animated: true)
    }
    var theDay = savedDays[selectedDate!]
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = selectedDate!.toString()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.navigationController?.navigationBar.barTintColor = FlatRed()
        self.navigationController?.navigationBar.tintColor = FlatWhite()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: FlatWhite()]
        isHistorical = true
        
        
        populateLabels()
        carbLabel.adjustsFontSizeToFitWidth = true
        calorieLabel.adjustsFontSizeToFitWidth = true
        sodiumLabel.adjustsFontSizeToFitWidth = true
        fatLabel.adjustsFontSizeToFitWidth = true
        proteinLabel.adjustsFontSizeToFitWidth = true
        foodsEatenTableView.delegate = self
        foodsEatenTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if (theDay!.foodsEaten.count) > 0 && (theDay!.customFoodsEaten.count) > 0 {
            
        }
        return 2    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0 {

            
            return (theDay!.foodsEaten.count)
        } else {
            return (theDay!.customFoodsEaten.count)
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
            pastFood = (theDay!.foodsEaten[indexPath.row])
        } else {
            pastFood = (theDay!.customFoodsEaten[indexPath.row])
        }
        cell.foodNameLabel.text = pastFood.name
        if pastFood.den == 1 {
            cell.foodQuantityLabel.text = String(pastFood.num)
        } else {
            cell.foodQuantityLabel.text = String(pastFood.num) + "/" + String(pastFood.den)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isPast = true
        let destination = storyboard?.instantiateViewController(withIdentifier: "FoodViewController") as! UIViewController
        
        //selectedFood = savedFoods[theDay!.foodsEaten[indexPath.row].name]
        selectedFood = theDay!.foodsEaten[indexPath.row]
        self.navigationController?.pushViewController(destination, animated: true)
        selectedFood = indexPath.section == 0 ? theDay!.foodsEaten[indexPath.row] : theDay!.customFoodsEaten[indexPath.row]
    }
    
    func populateLabels() {
        if theDay!.foodsEaten.count > 0 {
            foodsEatenLabel.text = "Foods Eaten Today"
        } else {
            foodsEatenLabel.text = "No Foods Eaten"
        }
        
        //let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        let theDateString: String = dateFormatter.string(from: selectedDate!)
        
        if let numVal = theDay!.nutritionTotals["Total Calories"] {
            calorieLabel.text = "CALORIE COUNT: \(numVal)"
        }
        else {
            calorieLabel.text = "No Calories Today"
        }
        let p = theDay!.nutritionTotals["Total Protein"]
        let c = theDay!.nutritionTotals["Total Carbs"]
        let f = theDay!.nutritionTotals["Total Fat"]
        let s = theDay!.nutritionTotals["Total Sodium"]
        proteinLabel.text = String(p!) + " g"
        carbLabel.text = String(c!) + " g"
        fatLabel.text = String(f!) + " g"
        sodiumLabel.text = String(s!) + " mg"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
