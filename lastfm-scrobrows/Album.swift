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
        return _albumName!
    }
    var trackCount: Int {
        return tracks.count
    }
    
    var tracks: [Track] {
        return _tracks!
    }
    
    var releaseDate: String {
        return _releaseDate!
    }
    
    var userPlayCount: Int {
        return _userPlayCount!
    }
    
    var overallPlayCount: Int {
        return _overallPlayCount!
    }
    
    var coverUrl: String {
        return _coverUrl!
    }
    
    /** 
     
     Use this initializer for parse method user.getTopAlbums
     
     */
    
    init(name: String, userPlaycount: Int, albumArtist: String, imageUrl: String) {
        self._albumName = name
        self._userPlayCount = userPlayCount
        self._albumArtist = albumArtist
    }
    
    
    
}