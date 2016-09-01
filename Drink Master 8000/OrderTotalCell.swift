//
//  OrderTotalCell.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/9/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class OrderTotalCell: UITableViewCell {
    
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    var amount: OrderReceipt!{
        didSet{
            totalLabel.text = amount.name!
            costLabel.text = "$" + formatter.stringFromNumber(amount.cost!)!
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
