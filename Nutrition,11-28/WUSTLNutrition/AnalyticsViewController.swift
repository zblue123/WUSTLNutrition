//
//  AnalyticsViewController.swift
//  WUSTLNutrition
//
//  Created by zblue on 11/21/17.
//  Copyright © 2017 zblue. All rights reserved.
//

import UIKit
import Charts
import CoreData
import QuartzCore
import CoreGraphics
import ChameleonFramework

class AnalyticsViewController: UIViewController {
    
    @IBOutlet weak var chartView: BubbleChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isHistorical = false
        self.navigationController?.navigationBar.barTintColor = FlatRed()
        self.navigationController?.navigationBar.tintColor = FlatWhite()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: FlatWhite()]
        
        chartData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func chartData() {
        var days : [Int] = []
        var cals : [Int] = []
        var fat : [Int] = []
        var sod : [Int] = []
        var carbs : [Int] = []
        for day in savedDays.keys.sorted() {
            days.append(day.dayInt())
            cals.append(savedDays[day]!.nutritionTotals["Total Calories"]!)
            fat.append(savedDays[day]!.nutritionTotals["Total Fat"]!)
            sod.append(savedDays[day]!.nutritionTotals["Total Sodium"]!)
            carbs.append(savedDays[day]!.nutritionTotals["Total Carbs"]!)
        }
        
        var dataEntries: [String: [BubbleChartDataEntry]] = ["Total Calories" : [], "Total Fat": [], "Total Sodium" : [], "Total Carbs": [], "Total Protein": []]
        
        let dict = Array(goals.keys)
        for day in savedDays.keys.sorted() {
            for key in dict {
                print("amount of \(key): \(savedDays[day]!.nutritionTotals[key]!)")
                print("goals for \(key): \(Double(goals[key]!))")
                print("percent of \(key) on \(day): \(Double(100*savedDays[day]!.nutritionTotals[key]!)/Double(goals[key]!))")
                print("size of \(key) on \(day): \(CGFloat(savedDays[day]!.nutritionTotals[key]!))")
                dataEntries[key]!.append(BubbleChartDataEntry(x: Double(day.dayInt()), y: Double(100*savedDays[day]!.nutritionTotals[key]!)/Double(goals[key]!), size: CGFloat(savedDays[day]!.nutritionTotals[key]!)))
            }
        }
        
        
        let calDataSet = BubbleChartDataSet(values: dataEntries["Total Calories"]!, label: "Calories")
        calDataSet.setColor(NSUIColor(complementaryFlatColorOf: UIColor.blue))
        let fatDataSet = BubbleChartDataSet(values: dataEntries["Total Fat"]!, label: "Fat (g)")
        fatDataSet.setColor(NSUIColor(complementaryFlatColorOf: UIColor.red))
        let sodDataSet = BubbleChartDataSet(values: dataEntries["Total Sodium"]!, label: "Sodium (mg)")
        sodDataSet.setColor(NSUIColor(complementaryFlatColorOf: UIColor.yellow))
        let carbDataSet = BubbleChartDataSet(values: dataEntries["Total Carbs"]!, label: "Carbs (g)")
        carbDataSet.setColor(NSUIColor(complementaryFlatColorOf: UIColor.green))
        let proDataSet = BubbleChartDataSet(values: dataEntries["Total Protein"]!, label: "Protein (g)")
        carbDataSet.setColor(NSUIColor(complementaryFlatColorOf: UIColor.brown))
        
        let chartData = BubbleChartData(dataSets: [calDataSet, carbDataSet, fatDataSet, sodDataSet, proDataSet])
        
        let xAxis: XAxis = chartView.xAxis

        chartView.xAxis.drawAxisLineEnabled = true
        xAxis.drawGridLinesEnabled = true
        chartView.xAxis.drawLabelsEnabled = true
        
        xAxis.axisMinimum = chartData.xMin
        xAxis.axisMaximum = chartData.xMax
        
        let leftAxis: YAxis = chartView.leftAxis
         leftAxis.drawAxisLineEnabled = true
         leftAxis.drawGridLinesEnabled = true
         leftAxis.setLabelCount(10, force: true)
         leftAxis.axisMinimum = 0.0
         leftAxis.axisMaximum = chartData.yMax

        chartView.data = chartData;
        chartView.chartDescription?.text = ""
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        
        chartView.doubleTapToZoomEnabled = true
        chartView.scaleXEnabled = true
        chartView.scaleYEnabled = true
        chartView.highlightPerTapEnabled = false
        chartView.highlightPerDragEnabled = false
        
        chartView.rightAxis.enabled = false
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        chartView.xAxis.granularityEnabled = true
        
        chartView.xAxis.granularity = 1
        chartView.xAxis.setLabelCount(5, force: true)
    }

    @IBAction func pushGoalsView(_ sender: Any) {
          let destination = storyboard?.instantiateViewController(withIdentifier: "GoalViewController") as! UIViewController
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    @IBAction func pushGraphs(_ sender: Any) {
        let destination = storyboard?.instantiateViewController(withIdentifier: "LineGraphViewController") as! UIViewController
        self.navigationController?.pushViewController(destination, animated: true)
    }

}
