//
//  DateTableViewController.swift
//  WUSTLNutrition
//
//  Created by labuser on 11/6/17.
//  Copyright © 2017 labuser. All rights reserved.
//

import UIKit
import CoreData
import QuartzCore
import CoreGraphics
import ChameleonFramework
import Charts

class DateTableViewController: UITableViewController {
    
    
    var sortedDays : [Date] = []

    override func viewDidLoad() {
        isHistorical = false
        self.navigationController?.navigationBar.barTintColor = FlatRed()
        self.navigationController?.navigationBar.tintColor = FlatWhite()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: FlatWhite()]
        
       // self.navigationController?.navigationBar.barTintColor = FlatRed()
//self.navigationController?.navigationBar.tintColor = FlatWhite()
        //self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: FlatWhite()]
        super.viewDidLoad()
        tableView.reloadData()
        print(savedDays)
        print(savedDays.keys)
        print(savedDays.keys.sorted())
        print(Array(savedDays.keys.sorted()))
        sortedDays = Array(savedDays.keys.sorted())
        print("Should have printed some days")
        
        //self.tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "LocationTableViewCell")
        //self.tableView.re

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return savedDays.keys.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as! LocationTableViewCell
        if cell==nil {
            self.tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "LocationTableViewCell")
            cell = LocationTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "LocationTableViewCell")
        }
        
        let x = sortedDays[indexPath.row].toString()
        if var label = cell.label {
            label.text = sortedDays[indexPath.row].toString()
        } else {
            cell.labelDate!.text = x        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDate = sortedDays[indexPath.row]
        let destination = storyboard?.instantiateViewController(withIdentifier: "PastDayViewController") as! UIViewController
        self.navigationController?.pushViewController(destination, animated: true)
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
