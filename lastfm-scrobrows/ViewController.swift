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
    @IBOutlet weak var allControlsStackView: UIStackView!
    @IBOutlet weak var mainControlsStack: UIStackView!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var loginControlsStackView: UIStackView!
    
    var currentUser: LastfmUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoginControls()
        hideMainControls()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        clearTextFields()

    }

    @IBAction func attemptLogin() {
        
        if let userName = usernameTextField.text where userName != "", let pwd = pwdTextField.text where pwd != "" {
            
            loginBtn.userInteractionEnabled = false
            
            indicateActivity()
            
            currentUser = LastfmUser(name: userName, password: pwd)
            
            API.sharedInstance.logInAttempt(currentUser!) { userSecret, username in
                
                if  username != "" && userSecret != "" {
                    if self.rememberMeSwitch.on {
                        API.sharedInstance.saveUser(username, userSecretKey: userSecret)
                    }
                    self.stopIndicatingActivity()
                    self.hideLoginControls()
                    self.showMainControls()
                    
                } else {
                    self.stopIndicatingActivity()
                    self.showErrorAlert("Oops! Something went wrong", msg: "Make sure you enter correct username and password")
                    self.clearTextFields()
                    self.loginBtn.userInteractionEnabled = true
                }
            }
        }
    }
    
    /**
     This method takes the user to their library.
     */
    
    @IBAction func goToLibrary(sender: AnyObject) {
        
    }
    
    @IBAction func scrobbleTracks(sender: UIButton) {
        
    }
    
    @IBAction func logoutBtnPressed(sender: AnyObject) {
        
    }
    
    /**
     This method shows an UIAlertController with a custom title and message to the user.
     
     - Parameter title: The title of the alert.
     - Parameter msg: Message to display to the user
     */
    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    /**
     This method clears username and password text fields.
     */
    
    func clearTextFields() {
        usernameTextField.text = ""
        pwdTextField.text = ""
    }
    
    /**
     This method shows main controls:
     - "Scrobble my tracks" button
     - "Discover music" button
     
     by showing the appropiate stack view.
     */
    
    func showMainControls() {
        self.mainControlsStack.hidden = false
        self.mainControlsStack.userInteractionEnabled = true
        self.logoutBtn.fadeIn(0.5)
    }
    
    /**
     This method hides main controls:
     - "Scrobble my tracks" button
     - "Discover music" button
     
     by hiding the appropiate stack view.
     */
    
    func hideMainControls() {
        self.mainControlsStack.hidden = true
    }
    
    /**
     This method shows login controls:
     - username input text field
     - user password input text field
     
     by showing the appropiate stack view.
    */
    
    func showLoginControls() {
        self.loginControlsStackView.hidden = false
    }
    
    /**
     This method hides login controls:
     - username input text field
     - user password input text field
     
     by hiding the appropiate stack view.
     */
    
    func hideLoginControls() {
        self.loginControlsStackView.hidden = true
    }
    
    /** 
     This method shows the activity indicator and starts its animation.
    */
    
    func indicateActivity() {
        activityIndicator.fadeIn(0.3)
        activityIndicator.startAnimating()
    }
    
    /**
     This method shows the activity indicator and stops its animation.
     */
    
    func stopIndicatingActivity() {
        self.activityIndicator.fadeOut(0.3)
        self.activityIndicator.stopAnimating()
    }
}
