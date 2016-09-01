//
//  AddingCardTableViewController.swift
//  Drink Master 8000
//
//  Created by Jared Quincy Davis on 12/5/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class AddingCardTableViewController: UITableViewController, UITextFieldDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem =     self.editButtonItem()
        
//            cardNumberField.keyboardType = .NumberPad
//            cvcField.keyboardType = .NumberPad
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == nameField
        {
            //consider making name only alphabetic. Seems unnecessary for me
        
        
        }
        
        if textField == cardNumberField
        {
        
        
        
        
        }
        
        if textField == dateField
        {
        
        
        }
        
        if textField == cvcField
        {
                
        
        
        }
        
        /*if textField == emailTextField
        {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            
            let result = emailTest.evaluateWithObject(emailTextField.text!)
            
            if result
            {
                
            }
            else
            {
                emailTextField?.text = ""
                let alert = UIAlertController(title: "Invalid email", message: "Please enter a valid email", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
        if textField == passwordTextField
        {
            let length = passwordTextField.text!.characters.count
            if(length < 2 || length > 13){
                passwordTextField?.text = ""
                let alert = UIAlertController(title: "Invalid Password", message: "Password must be 3-12 characters long", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
        }
        
        
        if textField == confirmPassTextField
        {
            let validConfirm = (confirmPassTextField.text! == passwordTextField.text!)
            
            if validConfirm
            {
                // print("passwords must ma")
            }
            else
            {
                confirmPassTextField?.text = ""
                passwordTextField?.text = ""
                let alert = UIAlertController(title: "Invalid Password", message: "Make sure that your passwords match", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
        }*/
        
        
    }
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var cardNumberField: UITextField!
   
    @IBOutlet weak var dateField: UITextField!
    
    @IBOutlet weak var cvcField: UITextField!
    
    
    @IBAction func attemptToAddCard(sender: AnyObject) {

        //name Field Valid
        let username = nameField?.text
        
        if username!.characters.count < 2 {
            nameField?.text = ""
            let alert = UIAlertController(title: "Invalid name", message: "Please enter a name with more than 2 characters", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        //card Number Valid
        let cardNum = cardNumberField?.text
        
        if (cardNum!.characters.count < 16 || cardNum!.characters.count > 32) {
            cardNumberField?.text = ""
            let alert = UIAlertController(title: "Invalid card number", message: "Please enter a valid credit card number", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        //date Field Valid
        let date = dateField?.text
        
        if(date!.characters.count < 5 || date!.characters.count > 10){
            dateField?.text = ""
            let alert = UIAlertController(title: "Invalid Date", message: "Please enter a valid date in the format MM/YY", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        //cvc field valid
        let cvc = cvcField?.text
        
        if(cvc!.characters.count < 3 || cvc!.characters.count > 4){
            cvcField?.text = ""
            let alert = UIAlertController(title: "Invalid Cvc", message: "Please enter a valid cvc in the format ###", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        if let nam = nameField?.text{
            if let num = cardNumberField?.text {
                if let d = dateField?.text{
                    
                    if (nam == "" || num == "" || d == "" || cvc == ""){
                        let alert = UIAlertController(title: "Missing Information", message: "One or more fields have been left blank.", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    else {
                         performSegueWithIdentifier("AdditionOfCard", sender: self)
                        //
                        //
                        //
                        
                    }
                    
                }
            }
        }

        
    }
    
   /* @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPassTextField: UITextField!
    
    @IBAction func cancelCard(segue: UIStoryboardSegue){
        
    }
    
    @IBAction func attemptSignUp(sender: UIBarButtonItem) {
        
        if let em = emailTextField?.text{
            if let pass = passwordTextField?.text {
                if let conf = confirmPassTextField?.text{
                    
                    if (em != "" && pass != "" && conf != ""){
                        getToken(em, password: pass, newUser: true)
                        _ = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "executeSignUp", userInfo: nil, repeats: false)
                    }
                    else {
                        let alert = UIAlertController(title: "Missing Information", message: "One or more fields have been left blank.", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
    
                }
            }
        }
        
    }
    
    func executeSignUp(){
        performSegueWithIdentifier("SignUpUser", sender: self)
    }*/


    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
