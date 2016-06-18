//
//  ViewController.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 05/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit
import CryptoSwift
import SwiftyJSON
import AlamofireImage
import Alamofire

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
    @IBOutlet weak var userAvatarImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var testImage: UIImageView!
    // Variables
    
    var currentUser: LastfmUser?
    
    var userInitialTopTenArtists = [Artist]()
    var userFavouriteArtists = [Artist]()
    
    let api = API()
    let last = LastfmDataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = api.getCurrentUser() {
            currentUser = user
            print("User logged in and loaded")
            print(currentUser?.username)
            print("Username is \(currentUser!.username)")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        clearTextFields()
        
        if userLoggedIn() {
            hideLoginControls()
            showMainControls()
        } else {
            showLoginControls()
            hideMainControls()
        }
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
        
        if let cachedArtists = CacheService.artistCache.objectForKey("userArtists")  {
            self.userInitialTopTenArtists = cachedArtists as! [Artist]
            self.goToArtistList()
            
        } else {
            
            let parameters = last.generateParametersForUserMethods(PARAM_USER_GET_TOP_ARTISTS, apiKey: LASTFM_API_KEY, user: "\(currentUser!.username)", period: "", limit: "", page: "")
            
            api.lastfmDownloadTask(GET, parameters: parameters) { (json) in
                
                self.userInitialTopTenArtists = self.api.userGetTopArtists(50, json: json)
                
                CacheService.artistCache.setObject(self.userInitialTopTenArtists, forKey: "userArtists")
                
                for artist in self.userInitialTopTenArtists {
                    print(artist.artistName)
                }
                self.api.imagesDownloader(self.userInitialTopTenArtists, complete: { (artists) in
                    
                    self.userInitialTopTenArtists = artists
                    self.goToArtistList()
                })
            }
        }

    }
    
    @IBAction func scrobbleTracks(sender: UIButton) {
        
    }
    
    @IBAction func logoutBtnPressed(sender: AnyObject) {
        clearTextFields()
        api.logOut()
        showLoginControls()
        hideMainControls()
    }
    
    /**
     This method instatiates and presents ArtistListVC
     */
    
    func goToArtistList() {
        let artistListVC = storyboard?.instantiateViewControllerWithIdentifier("ArtistListVC") as! ArtistListVC
        artistListVC.currentUser = currentUser!
        artistListVC.artistsArray = userInitialTopTenArtists
        presentViewController(artistListVC, animated: true, completion: nil)
    }
    
    /**
     This method performs a login attempt, provided that the user entered their login and password. The request is generated and sent to Last.fm API. In case of success, the user is logged in. If the user had set the "Remember me" switch to "on" position, their username and secret key is saved to NSUserDefaults. In case of failure, a proper UIAlertView is presented to the user, suggesting checking the credentials and trying again.
     
     - parameter username: User name (String)
     - parameter password: User password (String)
    */
    
    func attemptLogin(username: String, password: String) {
        
        loginBtn.userInteractionEnabled = false
        
        indicateActivity()
        
        api.logInAttempt(username, password: password) { userSecret, username in
            
            if  username != "" && userSecret != "" {
                self.loginSucceeded(username, userSecretKey: userSecret)
                
            } else {
                self.loginFailed(loginFailedMessageTitle, message: loginFailedMessage)
            }
        }
        
        loginBtn.userInteractionEnabled = true
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
            api.saveUser(username, userSecretKey: userSecretKey)
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
     - User avatar
     
     by showing the appropiate stack view.
     */
    
    func showMainControls() {
        self.mainControlsStack.hidden = false
        self.mainControlsStack.userInteractionEnabled = true
        self.logoutBtn.fadeIn(0.5)
        self.userAvatarImage.hidden = false
        self.userAvatarImage.fadeIn(0.5)
        self.userNameLabel.hidden = false
        self.userNameLabel.fadeIn(0.5)
    }
    
    /**
     This method hides main controls:
     - "Scrobble my tracks" button
     - "Discover music" button
     
     by hiding the appropiate stack view.
     */
    
    func hideMainControls() {
        self.mainControlsStack.hidden = true
        self.userAvatarImage.fadeOut(0.5)
        self.userNameLabel.fadeOut(0.5)
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
     This method shows the activity indicator and stops its animation.
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
        userLoggedIn()
    }

     /**
     This method checks if user credentials:
     - user's secet key
     - user's username
     are stored in NSUserDefaults. It also sets currentUser.
     - returns: Bool
     */
    
    func userLoggedIn() -> Bool {
        if NSUserDefaults.standardUserDefaults().valueForKey(STORED_USER_SECRET_KEY) != nil
        && NSUserDefaults.standardUserDefaults().valueForKey(STORED_USERNAME) != nil {

            return true
        } else {
            return false
        }
    }

    

}
