//
//  NavigationTabBarController.swift
//  WUSTLNutrition
//
//  Created by zblue on 11/8/17.
//  Copyright © 2017 zblue. All rights reserved.
//

import UIKit
import CoreData
import QuartzCore
import CoreGraphics
import ChameleonFramework
import Charts

class NavigationTabBarController: UITabBarController {    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = FlatRed()
        self.tabBar.barTintColor = FlatWhite()
        
        let destination = storyboard?.instantiateViewController(withIdentifier: "HomeNavigationViewController") as! UINavigationController
        self.present(destination, animated:true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 2:
            let destination = storyboard?.instantiateViewController(withIdentifier: "LocationNavigationViewController") as! UINavigationController
            self.present(destination, animated:true, completion: nil)
        case 3:
            let destination = storyboard?.instantiateViewController(withIdentifier: "DateTableNavigationViewController") as! UINavigationController
            self.present(destination, animated:true, completion: nil)
        default:
            
        }
    }
}
