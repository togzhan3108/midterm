//
//  LoginViewController.swift
//  Midterm
//
//  Created by Тогжан Салимова on 10/17/20.
//  Copyright © 2020 Тогжан Салимова. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func log(_ sender: AnyObject) {
        if((username.text?.contains("togzhan3108"))! && (password.text?.contains("12345"))!) {
        // NSLog("Login successfully!")
             self.performSegue(withIdentifier: "Seque", sender: [username.text!, password.text!])
         }
         else {
         return
         }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
}
