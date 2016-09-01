//
//  CheckOutCell.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/6/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class CheckOutCell: UITableViewCell {
    
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemCost: UILabel!
    @IBOutlet weak var itemQ: UILabel!
    
    var item: Drink!{
        didSet{
            itemName.text = item.name
            itemCost.text = "$" + formatter.stringFromNumber(item.getPrice())!
            itemQ.text = String(item.quantity)
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
