//
//  ComponentQuantityCell.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/8/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class ComponentQuantityCell: UITableViewCell {
    
    
    
    @IBOutlet weak var drinkQ: UILabel!
    @IBOutlet weak var drinkQuantity: UIStepper!
    
    var comp: Component!{
        didSet{
            drinkQ.text = String(comp.quantity!)
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
    
    @IBAction func inc(sender: UIStepper) {
        comp.quantity = Double(sender.value)
        
    }}
