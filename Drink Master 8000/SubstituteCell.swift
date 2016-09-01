//
//  SubstituteCell.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/8/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class SubstituteCell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var subName: UILabel!
    @IBOutlet weak var subUnitPrice: UILabel!
    
    var sub: Item!{
        didSet{
            subName.text = sub.name
            if let _ = quantity{
                subUnitPrice.text = "$" + formatter.stringFromNumber(sub.ozPrice * Double(quantity))!
            }
        }
    }
    
    var quantity: Double!{
        didSet{
            subUnitPrice.text = "$" + formatter.stringFromNumber(sub.ozPrice * Double(quantity))!
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
