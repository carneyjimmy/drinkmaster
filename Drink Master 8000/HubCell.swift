//
//  HubCell.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 12/4/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class HubCell: UITableViewCell {
    
    
    @IBOutlet weak var typeLabel: UILabel!
    
    var type: String!{
        didSet{
            typeLabel.text = type
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
