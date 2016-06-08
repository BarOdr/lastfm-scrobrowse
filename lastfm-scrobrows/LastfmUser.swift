//
//  User.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 05/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import Foundation

class LastfmUser {
    
    private var _username: String!
    private var _secret: String!
    
    
    var username: String {
        return _username
    }
    
    var secret: String {
        return _secret
    }
    
    init(name: String, secret: String) {
        self._username = name
        self._secret = secret
        
    }
}