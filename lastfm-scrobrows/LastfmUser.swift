//
//  User.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 05/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import Foundation

class LastfmUser {
    
    private var _username: String?
    private var _realName: String?
    private var _secret: String?
    private var _userImageUrl: String?
    private var _playcount: Int?
    private var _registered: Double?
    
    
    var username: String {
        return _username!
    }
    
    var secret: String {
        return _secret!
    }
    
    var realName: String {
        return _realName!
    }
    
    var playcount: Int {
        return _playcount!
    }
    
    var registered: String {
        return Helper.registrationDateFromUnixTime(_registered!)
    }
    
    init(name: String, secret: String) {
        self._username = name
        self._secret = secret
        
    }
    
    /** 
     Use this initializer for parse method userGetUserInfo
     */
    
    init(name: String, realname: String, userImageUrl: String, userPlaycount: Int, userRegistrationDate: Double) {
        self._username = name
        self._realName = realname
        self._userImageUrl = userImageUrl
        self._playcount = userPlaycount
        self._registered = userRegistrationDate
    }
    
}