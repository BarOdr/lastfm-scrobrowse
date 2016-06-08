//
//  LastfmDataService.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 08/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import Foundation

class LastfmDataService: NSObject {
    
    
    
    
    
    /** 
     This method retrieves the current logged user (if exists) and returns an optional LastfmUser object or nil
     - returns: LastfmUser?
     */
    
    func getCurrentUser() -> LastfmUser? {
        let username = NSUserDefaults.standardUserDefaults().valueForKey(STORED_USERNAME) as? String
        let secret = NSUserDefaults.standardUserDefaults().valueForKey(STORED_USER_SECRET_KEY) as? String
        if username != nil && secret != nil {
            let user = LastfmUser(name: username!, secret: secret!)
            return user
        } else {
            return nil
        }
    }
    
}