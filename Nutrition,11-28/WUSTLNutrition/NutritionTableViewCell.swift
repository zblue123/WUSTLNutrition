//
//  NutritionTableViewCell.swift
//  WUSTLNutrition
//
//  Created by labuser on 10/23/17.
//  Copyright © 2017 labuser. All rights reserved.
//

import UIKit

class NutritionTableViewCell: UITableViewCell {

    @IBOutlet weak var attributeLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodQuantityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
