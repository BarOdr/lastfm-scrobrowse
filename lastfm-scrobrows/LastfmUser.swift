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
    private var _playcount: String?
    private var _registeredUnixtime: Double?
    private var _userFavouriteArtists: [Artist]?
    
    
    var username: String {
        get {
            if _username == nil {
                _username = ""
            }
            return _username!
        }
        set {
            _username = username
        }
    }
    
    var secret: String {
        get {
            if _secret == nil {
                _secret = ""
            }
            return _secret!
        }
        set {
            _secret = secret
        }
    }
    
    var realName: String {
        get {
            if _realName == nil {
                _realName = ""
            }
            return _realName!
        }
        set {
            _realName = realName
        }
    }
    
    var playcount: String {
        get {
            if _playcount == nil {
                _playcount = ""
            }
            return _playcount!
        }
        set {
            _playcount = playcount
        }
    }
    
    var registeredUnixtime: Double {
        get {
            if _registeredUnixtime == nil {
                _registeredUnixtime = 0.0
            }
            return _registeredUnixtime!
        }
        set {
            _registeredUnixtime = registeredUnixtime
        }
    }
    
    var userImageUrl: String {
        get {
            if _userImageUrl == nil {
                _userImageUrl = ""
            }
            return _userImageUrl!
        }
        set {
            _userImageUrl = userImageUrl
        }
    }
    var registeredString: String {
        return Helper.registrationDateFromUnixTime(_registeredUnixtime!)
    }
    
    var userFavouriteArtists: [Artist] {
        get {
            if _userFavouriteArtists == nil {
                _userFavouriteArtists = [Artist]()
            }
            return _userFavouriteArtists!
        }
        set {
            _userFavouriteArtists = userFavouriteArtists
        }
    }
    
    func setUsername(name: String) {
        _username = name
    }
    
    func setRealName(name: String) {
        _realName = name
    }
    
    func setSecret(secret: String) {
        _secret = secret
    }
    
    func setImageUrl(url: String) {
        _userImageUrl = url
    }
    
    func setPlaycount(count: String) {
        _playcount = playcount
    }
    
    func setRegisterUnixtime(time: Double) {
        _registeredUnixtime = time
    }
    
    func setUserFavouriteArtists(artists: [Artist]) {
        _userFavouriteArtists = artists
    }
}