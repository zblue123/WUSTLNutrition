//
//  LocationTableViewController.swift
//  WUSTLNutrition
//
//  Created by zblue on 10/10/17.
//  Copyright © 2017 zblue. All rights reserved.
//

import UIKit
import CoreData
import QuartzCore
import CoreGraphics
import ChameleonFramework
import Charts

class LocationTableViewController: UITableViewController {
    
    var sortedLocs = Array(foodsByLocation.keys).sorted()

    override func viewDidLoad() {
        isHistorical = false
        isPast = false
        super.viewDidLoad()
        
        sortedLocs.append("Custom Foods")
        self.navigationController?.navigationBar.barTintColor = FlatRed()
        self.navigationController?.navigationBar.tintColor = FlatWhite()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: FlatWhite()]        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return sortedLocs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as! LocationTableViewCell
        if cell==nil {
            self.tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "LocationTableViewCell")
            cell = LocationTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "LocationTableViewCell")
        }
        
        if var label = cell.label {
            label.text = sortedLocs[indexPath.row]
        } else {
            cell.label.text = sortedLocs[indexPath.row]
        
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let destination = storyboard?.instantiateViewController(withIdentifier: "FoodTableViewController") as! UIViewController
            
            selectedLocation = sortedLocs[indexPath.row]
            self.navigationController?.pushViewController(destination, animated: true)    
    }
}
