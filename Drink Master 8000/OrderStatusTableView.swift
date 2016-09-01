//
//  OrderStatusTableView.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/2/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class OrderStatusTableView: UITableView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    var receipt: [Drink] = [
        
    ]
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        // #warning Incomplete implementation, return the number of sections
        
        return 1
        
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
        
        return receipt.count
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("OrderStatusCell", forIndexPath: indexPath) as! OrderStatusCell            
            
//            let orderReceipt = receipt[indexPath.row] as OrderReceipt
//            cell.orderStatus = orderReceipt
            return cell
            
            
    }
    
}
