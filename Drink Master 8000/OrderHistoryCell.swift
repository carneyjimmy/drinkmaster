//
//  OrderHistoryCell.swift
//  Drink Master 8000
//
//  Created by Tess Putinsky on 11/5/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class OrderHistoryCell: UITableViewCell {

   
    @IBOutlet weak var histPrice: UILabel!
    @IBOutlet weak var histDate: UILabel!
    @IBOutlet weak var histBar: UILabel!
    @IBOutlet weak var histStatus: UILabel!
    
    
    var order: Order! {
        
        didSet{
            histPrice.text = "$" + String(order.total)
            histDate.text = dateifier.stringFromDate(order.time_created)
            histBar.text = order.barName
            if (order.status == OrderStatus.Preparing) {
                histStatus.text = "Preparing"
            } else if (order.status == OrderStatus.Ready) {
                histStatus.text = "Ready"
            } else {
                histStatus.text = "Complete"
            }
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
