//
//  OrderStatusView.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 11/6/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class OrderStatusView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var timer : NSTimer = NSTimer()
    
    @IBOutlet weak var place: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    
    
    @IBOutlet weak var estWaitTime: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var waitLabel: UILabel!
    
    
    
    var order: Order?
    var fromHistory = false
    var count = 0
    var curr = 0
    var bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if let ord = order {
            sleep(1)
            if (ord.status == OrderStatus.Complete || ord.minRemaining == 0){
                
                place.text = ""
                estWaitTime.text = ""
                
                placeLabel.text = "ORDER"
                waitLabel.text = "COMPLETED"
            }
            else {
                if (ord.firstStatus == true){
                    ord.placeInLine = (placeInLine)
                    ord.minRemaining = (orderTime)
                    curr = orderTime
                    if (placeInLine != 0){
                        order!.timePerOrder = Int(round((Double(order!.minRemaining / order!.placeInLine))))
                    }
                    else {
                        order!.timePerOrder = 0
                    }
                    print (order!.timePerOrder)
                    print(order!.minRemaining)
                    print(order!.placeInLine)
                    print (curr)
                    ord.firstStatus = false
                }
                else {
                    curr = ord.minRemaining
                }
                
                
                place.text = String(ord.placeInLine)
                estWaitTime.text = String (ord.minRemaining) + " min"
                
                timer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
                
                
                placeLabel.text = "Place in Line"
                waitLabel.text = "Est Wait Time"
                
                
            }
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    func update() {
        if (order!.minRemaining == 0) {
            done()
            
        }
            
        else {
            
            
            
            if( curr == order!.minRemaining + order!.timePerOrder ){
                if (order?.placeInLine == 0){
                    
                }
                    
                else{
                    place.text = String(order!.placeInLine--)
                    curr = order!.minRemaining
                    print(String(curr) + " curr")
                    print(String (order!.minRemaining) + "mins")
                    print(String(order!.placeInLine) + " place")
                    print(String(order!.timePerOrder) + " t/o")
                }
                
            }
            
            estWaitTime.text = String(order!.minRemaining--) + " min"
            
        }
    }
    func done(){
        timer.invalidate()
        order!.status = OrderStatus.Complete
        place.text = ""
        estWaitTime.text = ""
        
        placeLabel.text = "ORDER"
        waitLabel.text = "COMPLETED"
        
        
        let alert = UIAlertController(title: "Order Complete", message: "Your order is ready!", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(sender: UIBarButtonItem) {
        if (fromHistory){
            performSegueWithIdentifier("Back", sender: self)
        }
        else {
            performSegueWithIdentifier("Save Status", sender: self)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        // #warning Incomplete implementation, return the number of sections
        
        return 2
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
        if (section == 0){
            return order!.drinks.count
        }
        return 4
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0){
            return "Drinks"
        }
        return "Summary"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.allowsSelection = false
        if (indexPath.section == 0){
            let cell = tableView.dequeueReusableCellWithIdentifier("OrderStatusCell", forIndexPath: indexPath) as! OrderStatusCell
            
            cell.orderStatus = order!.drinks[indexPath.row]
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("OrderTotalCell", forIndexPath: indexPath) as! OrderTotalCell
            if (indexPath.row == 0){
                cell.amount = OrderReceipt(name: "Subtotal", cost: order!.sub_total)
            }
            else if (indexPath.row == 1){
                cell.amount = OrderReceipt(name: "Tax", cost: order!.tax)
            }
            else if (indexPath.row == 2){
                cell.amount = OrderReceipt(name: "Tip", cost: order!.tip)
            }
            else if (indexPath.row == 3){
                cell.amount = OrderReceipt(name: "Total", cost: order!.total)
            }
            
            return cell
        }
        
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "Save Status"){
            let dest = segue.destinationViewController as! HubViewController
            dest.order = []
        }
        
    }
    
    
}
