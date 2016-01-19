//
//  ViewController.swift
//  Revaluate
//
//  Created by Dorel Gabor on 13/01/16.
//  Copyright © 2016 REVALUATE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func viewTapped(sender : AnyObject) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func tryLogin(sender : AnyObject) {
        let email = emailTextField.text! as NSString
        let password = passwordTextField.text! as NSString
        
        let user = User();
        user.loginUser(email, password: password)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

