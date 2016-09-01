//
//  CustomizeViewController.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/6/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class CustomizeViewController: UITableViewController {

    var drink: Drink?
    var selectedRow = 0
    var qCell: NSIndexPath?
    
    var atCheckout: Bool = false
    var custFavorite: Bool = false
    var checkoutRow: Int = -1
    
    var editedComp: Component?
    
    var toggleFav : UISwitch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = drink!.name

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
        if (drink!.menuSection.name! == "Cocktails" || drink!.menuSection.name! == "Favorite"){
            return 3
        }
        return 2
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (section == 1){
            if (drink!.menuSection.name! == "Cocktails" || drink!.menuSection.name! == "Favorite"){
                return drink!.components!.count
            }
            else {
                return drink!.variations!.count
            }
        }
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName: String?
        switch (section){
        case 0:
            sectionName = "Set Quantity of Drink"
        case 1:
            if (drink!.menuSection.name! == "Cocktails" || drink!.menuSection.name! == "Favorite"){
                sectionName = "Choose Components"
            }
            else {
                sectionName = "Select Variant"
            }
        default:
            sectionName = ""
        }
        return sectionName
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0){
            let cell = tableView.dequeueReusableCellWithIdentifier("QuantityCell", forIndexPath: indexPath) as! QuantityCell
            qCell = indexPath
            
            cell.drink = self.drink!
            cell.drinkQuantity.value = Double(self.drink!.quantity)
            
            return cell
        }
        else if (indexPath.section == 1){
            if (drink!.menuSection.name! == "Cocktails" || drink!.menuSection.name! == "Favorite"){
                let cell = tableView.dequeueReusableCellWithIdentifier("ComponentCell", forIndexPath: indexPath) as! ComponentCell
                
                cell.comp = drink!.components![indexPath.row]
                
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCellWithIdentifier("VariationCell", forIndexPath: indexPath) as! VariationCell
                
                cell.opt = drink!.variations![indexPath.row]
                
                if (indexPath.row == selectedRow){
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                    drink!.variations![indexPath.row].selected = true
                }
                else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                }
                return cell
            }
            
            
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("ToggleFavorite", forIndexPath: indexPath) as! ToggleFavCell
            
            toggleFav = cell.isFavorite
            toggleFav?.setOn(false, animated: false)
            for f in favorites{
                if (drink!.id == f.id){
                    toggleFav?.setOn(true, animated: false)
                }
            }
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.section == 1 && drink!.menuSection.name! != "Cocktails" && drink!.menuSection.name! != "Favorite"){
            drink!.variations![selectedRow].selected = false
            selectedRow = indexPath.row
            drink!.variations![selectedRow].selected = true
            
            //drink!.price = drink!.variations[indexPath.row].price!
            
            self.tableView.reloadData()
        }
        else if (indexPath.section == 2){
            if (custFavorite){
                removeFavorite(drink!.id)
            }
            else {
                addFavorite(drink!)
            }
        }
    }
    
    
    @IBAction func finishCust(sender: UIBarButtonItem) {
        if (atCheckout){
            if (drink!.menuSection.name! == "Beer" || drink!.menuSection.name! == "Wine"){
                performSegueWithIdentifier("AlteredItem", sender: self)
            }
            else if (toggleFav!.on){
                var already = false
                for f in favorites{
                    if drink!.id == f.id{
                        already = true
                    }
                }
                if !already{
                    addFavorite(drink!)
                    _ = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: "alteredItem", userInfo: nil, repeats: false)
                }
                else {
                    performSegueWithIdentifier("AlteredItem", sender: self)
                }

            }
            else {
                var present = false
                for f in favorites{
                    if drink!.id == f.id{
                        present = true
                    }
                }
                if present{
                    removeFavorite(drink!.id)
                    _ = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: "alteredItem", userInfo: nil, repeats: false)
                }
                else {
                    performSegueWithIdentifier("AlteredItem", sender: self)
                }
            }
            
            performSegueWithIdentifier("AlteredItem", sender: sender)
        }
        else{
            if (drink!.menuSection.name! == "Beer" || drink!.menuSection.name! == "Wine"){
                performSegueWithIdentifier("GotDrink", sender: self)
            }
            else if (toggleFav!.on){
                var already = false
                for f in favorites{
                    if drink!.id == f.id{
                        already = true
                    }
                }
                if !already{
                    addFavorite(drink!)
                    _ = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: "gotDrink", userInfo: nil, repeats: false)
                }
                else {
                    performSegueWithIdentifier("GotDrink", sender: self)
                }
            }
            else {
                var present = false
                for f in favorites{
                    if drink!.id == f.id{
                        present = true
                    }
                }
                if present{
                    removeFavorite(drink!.id)
                    _ = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: "gotDrink", userInfo: nil, repeats: false)
                }
                else {
                    performSegueWithIdentifier("GotDrink", sender: self)
                }
            }
            
            //performSegueWithIdentifier("GotDrink", sender: sender)
        }
    }
    
    func alteredItem(){
        performSegueWithIdentifier("AlteredItem", sender: self)
    }
    
    func gotDrink(){
        performSegueWithIdentifier("GotDrink", sender: self)
    }
    
    func backToCheckout(){
        performSegueWithIdentifier("BackToCheckout", sender: self)
    }
    
    func backToHub(){
        performSegueWithIdentifier("BackToHub", sender: self)
    }
    
    @IBAction func cancelCust(sender: UIBarButtonItem) {
        if (atCheckout){
            if (drink!.menuSection.name! == "Beer" || drink!.menuSection.name! == "Wine"){
                performSegueWithIdentifier("BackToCheckout", sender: self)
            }
            else if (toggleFav!.on){
                var already = false
                for f in favorites{
                    if drink!.id == f.id{
                        already = true
                    }
                }
                if !already{
                    addFavorite(drink!)
                    _ = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: "backToCheckout", userInfo: nil, repeats: false)
                }
                else {
                    performSegueWithIdentifier("BackToCheckout", sender: self)
                }
                
            }
            else {
                var present = false
                for f in favorites{
                    if drink!.id == f.id{
                        present = true
                    }
                }
                if present{
                   removeFavorite(drink!.id)
                    _ = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: "backToCheckout", userInfo: nil, repeats: false)
                }
                else {
                    performSegueWithIdentifier("BackToCheckout", sender: self)
                }
                
            }

        }
        else {
            if (drink!.menuSection.name! == "Beer" || drink!.menuSection.name! == "Wine"){
                performSegueWithIdentifier("BackToHub", sender: self)
            }
            else if (toggleFav!.on){
                var already = false
                for f in favorites{
                    if drink!.id == f.id{
                        already = true
                    }
                }
                if !already{
                    addFavorite(drink!)
                    _ = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: "backToHub", userInfo: nil, repeats: false)
                }
                else {
                    performSegueWithIdentifier("BackToHub", sender: self)
                }
            }
            else {
                var present = false
                for f in favorites{
                    if drink!.id == f.id{
                        present = true
                    }
                }
                if present{
                    removeFavorite(drink!.id)
                    _ = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: "backToHub", userInfo: nil, repeats: false)
                }
                else {
                    performSegueWithIdentifier("BackToHub", sender: self)
                }
            }
            
            //performSegueWithIdentifier("BackToHub", sender: sender)
        }
    }
    
    @IBAction func increment(sender: UIStepper) {
        drink!.quantity = Int(sender.value)
        tableView.reloadData()
    }
    
    @IBAction func cancelDeepCust(segue: UIStoryboardSegue){
        
    }
    
    @IBAction func drinkEdited(segue: UIStoryboardSegue){
        for c in 1...drink!.components!.count{
            if (drink!.components![c-1].id == editedComp!.id){
                drink!.components![c-1] = editedComp!
            }
        }
        tableView.reloadData()
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
        
        
        
        
        if (segue.identifier == "GotDrink"){
            let dest = segue.destinationViewController as! HubViewController
            dest.nextDrink = self.drink!
        }
        else if (segue.identifier == "Deep Customize"){
            let nav = segue.destinationViewController as! UINavigationController
            let dest = nav.topViewController as! ComponentCustomizationViewController
            let choice = sender as! ComponentCell
            let c = choice.comp
            if let _ = c.quantity{
                dest.comp = Component(id: c.id, item: c.item, category: c.category, quantity: c.quantity, units: c.units, onlyItem: c.onlyItem)
            }
            else {
                dest.comp = Component(id: c.id, item: c.item, category: c.category, options: c.options, onlyItem: c.onlyItem)
            }
            
        }
        else if (segue.identifier == "AlteredItem"){
            let dest = segue.destinationViewController as! CheckOutViewController
            dest.alteredItem = self.drink!
            dest.alteredRow = self.checkoutRow
        }
    }
    

}
