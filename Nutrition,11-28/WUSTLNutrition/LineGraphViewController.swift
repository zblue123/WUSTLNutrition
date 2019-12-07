//
//  LineGraphViewController.swift
//  WUSTLNutrition
//
//  Created by Linda Bluestein on 11/25/17.
//  Copyright © 2017 labuser. All rights reserved.
//

import UIKit
import Charts
import CoreData
import QuartzCore
import CoreGraphics
import ChameleonFramework

class LineGraphViewController: UIViewController {
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    @IBOutlet weak var sodSwitch: UISwitch!
    @IBOutlet weak var proSwitch: UISwitch!
    @IBOutlet weak var fatSwitch: UISwitch!
    @IBOutlet weak var carbSwitch: UISwitch!
    @IBOutlet weak var calSwitch: UISwitch!
    
    @IBAction func calSwitchToggled(_ sender: Any) {
        updateChartData()
    }
    

    @IBAction func carbSwitchToggled(_ sender: Any) {
        updateChartData()
    }
    
    @IBAction func fatSwitchToggled(_ sender: Any) {
        updateChartData()
    }
    
    @IBAction func proSwitchToggled(_ sender: Any) {
        updateChartData()
    }
    
    @IBAction func sodSwitchToggled(_ sender: Any) {
        updateChartData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isHistorical = false
        self.navigationController?.navigationBar.barTintColor = FlatRed()
        self.navigationController?.navigationBar.tintColor = FlatWhite()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: FlatWhite()]
        calSwitch.isOn = false
        calSwitch.onTintColor = FlatRed()
        carbSwitch.isOn = false
        carbSwitch.onTintColor = FlatRed()
        fatSwitch.isOn = false
        fatSwitch.onTintColor = FlatRed()
        sodSwitch.isOn = false
        sodSwitch.onTintColor = FlatRed()
        proSwitch.isOn = false
        proSwitch.onTintColor = FlatRed()
        // Do any additional setup after loading the view.
    }

   
    @IBAction func backToGrapher(_ sender: Any) {
        let destination = storyboard?.instantiateViewController(withIdentifier: "AnalyticsViewController") as! UIViewController
        
        self.navigationController?.pushViewController(destination, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateChartData() {
        if !calSwitch.isOn && !carbSwitch.isOn && !fatSwitch.isOn && !sodSwitch.isOn && !proSwitch.isOn {
            let alert = UIAlertController(title: "Alert", message: "At least one value must be selected", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        var cals : [ChartDataEntry] = []
        var fat : [ChartDataEntry] = []
        var sod : [ChartDataEntry] = []
        var carbs : [ChartDataEntry] = []
        var pro: [ChartDataEntry] = []
        for day in savedDays.keys.sorted() {
            cals.append(ChartDataEntry(x: Double(day.dayInt()), y: Double(savedDays[day]!.nutritionTotals["Total Calories"]!)))
            fat.append(ChartDataEntry(x: Double(day.dayInt()), y: Double(savedDays[day]!.nutritionTotals["Total Fat"]!)))
            carbs.append(ChartDataEntry(x: Double(day.dayInt()), y: Double(savedDays[day]!.nutritionTotals["Total Carbs"]!)))
            sod.append(ChartDataEntry(x: Double(day.dayInt()), y: Double(savedDays[day]!.nutritionTotals["Total Sodium"]!)))
            pro.append(ChartDataEntry(x: Double(day.dayInt()), y: Double(savedDays[day]!.nutritionTotals["Total Protein"]!)))
        }
        
        
        let rad = CGFloat(1)
        let calSet = LineChartDataSet(values: cals, label: "Calories")
        calSet.colors = [UIColor.flatGray()]
        calSet.circleColors = calSet.colors
        calSet.circleRadius = rad
        let fatSet = LineChartDataSet(values: fat, label: "Fat (g)")
        fatSet.colors = [UIColor.flatRed()]
        fatSet.circleColors = fatSet.colors
        fatSet.circleRadius = rad
        let carbSet = LineChartDataSet(values: carbs, label: "Carbs (g)")
        carbSet.colors = [UIColor.flatYellow()]
        carbSet.circleColors = carbSet.colors
        carbSet.circleRadius = rad
        let proSet = LineChartDataSet(values: pro, label: "Protein (g)")
        proSet.colors = [UIColor.flatBrown()]
        proSet.circleColors = proSet.colors
        proSet.circleRadius = rad
        let sodSet = LineChartDataSet(values: sod, label: "Sodium (mg)")
        sodSet.colors = [UIColor.blue]
        sodSet.circleColors = sodSet.colors
        sodSet.circleRadius = rad
        
        var data : [LineChartDataSet] = []
        if calSwitch.isOn {
            data.append(calSet)
        }
        if fatSwitch.isOn {
            data.append(fatSet)
        }
        if carbSwitch.isOn {
            data.append(carbSet)
        }
        if proSwitch.isOn {
            data.append(proSet)
        }
        if sodSwitch.isOn {
            data.append(sodSet)
        }
        
        lineChartView.data = LineChartData(dataSets: data)
        
        let xAxis: XAxis = lineChartView.xAxis
        //print(chartData.xMax)
        //print(chartData.xMin)
        //xAxis.
        xAxis.drawAxisLineEnabled = true
        xAxis.drawGridLinesEnabled = true
        xAxis.drawLabelsEnabled = false
        print(xAxis.axisRange)
        xAxis.axisMinimum = (lineChartView.data?.xMin)!
        xAxis.axisMaximum = (lineChartView.data?.xMax)!
        
        //chartView.scaleX = CGFloat(1.1)
        
        
        let leftAxis: YAxis = lineChartView.leftAxis
        leftAxis.drawAxisLineEnabled = true
        leftAxis.drawGridLinesEnabled = true
        leftAxis.setLabelCount(2, force: true)
        leftAxis.axisMinimum = 0.0
        leftAxis.axisMaximum = (lineChartView.data?.yMax)!
        //leftAxis.drawLabelsEnabled = true
        
        
        // chartData.setDrawValues(true)
        //chartView.data = chartData;
        lineChartView.chartDescription?.text = ""
        //chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        
        lineChartView.doubleTapToZoomEnabled = true
        lineChartView.scaleXEnabled = true
        lineChartView.scaleYEnabled = true
        lineChartView.highlightPerTapEnabled = false
        lineChartView.highlightPerDragEnabled = false
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
