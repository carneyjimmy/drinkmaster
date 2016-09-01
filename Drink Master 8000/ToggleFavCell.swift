//
//  ToggleFavCell.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 12/11/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class ToggleFavCell: UITableViewCell {
    
    
    
    @IBOutlet weak var isFavorite: UISwitch!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
