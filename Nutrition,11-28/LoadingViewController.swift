//
//  LoadingViewController.swift
//  WUSTLNutrition
//
//  Created by zblue on 11/13/17.
//  Copyright © 2017 zblue. All rights reserved.
//

import UIKit
import ChameleonFramework

class LoadingViewController: UIViewController, UITabBarDelegate, UITabBarControllerDelegate {

    
    @IBOutlet weak var nameLabeler: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabeler.text = "Washington University\nNutrition Tracker"
        let screenSize = UIScreen.main.bounds
        

        self.view.backgroundColor = FlatWhite()
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loader()
    }
    
    func loader(){
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            
            
            let destination = storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! NavigationTabBarController
            self.present(destination,animated: true, completion:  nil)
            
            
            
        }else{
            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            print("Internet Connection not Available!")
        }
        //spinner.stopAnimating()
        
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
