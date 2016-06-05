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
    
    func logIn(user: LastfmUser, completion: DownloadComplete) {
        loginManager.logIn(user, completion: completion)
    }
    
    func createUser() {
        return loginManager.createUser()
    }
    
    
}
