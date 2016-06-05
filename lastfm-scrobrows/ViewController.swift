//
//  ViewController.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 05/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit
import CryptoSwift


class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var currentUser: LastfmUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        
        clearTextFields()
//        loginBtn.userInteractionEnabled = true
//        if NSUserDefaults.standardUserDefaults().valueForKey(STORED_USER_SECRET_KEY) != nil {
//            performSegueWithIdentifier("MainMenu", sender: nil)
//        }
    }

    @IBAction func attemptLogin() {
        
        if let userName = usernameTextField.text where userName != "", let pwd = pwdTextField.text where pwd != "" {
            
            loginBtn.userInteractionEnabled = false
            activityIndicator.startAnimating()
            currentUser = LastfmUser(name: userName, password: pwd)
            
            API.sharedInstance.logIn(currentUser!) { userSecret, username in
                
                if userSecret != "" && username != "" {
                    if self.rememberMeSwitch.on {
                        NSUserDefaults.standardUserDefaults().setValue(userSecret, forKey: STORED_USER_SECRET_KEY)
                        NSUserDefaults.standardUserDefaults().setValue(username, forKey: STORED_USERNAME)
                    }
                    self.activityIndicator.stopAnimating()
                    self.performSegueWithIdentifier("MainMenu", sender: nil)
                } else {
                    self.activityIndicator.stopAnimating()
                    self.showErrorAlert("Oops! Something went wrong", msg: "Make sure you enter correct username and password")
                    self.clearTextFields()
                    self.loginBtn.userInteractionEnabled = true
                }
            }
        }
    }
    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func clearTextFields() {
        usernameTextField.text = ""
        pwdTextField.text = ""
    }
}
