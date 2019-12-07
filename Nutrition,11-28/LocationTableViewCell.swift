//
//  LocationTableViewCell.swift
//  WUSTLNutrition
//
//  Created by zblue on 10/10/17.
//  Copyright © 2017 zblue. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var labelDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
