//
//  FoodViewController.swift
//  WUSTLNutrition
//
//  Created by zblue on 10/23/17.
//  Copyright © 2017 zblue. All rights reserved.
//

import UIKit
import ChameleonFramework

class FoodViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantLabel: UILabel!
    @IBOutlet weak var minusButtonB: UIButton!
    @IBOutlet weak var plusButtonB: UIButton!
    @IBOutlet weak var adderButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fractionLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var denLabel: UILabel!
    
    @IBOutlet weak var denPlus: UIButton!
    @IBOutlet weak var numPlus: UIButton!
    @IBOutlet weak var denMinus: UIButton!
    @IBOutlet weak var numMinus: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        minusButtonB.tintColor = FlatRed()
        plusButtonB.tintColor = FlatRed()
        quantLabel.textColor = FlatRed()
        adderButton.tintColor = FlatRed()
        fractionButton.tintColor = FlatRed()
        
        fractionLabel.textColor = FlatRed()
        numLabel.textColor = FlatRed()
        denLabel.textColor = FlatRed()
        
        nameLabel.adjustsFontSizeToFitWidth = true
        
        denPlus.tintColor = FlatRed()
        numPlus.tintColor = FlatRed()
        denMinus.tintColor = FlatRed()
        numMinus.tintColor = FlatRed()
        
        numLabel.isHidden = true
        denLabel.isHidden = true
        denPlus.isHidden = true
        numPlus.isHidden = true
        denMinus.isHidden = true
        numMinus.isHidden = true
        fractionLabel.isHidden = true
        
        fractionButton.setTitle("Switch to Fraction Mode", for: UIControlState())
        
        self.navigationController?.navigationBar.barTintColor = FlatRed()
        self.navigationController?.navigationBar.tintColor = FlatWhite()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: FlatWhite()]
        
        
        nameLabel.text = selectedFood?.name
        tableView.dataSource = self
        tableView.delegate = self
        quantLabel.text = "1"
        
        selectedFood?.den = 1
        selectedFood?.num = 1
    }
    
    @IBAction func backToFoodList(_ sender: Any) {
        isCustom = false
        if isHistorical {
            let destination = storyboard?.instantiateViewController(withIdentifier: "PastDayViewController") as! UIViewController
            self.navigationController?.pushViewController(destination, animated: true)
        }
        else if selectedLocation == nil {
            let destination = storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! UITabBarController
            self.present(destination, animated: true, completion: nil)
            return
        } else {
            let destination = storyboard?.instantiateViewController(withIdentifier: "FoodTableViewController") as! UIViewController
            self.navigationController?.pushViewController(destination, animated: true)
        }
    }
    
    @IBAction func numPlusPressed(_ sender: Any) {
        numLabel.text = String(min(Int(numLabel.text!)! + 1, 10))
        selectedFood?.num = Int(numLabel.text!)!
       
        tableView.reloadData()
    }
    
    @IBAction func denPlusPressed(_ sender: Any) {
        denLabel.text = String(min(Int(denLabel.text!)! + 1, 10))
        selectedFood?.den = Int(denLabel.text!)!
        
        tableView.reloadData()
    }
    
    @IBAction func numMinusPressed(_ sender: Any) {
        numLabel.text = String(max(Int(numLabel.text!)! - 1, 1))
        selectedFood?.num = Int(numLabel.text!)!
        tableView.reloadData()
    }
    
    @IBAction func denMinusPressed(_ sender: Any) {
        denLabel.text = String(max(Int(denLabel.text!)! - 1, 1))
        selectedFood?.den = Int(denLabel.text!)!
        tableView.reloadData()
    }
    
    @IBOutlet weak var fractionButton: UIButton!
    
    @IBAction func backPressed(_ sender: Any) {
        self.parent?.navigationController?.popViewController(animated: true)
        if isPast {
            let destination = storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! NavigationTabBarController
            self.present(destination,animated: true, completion:  nil)
        } else {
            let destination = storyboard?.instantiateViewController(withIdentifier: "FoodNavigationController") as! UINavigationController
            self.present(destination,animated: true, completion:  nil)
        }
    }
    
    @IBAction func fractionButtonPressed(_ sender: Any) {
        quantLabel.isHidden = !quantLabel.isHidden
        minusButtonB.isHidden = !minusButtonB.isHidden
        plusButtonB.isHidden = !plusButtonB.isHidden
        fractionLabel.isHidden = !fractionLabel.isHidden
        numLabel.isHidden = !numLabel.isHidden
        denLabel.isHidden = !denLabel.isHidden
        denPlus.isHidden = !denPlus.isHidden
        numPlus.isHidden = !numPlus.isHidden
        denMinus.isHidden = !denMinus.isHidden
        numMinus.isHidden = !numMinus.isHidden
        fractionButton.setTitle(quantLabel.isHidden ? "Switch to Regular Mode" : "Switch to Fraction Mode", for: UIControlState())
        selectedFood?.num = 1
        selectedFood?.den = 1
        numLabel.text = "1"
        denLabel.text = "1"
    }
    
    @IBAction func minusButton(_ sender: Any) {
        quantLabel.text = String(max(1, Int(quantLabel.text!)! - 1))
        selectedFood?.num = Int(quantLabel.text!)!
        tableView.reloadData()
    }
    
    @IBAction func plusButton(_ sender: Any) {
        quantLabel.text = String(min(Int(quantLabel.text!)! + 1, 10))
        selectedFood?.num = Int(quantLabel.text!)!
        tableView.reloadData()
    }

    
    @IBAction func addButtonPressed(_ sender: Any) {
        if selectedFood?.num == selectedFood?.den {
            selectedFood?.num = 1
            selectedFood?.den = 1
        }
        let day = savedDays[currentDate]!
        var foodToAdd = selectedFood!
        let quant = Double((selectedFood?.num)!)/Double((selectedFood?.den)!)
        
        if selectedLocation == "Custom Foods" || isCustom {
            savedDays[currentDate]?.customFoodsEaten.append(foodToAdd)
        } else {
            savedDays[currentDate]?.foodsEaten.append(foodToAdd)
        }
        
        isCustom = false
        
        var newTotals = day.nutritionTotals
        
        newTotals["Total Calories"]! += Int(Double(selectedFood!.nutritionalInformation["Calories"]!) * quant)
        newTotals["Total Carbs"]! += Int(Double(selectedFood!.nutritionalInformation["Tot. Carb."]!) * quant)
        newTotals["Total Protein"]! += Int(Double(selectedFood!.nutritionalInformation["Protein"]!) * quant)
        newTotals["Total Fat"]! += Int(Double(selectedFood!.nutritionalInformation["Total Fat"]!) * quant)
        newTotals["Total Sodium"]! += Int(Double(selectedFood!.nutritionalInformation["Sodium"]!) * quant)
        
        
        savedDays[currentDate]?.nutritionTotals = newTotals
        saveToDate(day: NutritionDay(date: currentDate, foodsEaten: (savedDays[currentDate]?.foodsEaten)!, customFoodsEaten: (savedDays[currentDate]?.customFoodsEaten)!, nutritionTotals: newTotals))
        let destination = storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! NavigationTabBarController
        self.present(destination,animated: true, completion:  nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attributes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NutritionTableViewCell") as! NutritionTableViewCell
        cell.attributeLabel.text = attributes[indexPath.row]
        let numValue : Int? = selectedFood?.nutritionalInformation[attributes[indexPath.row]]
        
        let quant = Double((selectedFood?.num)!)/Double((selectedFood?.den)!)
        cell.dataLabel.text = String(Int(Double(numValue!) * quant))
        
        return cell
    }
}
