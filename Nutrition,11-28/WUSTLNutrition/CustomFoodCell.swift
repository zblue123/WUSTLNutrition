//
//  CustomFoodCell.swift
//  WUSTLNutrition
//
//  Created by zblue on 11/15/17.
//  Copyright © 2017 zblue. All rights reserved.
//

import UIKit

class CustomFoodCell: UITableViewCell {

    @IBOutlet weak var attributeLabel: UILabel!
    @IBOutlet weak var attributeValue: UITextField!
    
    var row : Int = 0
    
    @IBAction func editingChanged(_ sender: Any) {
        var obj : [Int] = [row]
        if let string = attributeValue!.text {
            if let x = Int(string){
                obj.append(x)
            } else {
                obj.append(0)
            }
        } else {
            obj.append(0)
        }
        
        
        NotificationCenter.default.post(name: Notification.Name("row"), object: obj)
        print(obj)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
