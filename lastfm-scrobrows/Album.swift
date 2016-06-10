//
//  Album.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 08/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import Foundation

class Album {
    
    private var _albumName: String?
    private var _albumArtist: String?
    private var _tracks: [Track]?
    private var _releaseDate: String?
    private var _userPlayCount: Int?
    private var _overallPlayCount: Int?
    private var _coverUrl: String?
    
    var albumName: String {
        get {
            if _albumName == nil {
                _albumName = ""
            }
            return _albumName!
        }
        set {
            _albumName = albumName
        }
    }
    
    var albumArtist: String {
        get {
            if _albumArtist == nil {
                _albumArtist = ""
            }
            return _albumArtist!
        }
        set {
            _albumArtist = albumArtist
        }
    }
    var trackCount: Int {
        get {
            if _tracks == nil {
                return 0
            }
            return tracks.count
        }
    }
    
    var tracks: [Track] {
        get {
            return _tracks!
        }
        set {
            _tracks = tracks
        }
    }
    
    var releaseDate: String {
        get {
            if _releaseDate == nil {
                _releaseDate = "Unknown"
            }
            return _releaseDate!
        }
        set {
            _releaseDate = releaseDate
        }
    }
    
    var userPlayCount: Int {
        get {
            
            return _userPlayCount!
        }
        set {
            _userPlayCount = userPlayCount
        }
    }
    
    var overallPlayCount: Int {
        get {
            return _overallPlayCount!
        }
        set {
            _overallPlayCount = overallPlayCount
        }
    }
    
    var coverUrl: String {
        get {
            return _coverUrl!
        }
        set {
            _coverUrl = coverUrl
        }
    }
}