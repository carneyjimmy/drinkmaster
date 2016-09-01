//
//  CardCell.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/7/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {
    
    
    @IBOutlet weak var cardNum: UILabel!
    @IBOutlet weak var checkoutCell: UILabel!

    var card: Card!{
        didSet{
            
            if let cNum = cardNum{
                cNum.text = card.name!
            }
            if let chCell = checkoutCell{
                chCell.text = card.name!
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
