//
//  OrderStatusCell.swift
//  Drink Master 8000
//
//  Created by Tess Putinsky on 11/5/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class OrderStatusCell: UITableViewCell {

    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    var orderStatus: Drink! {
        didSet {
            nameLabel.text = orderStatus.name
            costLabel.text = "$" + formatter.stringFromNumber(orderStatus.getPrice())!
            quantityLabel.text = String(orderStatus.quantity)
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
