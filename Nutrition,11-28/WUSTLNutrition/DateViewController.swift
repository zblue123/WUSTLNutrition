//
//  DateViewController.swift
//  WUSTLNutrition
//
//  Created by labuser on 11/5/17.
//  Copyright © 2017 labuser. All rights reserved.
//

import UIKit
import CoreData
import QuartzCore
import CoreGraphics
import ChameleonFramework
import Charts

class DateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var foodsFromDay: UITableView!
    @IBOutlet weak var nutritionTable: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    
    let totalStrings = ["Total Calories", "Total Carbs", "Total Fat", "Total Protein", "Total Sodium"]
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = FlatRed()
        self.navigationController?.navigationBar.tintColor = FlatWhite()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: FlatWhite()]
        
        
        dateLabel.text = selectedDate?.toString()
        
        foodsFromDay.dataSource = self
        foodsFromDay.delegate = self
        
        nutritionTable.dataSource = self
        nutritionTable.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == foodsFromDay {
            return (savedDays[selectedDate!]?.foodsEaten.count)!
        }
        return attributes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == foodsFromDay {
            let cell = UITableViewCell()
            cell.textLabel?.text = savedDays[selectedDate!]?.foodsEaten[indexPath.row].name
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NutritionTableViewCell") as! NutritionTableViewCell
        cell.attributeLabel.text = totalStrings[indexPath.row]
        let numValue : Int? = savedDays[selectedDate!]?.nutritionTotals[totalStrings[indexPath.row]]
        cell.dataLabel.text = "\(numValue!)"
        return cell
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
