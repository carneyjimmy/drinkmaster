//
//  BarCell.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/3/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class BarCell: UITableViewCell {
    
    @IBOutlet weak var barName: UILabel!
    @IBOutlet weak var barLocation: UILabel!
    @IBOutlet weak var barWait: UILabel!
    
    var bar: Bar!{
        didSet{
            barName?.text = bar.name!
            barLocation?.text = String(bar.distance!) + " miles"
            barWait?.text = String(bar.wait) + " minutes"
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
