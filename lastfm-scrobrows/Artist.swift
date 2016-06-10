//
//  Artist.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 08/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import Foundation

class Artist {
    
    private var _artistName: String?
    private var _artistImgUrl: String?
    private var _listenersCount: Int?
    private var _playcount: Int?
    private var _userPlaycount: Int?
    private var _topTracks: [Track]?
    private var _topAlbums: [Album]?
    private var _relatedTags: [String]?
    private var _biography: String?
    
    var artistName: String! {
        get {
            if _artistName == nil {
                _artistName = ""
            }
            return _artistName
        }
        set {
            _artistName = artistName
        }
    }
    
    var artistImgUrl: String {
        get {
            if _artistImgUrl == nil {
                _artistImgUrl = ""
            }
            return _artistImgUrl!
        }
        set {
            _artistImgUrl = artistImgUrl
        }
    }
    
    var listenersCount: Int {
        get {
            if _listenersCount == nil {
                _listenersCount = 0
            }
            return _listenersCount!
        }
        set {
            _listenersCount = listenersCount
        }
    }
    
    var playcount: Int {
        get {
            if _playcount == nil {
                _playcount = 0
            }
            return _playcount!
        }
        set {
            _playcount = playcount
        }
    }
    
    var userPlaycount: Int {
        get {
            if _userPlaycount == nil {
                _userPlaycount = 0
            }
            return _userPlaycount!
        }
        set {
            _userPlaycount = userPlaycount
        }
    }
    
    var topTracks: [Track] {
        get {
            return _topTracks!
        }
        set {
            _topTracks = topTracks
        }
    }
    
    var topAlbums: [Album] {
        get {
            return _topAlbums!
        }
        set {
            _topAlbums = topAlbums
        }
    }
    
    var relatedTags: [String] {
        get {
            return _relatedTags!
        }
        set {
            _relatedTags = relatedTags
        }
    }
    
    var biography: String {
        get {
            if _biography == nil {
                _biography = "No biography yet."
            }
            return _biography!
        }
        set {
            _biography = biography
        }
    }
    
}