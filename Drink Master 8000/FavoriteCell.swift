//
//  FavoriteCell.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 12/4/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    
    @IBOutlet weak var drinkLabel: UILabel!
    
    var drink: Drink!{
        didSet{
            drinkLabel.text = drink.name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
