//
//  customTipTableViewCell.swift
//  Drink Master 8000
//
//  Created by Jimmy Carney on 12/4/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class customTipTableViewCell: UITableViewCell {

    
    @IBOutlet weak var tipValue: UITextField!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        tipValue.clearsOnBeginEditing = true
        tipValue.keyboardType = UIKeyboardType.DecimalPad
        tipValue.returnKeyType = UIReturnKeyType.Done

        
        // Initialization code
    }

    @IBAction func inHere(sender: AnyObject) {
        
        self.setSelected(true, animated: true);
        
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        print("in here " + self.description)
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
