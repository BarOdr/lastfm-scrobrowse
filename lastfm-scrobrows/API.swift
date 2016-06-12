//
//  API.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 05/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API: NSObject {
    
    private let loginManager: LoginManager
    private let lastfmDataService: LastfmDataService
    
    deinit {
        print("Api is being deinitialized")
    }
    override init() {
        loginManager = LoginManager()
        lastfmDataService = LastfmDataService()
    }
    
    func lastfmDownloadTask(type: Alamofire.Method, parameters: Dictionary<String, AnyObject>, completion: LastfmDownloadComplete) {
        return lastfmDataService.lastfmDownloadTask(type, parameters: parameters, completion: completion)
    }
    
    func userGetTopAlbums(amount: Int, json: JSON) -> [Album] {
        return lastfmDataService.userGetTopAlbums(amount, json: json)
    }
    
    func userGetTopTracks(amount: Int, json: JSON) -> [Track] {
        return lastfmDataService.artistGetTopTracks(amount, json: json)
    }
    
    func userGetTopArtists(amount: Int, json: JSON) -> [Artist] {
        return lastfmDataService.userGetTopArtists(amount, json: json)
    }
    
    func userGetUserInfo(json: JSON) -> LastfmUser {
        return lastfmDataService.userGetUserInfo(json)
    }
    
    func userGetRecentTracks(amount: Int, json: JSON) -> [Track] {
        return lastfmDataService.userGetRecentTracks(amount, json: json)
    }
    
    func artistGetInfo(json: JSON) -> Artist {
        return lastfmDataService.artistGetInfo(json)
    }
    
    func artistGetTopTracks(amount: Int, json: JSON) -> [Track] {
        return lastfmDataService.artistGetTopTracks(amount, json: json)
    }
    
    func artistGetTopAlbums(amount: Int, json: JSON) -> [Album] {
        return lastfmDataService.artistGetTopAlbums(amount, json: json)
    }
    
    func artistGetSimilarArtists(amount: Int, json: JSON) -> [Artist] {
        return lastfmDataService.artistGetSimilarArtists(amount, json: json)
    }
    
    
    
    
    
    
    
    
    
    
    
    //////////////////////// LOGIN MANAGER METHODS ///////////////////////////
    
    /**
     This method retrieves the current logged user (if exists) and returns an optional LastfmUser object or nil
     - returns: LastfmUser?
     */
    
    func getCurrentUser() -> LastfmUser? {
        return loginManager.getCurrentUser()
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
    
    func logInAttempt(username: String, password: String, completion: UserLoginComplete) {
        loginManager.logInAttempt(username, password: password, completion: completion)
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
