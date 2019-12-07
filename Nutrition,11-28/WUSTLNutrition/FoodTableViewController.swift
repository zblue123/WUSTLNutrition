//
//  FoodTableViewController.swift
//  WUSTLNutrition
//
//  Created by zblue on 10/23/17.
//  Copyright © 2017 zblue. All rights reserved.
//

import UIKit
import CoreData
import ChameleonFramework

class FoodTableViewController: UITableViewController {
   
    var foods : [Food] = []

    override func viewDidLoad() {
        isHistorical = false
        self.navigationController?.navigationBar.barTintColor = FlatRed()
        self.navigationController?.navigationBar.tintColor = FlatWhite()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: FlatWhite()]
        
        super.viewDidLoad()
        if selectedLocation! == "Custom Foods" {
            foods = Array(customSavedFoods.values)
        } else {
            foods = foodsByLocation[selectedLocation!]!
        }
        foods = foods.sorted {
            return $0.name < $1.name
        }
    }

    @IBAction func backToLoc(_ sender: Any) {
        let destination = storyboard?.instantiateViewController(withIdentifier: "LocationTableViewController") as! UIViewController
        
        self.navigationController?.pushViewController(destination, animated: true)  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as! LocationTableViewCell
        if cell==nil {
            self.tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "LocationTableViewCell")
            cell = LocationTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "LocationTableViewCell")
        }
        
        if var label = cell.label {
            label.text = foods[indexPath.row].name
        } else {
            cell.label.text = foods[indexPath.row].name
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = storyboard?.instantiateViewController(withIdentifier: "FoodViewController") as! UIViewController
        
        selectedFood = foods[indexPath.row]
        print(selectedFood)
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if selectedLocation! == "Custom Foods" {
            if editingStyle == .delete {
                let foodToRemove = foods[indexPath.row]
                deleteCustomFood(foodToRemove: foodToRemove)
                tableView.reloadData()
            }
        } 
    }
    
    func deleteCustomFood(foodToRemove: Food) {
        customSavedFoods.removeValue(forKey: foodToRemove.name)
        foods = Array(customSavedFoods.values)
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let customFoodFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CustomFood")
        do {
            let result = try managedContext.fetch(customFoodFetchRequest)
            let foodResult = result as! [CustomFood]
            for object in foodResult {
                if object.name == foodToRemove.name {
                    managedContext.delete(object)
                }
            }
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
}
