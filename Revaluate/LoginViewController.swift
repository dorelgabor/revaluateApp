//
//  ViewController.swift
//  Revaluate
//
//  Created by Dorel Gabor on 13/01/16.
//  Copyright © 2016 REVALUATE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let MyKeychainWrapper = KeychainWrapper()
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let hasLogin = NSUserDefaults.standardUserDefaults().boolForKey("hasLoginKey")
        if hasLogin {
            if let storedEmail = NSUserDefaults.standardUserDefaults().valueForKey("email") as? String {
                emailTextField.text = storedEmail as String
            }
            if let storedPassword = NSUserDefaults.standardUserDefaults().valueForKey(kSecValueData as String) as? String {
                passwordTextField.text = storedPassword as String
            }
        }
    }
    
    @IBAction func viewTapped(sender : AnyObject) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func tryLogin(sender : AnyObject) {
        activityIndicatorView.startAnimating()
        
        let email = emailTextField.text! as NSString
        let password = passwordTextField.text! as NSString
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        let user = User()
        user.loginUser(email, password: password) {
            (result: NSDictionary?, error: NSError?) in
            
            let hasLoginKey = NSUserDefaults.standardUserDefaults().boolForKey("hasLoginKey")
            if hasLoginKey == false {
                NSUserDefaults.standardUserDefaults().setValue(self.emailTextField.text, forKey: "email")
                self.MyKeychainWrapper.mySetObject(self.passwordTextField.text, forKey:kSecValueData)
                self.MyKeychainWrapper.writeToKeychain()
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasLoginKey")
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.activityIndicatorView.stopAnimating()
                
                if error == nil {
                    if ((result!.allValues.first! as? String) != nil) {
                        if result!.allValues.first! as! String == "Invalid email or password" {
                            self.displayErrorMessage("Invalid email or password")
                        }
                    }
                    else {
                        for (key, value) in result! {
                            print("Key: \(key), Value: \(value)")
                        }
                    }
                }
                else {
                    self.displayErrorMessage("Something went wrong. Please try again.")
                }
            })

        }
    }
    
    func displayErrorMessage(text: String) {
        let alertController = UIAlertController(title: "Error", message:
            text, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

