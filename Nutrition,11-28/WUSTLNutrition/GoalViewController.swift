//
//  GoalViewController.swift
//  WUSTLNutrition
//
//  Created by labuser on 11/27/17.
//  Copyright © 2017 labuser. All rights reserved.
//

import UIKit
import ChameleonFramework

class GoalViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var goalButton: UIButton!
    @IBOutlet weak var calorieField: UITextField!
    @IBOutlet weak var proteinField: UITextField!
    @IBOutlet weak var carbsField: UITextField!
    @IBOutlet weak var fatField: UITextField!
    @IBOutlet weak var sodiumField: UITextField!
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = FlatRed()
        self.navigationController?.navigationBar.tintColor = FlatWhite()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: FlatWhite()]
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GoalViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        goalButton.tintColor = FlatRed()
        
        let c : Int? = goals["Total Calories"]
        let f : Int? = goals["Total Fat"]
        let cc : Int? = goals["Total Carbs"]
        let p : Int? = goals["Total Protein"]
        let s : Int? = goals["Total Sodium"]
        
        calorieField.placeholder = String(c!)
        fatField.placeholder = String(f!)
        carbsField.placeholder = String(cc!)
        proteinField.placeholder = String(p!)
        sodiumField.placeholder = String(s!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goalSetting(_ sender: Any) {
        goals["Total Calories"] = Int(calorieField.text!)
        goals["Total Carbs"] = Int(carbsField.text!)
        goals["Total Fat"] = Int(fatField.text!)
        goals["Total Sodium"] = Int(sodiumField.text!)
        goals["Total Protein"] = Int(proteinField.text!)
        
        saveGoals(calories: Int(calorieField.text!)!, fat: Int(fatField.text!)!, carbs: Int(carbsField.text!)!, sodium: Int(sodiumField.text!)!, protein: Int(proteinField.text!)!)
        let destination = storyboard?.instantiateViewController(withIdentifier: "AnalyticsViewController") as! UIViewController
        
        self.navigationController?.pushViewController(destination, animated: true)
        let alert = UIAlertView(title: "Goals Set!", message: "Your Daily Goals have been set, check the graph to see your progress", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
        
        
    }
    
    @IBAction func backToAnalytics(_ sender: Any) {
        let destination = storyboard?.instantiateViewController(withIdentifier: "AnalyticsViewController") as! UIViewController
        
        self.navigationController?.pushViewController(destination, animated: true)
        
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
