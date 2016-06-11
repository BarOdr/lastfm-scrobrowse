//
//  Track.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 08/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import Foundation

class Track {
    
    private var _trackName: String?
    private var _userPlayCount: String?
    private var _listenerCount: String?
    private var _overallPlayCount: String?
    private var _userLove: Bool?
    private var _duration: String?
    private var _artist: Artist?
    
    var trackName: String {
        get {
            if _trackName == nil {
                _trackName = ""
            }
            return _trackName!
        }
        set {
            _trackName = trackName
        }
    }
    
    var userLove: Bool {
        get {
            if _userLove == nil {
                _userLove = false
            }
            return _userLove!
        }
        set {
            _userLove = userLove
        }
    }
    
    var userPlayCount: String {
        get {
            if _userPlayCount == nil {
                _userPlayCount = ""
            }
            return _userPlayCount!
        }
        set {
            _userPlayCount = userPlayCount
        }
    }
    
    var overallPlayCount: String {
        get {
            if _overallPlayCount == nil {
                _overallPlayCount = ""
            }
            return _overallPlayCount!
        }
        set {
            _overallPlayCount = overallPlayCount
        }
    }
    
    var artist: Artist {
        get {
            return _artist!
        }
        set {
            _artist = artist
        }
    }
    
    var duration: String {
        get {
            if _duration == nil {
                _duration = ""
            }
            return _duration!
        }
        set {
            _duration = duration
        }
    }
    
    var listenerCount: String {
        get {
            if _listenerCount == nil {
                _listenerCount = "0"
            }
            return _listenerCount!
        }
        set {
            _listenerCount = listenerCount  
        }
    }
}
























