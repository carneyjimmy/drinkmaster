//
//  ComponentCustomizationViewController.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/8/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class ComponentCustomizationViewController: UITableViewController {

    var comp: Component?
    
    var quantity = 1.0
    
    var selectedRow = 0
    
    var subs: [Item] = []
    
    var originRow = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = comp!.quantity{
            quantity = comp!.quantity!
        }
        
        
        if let opt = comp!.options{
            for o in 1...opt.count{
                if opt[o - 1].isDefault{
                    selectedRow = o - 1
                }
            }
        }
        else {
            for i in items{
                for c in i.categories{
                    for cat in comp!.item!.categories{
                        if (c.id == cat.id){
                            subs.append(i)
                            if (i.id == comp!.item!.id){
                                selectedRow = subs.count - 1
                            }
                        }
                    }
                }
            }
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        if let _ = comp!.options{
            return 1
        }
        return 2
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let _ = comp!.options{
            return "Select Option"
        }
        else {
            if section == 0{
                return "Select Quantity"
            }
            return "Select Substitute"
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let opt = comp!.options{
            return opt.count
        }
        else {
            if section == 0{
                return 1
            }
            return subs.count
        }
    }
    
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let opt = comp!.options{
            let cell = tableView.dequeueReusableCellWithIdentifier("VariationCell", forIndexPath: indexPath) as! ComponentVariationCell
            
            cell.opt = opt[indexPath.row]
            
            if (indexPath.row == selectedRow){
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
            
            return cell
        }
        else {
            if indexPath.section == 0{
                let cell = tableView.dequeueReusableCellWithIdentifier("QuantityCell", forIndexPath: indexPath) as! ComponentQuantityCell
                
                cell.comp = self.comp!
                cell.drinkQuantity.value = self.comp!.quantity!
                
                return cell
                
            }
            else {
                let cell = tableView.dequeueReusableCellWithIdentifier("SubstituteCell", forIndexPath: indexPath) as! SubstituteCell
                
                cell.sub = subs[indexPath.row]
                cell.quantity = quantity
                if (indexPath.row == selectedRow){
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                }
                
                return cell
            }
        }
        
    }
    
    
    @IBAction func increment(sender: UIStepper) {
        quantity = Double(sender.value)
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let _ = comp!.options{
            selectedRow = indexPath.row
            comp!.options![selectedRow].selected = true
        }
        else{
            if indexPath.section > 0{
                selectedRow = indexPath.row
                comp!.item = subs[selectedRow]
            }
        }
        
        
        self.tableView.reloadData()
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
        if (segue.identifier == "Submit Edit"){
            let dest = segue.destinationViewController as! CustomizeViewController
            comp!.quantity = quantity
            dest.editedComp = comp!
        }
        
    }
    

}
