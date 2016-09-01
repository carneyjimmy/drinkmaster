//
//  ComponentCell.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/8/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class ComponentCell: UITableViewCell {
    
    
    @IBOutlet weak var compName: UILabel!
    
    @IBOutlet weak var compPrice: UILabel!
    
    var comp: Component!{
        didSet{
            compName.text = comp.item!.name
            compPrice.text = "$" +  formatter.stringFromNumber(comp.getPrice())!
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
