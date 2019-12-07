//
//  CustomFoodViewController.swift
//  WUSTLNutrition
//
//  Created by labuser on 11/15/17.
//  Copyright © 2017 labuser. All rights reserved.
//

import UIKit
import CoreData
import QuartzCore
import CoreGraphics
import ChameleonFramework
import Charts

class CustomFoodViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var addFoodButton: UIButton!
    var foodDict : [String: Int] = [:]
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        print(foodDict)
        if nameTextField.text == "" {
            let alert = UIAlertView(title: "Error", message: "Your Custom Food must have a name.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            return
        }
        saveCustomFood(name: nameTextField!.text!, calories: foodDict["Calories"]!, fat: foodDict["Total Fat"]!, carbs: foodDict["Tot. Carb."]!, sodium: foodDict["Sodium"]!, protein: foodDict["Protein"]!)
        customSavedFoods[nameTextField!.text!] = Food(nutritionalInformation: foodDict, name: nameTextField!.text!, num: 1, den: 1)
        let alert = UIAlertView(title: "Food Added!", message: "Your Custom Food has been added to the Custom Food List under Restaurants", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
  
        let destination = storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! NavigationTabBarController
        self.present(destination,animated: true, completion:  nil)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isHistorical = false
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CustomFoodViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        addFoodButton.tintColor = FlatRed()
        self.navigationController?.navigationBar.barTintColor = FlatRed()
       self.navigationController?.navigationBar.tintColor = FlatWhite()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: FlatWhite()]
        
        tableView.delegate = self
        tableView.dataSource = self
        
        foodDict["Calories"] = 0
        foodDict["Total Fat"] = 0
        foodDict["Tot. Carb."] = 0
        foodDict["Sodium"] = 0
        foodDict["Protein"] = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleNotification(notification:)), name: Notification.Name("row"), object: nil)
        
        nameTextField.placeholder = "Food Name"
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
        return attributes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomFoodCell", for: indexPath) as! CustomFoodCell
        cell.attributeLabel!.text = attributes[indexPath.row]
        cell.attributeValue!.placeholder = "0"
        cell.row = indexPath.row
        return cell
    }
    
    @objc func handleNotification(notification: NSNotification) {
        let obj = notification.object as! [Int]
        foodDict[attributes[obj[0]]] = obj[1]
        print(obj)
        print(foodDict)
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

