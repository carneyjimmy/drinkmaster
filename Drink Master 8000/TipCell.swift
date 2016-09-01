//
//  TipCell.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/7/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class TipCell: UITableViewCell {
    
    @IBOutlet weak var tipPerc: UILabel!
    @IBOutlet weak var tipVal: UILabel!
    
    var tip: Tip!{
        didSet{
            if (tip.percent == 0){
                tipPerc.text = "Input Custom"
                tipVal.text = ""
            }
            else{
                //add zeros based on both number of characters in string and whether or not the string is 
                //less than or greater than 0
                if (tip.percent >= 1){
                tipPerc.text = String(tip.percent!) + "%"
                    if(String(tip.value!).characters.count < 4){
                         tipVal.text = "$" + String(tip.value!) + "0"
                    }
                    else{
                        tipVal.text = "$" + String(tip.value!)
                    }
               
                    
                    
                }
                else{
                tipPerc.text = String(tip.percent!) + "%"
                    if(String(tip.value!).characters.count < 3){
                        tipVal.text = "$" + "0" + String(tip.value!) + "0"
                    }
                    else if(String(tip.value!).characters.count < 4){
                        tipVal.text = "$" + "0" + String(tip.value!)
                    }
                    else{
                        tipVal.text = "$" + String(tip.value!)
                    }
                }
                
                
        
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
