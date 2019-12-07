//
//  NavigationTabBarController.swift
//  WUSTLNutrition
//
//  Created by labuser on 11/8/17.
//  Copyright © 2017 labuser. All rights reserved.
//

import UIKit
import CoreData
import QuartzCore
import CoreGraphics
import ChameleonFramework
import Charts

class NavigationTabBarController: UITabBarController {

    //@IBOutlet weak var testButton: UITabBarItem!
    
    override func viewDidLoad() {
        //testButton.tag = 2
        super.viewDidLoad()

        self.tabBar.tintColor = FlatRed()
        self.tabBar.barTintColor = FlatWhite()
        
        let destination = storyboard?.instantiateViewController(withIdentifier: "HomeNavigationViewController") as! UINavigationController
        self.present(destination, animated:true, completion: nil)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 2{
            let destination = storyboard?.instantiateViewController(withIdentifier: "LocationNavigationViewController") as! UINavigationController
            self.present(destination, animated:true, completion: nil)
        }
        else if item.tag == 3{
            let destination = storyboard?.instantiateViewController(withIdentifier: "DateTableNavigationViewController") as! UINavigationController
            self.present(destination, animated:true, completion: nil)
        }
        else if item.tag == 4{
            print("hi therE")
        }
    }

    

}
