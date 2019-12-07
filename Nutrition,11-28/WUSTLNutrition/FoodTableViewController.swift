//
//  FoodTableViewController.swift
//  WUSTLNutrition
//
//  Created by labuser on 10/23/17.
//  Copyright © 2017 labuser. All rights reserved.
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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    @IBAction func backToLoc(_ sender: Any) {
        let destination = storyboard?.instantiateViewController(withIdentifier: "LocationTableViewController") as! UIViewController
        
        self.navigationController?.pushViewController(destination, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        //self.present(destination, animated: true, completion: nil)
        
    }
    
    // this method handles row deletion
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
