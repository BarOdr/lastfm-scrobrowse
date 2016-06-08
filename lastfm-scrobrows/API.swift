//
//  API.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 05/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit

class API: NSObject {

    class var sharedInstance: API {
        struct Singleton {
            static let instance = API()
            private init() {
            }
        }
        return Singleton.instance
    }
    
    private let loginManager: LoginManager
    
    override init() {
        loginManager = LoginManager()
    }
    /**
     This method removes user credentials from NSUserDefaults. Use this method to clean user data after logging out.
     - parameter CompletionHandler: allows you to perform some tasks when the logout is complete.
     */
    
    func logOut() {
        return loginManager.logOut()
    }
    /**
     This method sends a POST request to Last.fm API to obtain user secret key (default key lifetime: infinite by default). You can then use the obtained secret key as well as the username in the trailing closure
     
     - parameter user: an object of type LastfmUser
     - parameter completion: completion handler of type (userSecret: String, userName: String) -> Void. Typealias: DownloadComplete
     */
    
    func logInAttempt(user: LastfmUser, completion: DownloadComplete) {
        loginManager.logInAttempt(user, completion: completion)
    }
    
    /**
     This method creates api_sig - hash string  required by the Last.fm API as one of the authentication request parameters. As the documentation says, the api_sig string (before hash) should be of form:
     - api_keyxxxxxxxxmethodauth.getMobileSessionpasswordxxxxxxxusernamexxxxxxxxmysecret
     
     - parameter user: An object of type LastfmUser
     - parameter method: The method name string for mobile authentication. You should use LASTFM_GET_MOBILE SESSION. Should the authentication string requirements ever change, make the necessary changes.
     - returns: a 32-character hexadecimal md5 hash to use as the api_sig parameter of Last.fm authentication request
     */
    
    func saveUser(username: String, userSecretKey: String) {
        return loginManager.saveUser(username, userSecretKey: userSecretKey)
    }
}
