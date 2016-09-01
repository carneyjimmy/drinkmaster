//
//  DrinkCell.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 10/31/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class DrinkCell: UITableViewCell {
    
    @IBOutlet weak var drinkTitle: UILabel?
    @IBOutlet weak var drinkPrice: UILabel?
    
    var drink: Drink!{
        didSet{
            drinkTitle?.text = drink.name
            drinkPrice?.text = "$" + formatter.stringFromNumber(drink.getPrice())!
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
