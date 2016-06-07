//
//  LoginManager.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 05/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit
import CryptoSwift
import Alamofire
import SwiftyJSON

class LoginManager: NSObject {

    /** 
     This method sends a POST request to Last.fm API to obtain user secret key (default key lifetime: infinite by default). You can then use the obtained secret key as well as the username in the trailing closure
     
     - parameter user: an object of type LastfmUser
     - parameter completion: completion handler of type (userSecret: String, userName: String) -> Void. Typealias: DownloadComplete
    */
    
    func logInAttempt(user: LastfmUser, completion: DownloadComplete) {
        let hash = requestHash(user, method: LASTFM_GET_MOBILE_SESSION)
        let requestString: String
        requestString = createLoginRequestString(user.username, pwd: user.password, hash: hash, method: LASTFM_GET_MOBILE_SESSION)
        
        Alamofire.request(.POST, requestString).response { (request, response, data, error) in
            
            if error == nil {
                if let data = data {
                    let userSecretKey = self.getUserSecretFromJSON(data)
                    completion(userSecret: userSecretKey, userName: user.username)
                }
            } else {
                print("error: \(error)")
            }
        }
    }
    
    /**
     This method creates a request string for user authentication. The API key is inserted automatically; should it ever change, it will adapt to the new key as specified in API_KEY constant.
     - parameter username: Username (String)
     - parameter pwd: User password (String)
     - parameter hash: api_sig required by Last.fm API. Use requestHash method to generate the hash.
     - parameter method: Name of the method. Typically, you will want to use LASTFM_GET_MOBILE_SESSION constant as a parameter, unless Last.fm API requirements change.
     
     - returns: Request string (String)
    */
    
    func createLoginRequestString(username: String, pwd: String, hash: String, method: String) -> String {
        let requestString = "https://ws.audioscrobbler.com/2.0/?format=json&password=\(pwd)&username=\(username)&api_key=\(LASTFM_API_KEY)&api_sig=\(hash)&method=\(LASTFM_GET_MOBILE_SESSION)"
        return requestString
    }
    /**
     This method saves the logged in user's username and secret key to NSUserDefaults, accordingly for keys:
     - STORED_USERNAME string constant
     - STORED_USER_SECRET_KEY string constant
     The key constants are stored in Constants.swift.
     
     This method does NOT store user's password on the device.
     
     This method should only be used when the user wishes to stay logged in.
     
     - parameter username: Username string
     - parameter userSecretKey: User secret key string
     */
    
    func saveUser(username: String, userSecretKey: String) {
        NSUserDefaults.standardUserDefaults().setValue(userSecretKey, forKey: STORED_USER_SECRET_KEY)
        NSUserDefaults.standardUserDefaults().setValue(username, forKey: STORED_USERNAME)
    }
    
    /**
     This method creates api_sig - hash string  required by the Last.fm API as one of the authentication request parameters. As the documentation says, the api_sig string (before hash) should be of form:
     - api_keyxxxxxxxxmethodauth.getMobileSessionpasswordxxxxxxxusernamexxxxxxxxmysecret
     
     - parameter user: An object of type LastfmUser
     - parameter method: The method name string for mobile authentication. You should use LASTFM_GET_MOBILE SESSION. Should the authentication string requirements ever change, make the necessary changes.
     - returns: a 32-character hexadecimal md5 hash to use as the api_sig parameter of Last.fm authentication request
    */
    
    func requestHash(user: LastfmUser, method: String) -> String {
        let username = user.username
        let password = user.password
        let requestUrlStr = "api_key\(LASTFM_API_KEY)method\(method)password\(password)username\(username)\(LASTFM_SECRET)"
        let hash = requestUrlStr.md5()
        return hash
    }
    
    /**
     This method retrieves user secret key from the JSON from Last.fm login response.
     
     - parameter data: Data of type NSData
     - returns: User's secret key of type String
     */
    
    func getUserSecretFromJSON(data: NSData) -> String {
        
            var userSecretKey = ""
            var currentUserName = ""
            
            let json = JSON(data: data)
            
            if let key = json["session"]["key"].string {
                userSecretKey = key
            }
            if let userName = json["session"]["name"].string {
                currentUserName = userName
                print("Current user is: \(currentUserName)")
            }
        
        return userSecretKey
    }
    
}
