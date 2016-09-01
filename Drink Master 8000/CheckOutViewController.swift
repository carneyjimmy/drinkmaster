//
//  CheckOutViewController.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/6/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class CheckOutViewController: UITableViewController, UITextFieldDelegate {
    
    
    var drinks: [Drink] = [
       
    ]
    var tfield = UITextField()
    
    var totals: [OrderReceipt] = []
    
    var tip: Tip?
    
    var selectedCard: Card?
    
    var tips: [Tip] = [
        Tip(percent: 0, value: 0),
        Tip(percent: 0, value: 0),
        Tip(percent: 0, value: 0),
        Tip(percent: 0, value: 0)
    ]
    
    @IBAction func inHere2(sender: AnyObject) {
        
        print("in this method")
        
    }
    var tipRow = 1
    
    var alteredItem: Drink?
    var alteredRow: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for d in drinks{
            print(d.name)
            for v in d.variations!{
                print(v.selected)
            }
        }
        
        updateTotals()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    
    func updateTotals(){
        var subtotal = 0.00
        
        totals = []
        
        for ord in drinks{
            subtotal += ord.getPrice()
        }
        
        let tax = subtotal * 0.08
        
        tips[0] = Tip(percent: 15, value: subtotal * 0.15)
        tips[1] = Tip(percent: 18, value: subtotal * 0.18)
        tips[2] = Tip(percent: 20, value: subtotal * 0.20)
        
        let total = subtotal + tax + tips[tipRow].value!
        
        totals.append(OrderReceipt(name: "Subtotal", cost: subtotal))
        totals.append(OrderReceipt(name: "Tax", cost: tax))
        totals.append(OrderReceipt(name: "Tip", cost: tips[tipRow].value!))
        totals.append(OrderReceipt(name: "Total", cost: total))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (section == 0){
            return drinks.count
        }
        else if (section == 1){
            return 4
        }
        else if (section == 2){
            return 4
        }
        else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName: String?
        switch (section){
        case 0:
            sectionName = "Drinks"
        case 1:
            sectionName = "Select Tip Amount"
        case 2:
            sectionName = "Summary"
        case 3:
            sectionName = "Select Card"
        default:
            sectionName = ""
        }
        return sectionName
    }

    
    func textFieldDidEndEditing(textField: UITextField){
        tips[3].value = Double(textField.text!)
        tipRow = 3
        updateTotals()
        tableView.reloadData()
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        if (indexPath.section == 0){
            let cell = tableView.dequeueReusableCellWithIdentifier("CheckoutCell", forIndexPath: indexPath) as! CheckOutCell
            cell.item = drinks[indexPath.row]
            //cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
        else if (indexPath.section == 1) {
            
                let cell = tableView.dequeueReusableCellWithIdentifier("TipCell", forIndexPath: indexPath) as! TipCell
                
                cell.tip = tips[indexPath.row]
                
                if (indexPath.row == tipRow){
          
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                }
                
                return cell
            
          
            
        }
        else if (indexPath.section == 2){
            let cell = tableView.dequeueReusableCellWithIdentifier("TotalCell", forIndexPath: indexPath) as! TotalCell
            cell.total = totals[indexPath.row]
            
            return cell
        }
        else if (indexPath.section == 3){
            let cell = tableView.dequeueReusableCellWithIdentifier("CardCell", forIndexPath: indexPath) as! CardCell
            
            if let c = selectedCard{
                cell.card = c
            }
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("FinishCell", forIndexPath: indexPath)
            
            return cell
        }
//        cell.drink = totals[indexPath.row]
//        return cell
    }
    
    @IBAction func toggleEdit(sender: UIBarButtonItem) {
        if (tableView.editing){
            tableView.editing = false
            sender.title = "Edit"
        }
        else {
            tableView.editing = true
            sender.title = "Done"
        }
        
    }
    
    override func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if (indexPath.section == 0){
            return true
        }
        return false
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if (indexPath.section > 0){
            return UITableViewCellEditingStyle.None
        }
        else {
            return UITableViewCellEditingStyle.Delete
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete){
            drinks.removeAtIndex(indexPath.row)
            updateTotals()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            tableView.reloadData()
        }
    }
    
    @IBAction func cardSelected(segue: UIStoryboardSegue){
        tableView.reloadData()
    }
    
    @IBAction func backToCheckout(segue: UIStoryboardSegue){
        if (segue.identifier == "AlteredItem"){
            self.drinks[alteredRow!] = self.alteredItem!
        }
        updateTotals()
        tableView.reloadData()
    }
    
    func addTextField (textField: UITextField!){
        textField.placeholder = "Custom Tip Here"
        tfield = textField
        textField.keyboardType = UIKeyboardType.DecimalPad
        
    }
    
    func completion(action: UIAlertAction!){
        
        if let checker:Double = Double(((tfield.text)!)){
            tips[3].value = Double(tfield.text!)
            tipRow = 3
            updateTotals()
            tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 1){
            if(indexPath.row == 3){
                let alert = UIAlertController(title: "Custom", message: "enter a tip value", preferredStyle: UIAlertControllerStyle.Alert)
                 alert.addTextFieldWithConfigurationHandler(addTextField)
                alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: completion))
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            else{
                tipRow = indexPath.row
            updateTotals()
            tableView.reloadData()
            }
        }
        else if (indexPath.section == 4){
            if (drinks.count > 0){
                if let _ = selectedCard{
                    performSegueWithIdentifier("Submit Order", sender: self)
                }
                else {
                    
                    let alert = UIAlertController(title: "Missing Information", message: "You must select a card to pay with.", preferredStyle: UIAlertControllerStyle.Alert)
                   
                    alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
            else {
                let alert = UIAlertController(title: "Empty Order", message: "You must add at least one drink to an order.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        else if (indexPath.section == 0){
            
            alteredRow = indexPath.row
            alteredItem = self.drinks[indexPath.row]
            performSegueWithIdentifier("EditDrink", sender: self)
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
        
        if (segue.identifier == "Submit Order"){
            
            
            let nav = segue.destinationViewController as! UINavigationController
            let dest = nav.topViewController as! OrderStatusView
            
            let sub = totals[0].cost!
            let tax = totals[1].cost!
            let tip = totals[2].cost!
            let total = totals[3].cost!
            let o = Order(status: OrderStatus.Preparing, drinks: self.drinks, firstStatus: true, sub_total: sub, tax: tax, tip: tip, total: total, time_created: NSDate(timeIntervalSinceNow: 0), estimated_pickup_time: NSDate(timeIntervalSinceNow: 300), placeInLine:(placeInLine), minRemaining:(orderTime))
            orders.insert(o, atIndex: 0)
            
            dest.order = orders[0]
            createOrder(self.drinks, tip: tip)
           
            sleep(1)
            
            
            var year = estimated_pickup_time
            year = year.substringWithRange(Range<String.Index>(start: estimated_pickup_time.startIndex, end: estimated_pickup_time.startIndex.advancedBy(4)))
            let month = estimated_pickup_time.substringWithRange(Range<String.Index>(start: estimated_pickup_time.startIndex.advancedBy(5), end: estimated_pickup_time.startIndex.advancedBy(7)))
            let day = estimated_pickup_time.substringWithRange(Range<String.Index>(start: estimated_pickup_time.startIndex.advancedBy(8), end: estimated_pickup_time.startIndex.advancedBy(10)))
            let hour = estimated_pickup_time.substringWithRange(Range<String.Index>(start: estimated_pickup_time.startIndex.advancedBy(11), end: estimated_pickup_time.startIndex.advancedBy(13)))
            let min = estimated_pickup_time.substringWithRange(Range<String.Index>(start: estimated_pickup_time.startIndex.advancedBy(14), end: estimated_pickup_time.startIndex.advancedBy(16)))
            
            /*print(estimated_pickup_time)
            print(year)
            print(month)
            print(day)
            print(hour)
            print(min)
            print(orderTime)*/
            
            let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
            
            let components = NSDateComponents()
            components.year = Int(year)!
            components.month = Int(month)!
            components.day = Int(day)!
            components.hour = Int(hour)!-6
            components.minute = Int(min)!
            components.second = 0
            components.timeZone = NSTimeZone.systemTimeZone()
            
            let orderDate = calendar?.dateFromComponents(components)
            
            let notification:UILocalNotification = UILocalNotification()
            notification.category = "FIRST_CATEGORY"
            notification.alertBody = "Your order is ready!"
            notification.fireDate = orderDate
            
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
            

            
        }
        else if (segue.identifier == "EditDrink"){
            let nav = segue.destinationViewController as! UINavigationController
            let dest = nav.topViewController as! CustomizeViewController
            dest.atCheckout = true
            dest.drink = alteredItem
            dest.checkoutRow = alteredRow!
        }
        
    }
    

}
