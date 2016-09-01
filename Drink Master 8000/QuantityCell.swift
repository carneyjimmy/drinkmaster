//
//  QuantityCell.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/7/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class QuantityCell: UITableViewCell {

    @IBOutlet weak var drinkQ: UILabel!
    @IBOutlet weak var drinkQuantity: UIStepper!
    
    var drink: Drink!{
        didSet{
            drinkQ.text = String(drink.quantity)
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
    
    @IBAction func inc(sender: UIStepper) {
        drink.quantity = Int(sender.value)
        
    }
    
}
