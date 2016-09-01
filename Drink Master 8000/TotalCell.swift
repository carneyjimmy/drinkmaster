//
//  TotalCell.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/8/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class TotalCell: UITableViewCell {

    @IBOutlet weak var totalName: UILabel!
    
    @IBOutlet weak var totalPrice: UILabel!
    
    var total: OrderReceipt!{
        didSet{
            totalName.text = total.name!
            let priceText = formatter.stringFromNumber(total.cost!)!
            totalPrice.text = formatter.stringFromNumber(total.cost!)!

            //add zeros based on both number of characters in string and whether or not the string is
            //less than or greater than 0
            if (total.cost >= 1){
                    if(priceText.characters.count < 4){
                    totalPrice.text = "$" + priceText + "0"
                }
                else{
                    totalPrice.text = "$" + priceText
                }
                
                
                
            }
            else{
                if(priceText.characters.count < 3){
                    totalPrice.text = "$" + "0" + priceText + "0"
                }
                else if(priceText.characters.count < 4){
                    totalPrice.text = "$" + "0" + priceText
                }
                else{
                    totalPrice.text = "$" + priceText
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
