//
//  ComponentVariationCell.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/8/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class ComponentVariationCell: UITableViewCell {
    
    
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    var opt : ComponentOption!{
        didSet{
            name.text = opt.name!
            price.text = "+ $" + formatter.stringFromNumber(opt.price!)!
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
