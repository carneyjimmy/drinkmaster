//
//  HubViewController.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 10/31/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class HubViewController: UITableViewController {

    var bar: Bar?
    
    var order: [Drink] = []
        
    var recentOrder: [Drink] = []
    var recentTotal: [OrderReceipt] = []
    
    let drinkTypes = ["Beer", "Wine", "Cocktails"]
    
    var nextDrink: Drink?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = bar!.name!
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
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (section > 0){
            return 3
        }
        return favorites.count
    }
    
    @IBAction func zoomOut(segue: UIStoryboardSegue){
        if (segue.identifier == "GotDrink"){
            order.append(nextDrink!)
            
            
            //alert that tells you the order has been added
            let alertController = UIAlertController(title: "Success!", message:
                "Item added to cart.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            dispatch_async(dispatch_get_main_queue(), {
                self.presentViewController(alertController, animated: true, completion: nil)
            })
        }
        self.navigationItem.rightBarButtonItem?.title = "Cart (" + String(order.count) + ")"
        tableView.reloadData()
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0){
            return "Favorites"
        }
        return "Full Menu"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0){
            let cell = tableView.dequeueReusableCellWithIdentifier("FavoriteCell", forIndexPath: indexPath) as! FavoriteCell
            cell.drink = favorites[indexPath.row]
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("HubCell", forIndexPath: indexPath) as! HubCell
            cell.type = drinkTypes[indexPath.row]
            return cell
        }
        

        
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
        if (segue.identifier == "DrinkType"){
            let type = sender as! HubCell
            let nav = segue.destinationViewController as! UINavigationController
            let menu = nav.topViewController as? MenuViewController
            menu!.drinkType = type.typeLabel!.text!
        }
        else if (segue.identifier == "Cart"){
            let nav = segue.destinationViewController as! UINavigationController
            let dest = nav.topViewController as? CheckOutViewController
            
            for o in order{
                print(o.name)
                for v in o.variations!{
                    print(v.name!)
                }
            }
            
            dest!.drinks = self.order
        }
        else if (segue.identifier == "Pivot Menu"){
            let nav = segue.destinationViewController as! UINavigationController
            let dest = nav.topViewController as! PivotMenu
            dest.recentOrder = recentOrder
            dest.recentTotal = recentTotal
        }
        else if (segue.identifier == "CustomizeFavorite"){
            let nav = segue.destinationViewController as! UINavigationController
            let cust = nav.topViewController as? CustomizeViewController
            
            let drinkCell = sender as! FavoriteCell
            let rawDrink = drinkCell.drink
            let drinkCopy = rawDrink.copy()
            
            cust?.drink = drinkCopy
            cust?.custFavorite = true
            
        }
    }
    

}
