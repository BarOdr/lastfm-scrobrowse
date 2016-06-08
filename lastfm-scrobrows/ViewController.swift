//
//  ViewController.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 05/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit
import CryptoSwift

let loginFailedMessageTitle = "Oops! Something went wrong"
let loginFailedMessage = "Make sure you enter correct username and password"

class ViewController: UIViewController {

    
    // @IBOutlets 
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var allControlsStackView: UIStackView!
    @IBOutlet weak var mainControlsStack: UIStackView!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var loginControlsStackView: UIStackView!
    
    // Variables
    
    var currentUser: LastfmUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoginControls()
        hideMainControls()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        clearTextFields()

    }

    @IBAction func loginBtnPressed() {
        
        if let userName = usernameTextField.text where userName != "", let pwd = pwdTextField.text where pwd != "" {
            
            attemptLogin(userName, password: pwd)
            
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
     This method performs a login attempt, provided that the user entered their login and password. The request is generated and sent to Last.fm API. In case of success, the user is logged in. If the user had set the "Remember me" switch to "on" position, their username and secret key is saved to NSUserDefaults. In case of failure, a proper UIAlertView is presented to the user, suggesting checking the credentials and trying again.
     
     - parameter username: User name (String)
     - parameter password: User password (String)
    */
    
    func attemptLogin(username: String, password: String) {
        
        loginBtn.userInteractionEnabled = false
        
        indicateActivity()
        
        currentUser = LastfmUser(name: username, password: password)
        
        API.sharedInstance.logInAttempt(currentUser!) { userSecret, username in
            
            if  username != "" && userSecret != "" {
                self.loginSucceeded(username, userSecretKey: userSecret)
                
            } else {
                self.loginFailed(loginFailedMessageTitle, message: loginFailedMessage)
            }
        }
    }
    
    /**
    This method performs some tasks after a successful login attempt:
     - saves user's username and secret key to NSUserDefaults after a successful login (if the user had expressed the wish to stay logged in),
     - turns of the activity indicator, hides login controls and shows the main controls.
     
     - parameter username: User name (String)
     - parameter userSecretKey: User secret key (String)
    */
    
    func loginSucceeded(username: String, userSecretKey: String) {
        if self.rememberMeSwitch.on {
            API.sharedInstance.saveUser(username, userSecretKey: userSecretKey)
        }
        self.stopIndicatingActivity()
        self.hideLoginControls()
        self.showMainControls()
    }
    
    /**
     This method performs some tasks after a failed login attempt:
     - stops the activity indicator,
     - shows an UIAlertView to the user
     - clears the text fields (user input)
     - enables user interaction on login button
    */
    
    func loginFailed(messageTitle: String, message: String) {
        self.stopIndicatingActivity()
        self.showErrorAlert(messageTitle, msg: message)
        self.clearTextFields()
        self.loginBtn.userInteractionEnabled = true
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
