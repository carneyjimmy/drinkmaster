//
//  SignUpTableViewController.swift
//  Drink Master 8000
//
//  Created by Jared Eisenberg on 10/25/15.
//  Copyright © 2015 Dromo. All rights reserved.
//

import UIKit

class SignUpTableViewController: UITableViewController, UITextFieldDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    //write code to respond to invalid/valid input. What should the app do in each case? 
    //examples - invalid email: clear the email field, and print message
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        if textField == emailTextField
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
        }

        
    }
    
    
   
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPassTextField: UITextField!
    
    @IBAction func cancelCard(segue: UIStoryboardSegue){
        
    }

    @IBAction func attemptSignUp(sender: UIBarButtonItem) {
        //nameFieldValid 
        let username = nameTextField?.text
        
        if username!.characters.count < 2 {
            let alert = UIAlertController(title: "Invalid name", message: "Please enter a name with more than 2 characters", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
       
        //email validation
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluateWithObject(emailTextField.text!)
        
        if !result
        {
            emailTextField?.text = ""
            let alert = UIAlertController(title: "Invalid email", message: "Please enter a valid email", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        //password confirmation
        let length = passwordTextField.text!.characters.count
        if(length < 2 || length > 13){
            passwordTextField?.text = ""
            let alert = UIAlertController(title: "Invalid Password", message: "Password must be 3-12 characters long", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }

        

        //confirm password validation
        
        let validConfirm = (confirmPassTextField.text! == passwordTextField.text!)
        
        if !validConfirm
        {
            confirmPassTextField?.text = ""
            passwordTextField?.text = ""
            let alert = UIAlertController(title: "Invalid Password", message: "Make sure that your passwords match", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
       
        

        
        if let em = emailTextField?.text{
            if let pass = passwordTextField?.text {
                if let conf = confirmPassTextField?.text{
                    
                    if (em == "" || pass == "" || conf == "" || nameTextField?.text == ""){
                        let alert = UIAlertController(title: "Missing Information", message: "One or more fields have been left blank.", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    else {
                        
                        getToken(em, password: pass, newUser: true)
                        _ = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "executeSignUp", userInfo: nil, repeats: false)
                        
                        
                    }
                    
                }
            }
        }
        
    }
    
    func executeSignUp(){
        performSegueWithIdentifier("SignUpUser", sender: self)
    }
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
