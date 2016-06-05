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

    func logIn(user: LastfmUser, completion: DownloadComplete) {
        let hash = requestHash(user, method: LASTFM_GET_MOBILE_SESSION)
        let requestString = "https://ws.audioscrobbler.com/2.0/?format=json&password=\(user.password)&username=\(user.username)&api_key=\(LASTFM_API_KEY)&api_sig=\(hash)&method=\(LASTFM_GET_MOBILE_SESSION)"
        
        Alamofire.request(.POST, requestString).response { (request, response, data, error) in
            
            if error == nil {
                if let data = data {
                    
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
                    completion(userSecret: userSecretKey, userName: currentUserName)
                }
            } else {
                print("error: \(error)")
            }
            
        }
    }
    
    func createUser() {
        
    }
    
    func requestHash(user: LastfmUser, method: String) -> String {
        let username = user.username
        let password = user.password
        let requestUrlStr = "api_key\(LASTFM_API_KEY)method\(LASTFM_GET_MOBILE_SESSION)password\(password)username\(username)\(LASTFM_SECRET)"
        let hash = requestUrlStr.md5()
        return hash
    }
    
}
