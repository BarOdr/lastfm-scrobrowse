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
    private var _password: String!
    
    
    var username: String {
        return _username
    }
    
    var password: String {
        return _password
    }
    
    init(name: String, password: String) {
        self._username = name
        self._password = password
        
    }
}