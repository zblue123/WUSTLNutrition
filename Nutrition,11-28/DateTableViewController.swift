//
//  DateTableViewController.swift
//  WUSTLNutrition
//
//  Created by zblue on 11/6/17.
//  Copyright © 2017 zblue. All rights reserved.
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
        
        super.viewDidLoad()
        tableView.reloadData()
        sortedDays = Array(savedDays.keys.sorted())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
}
