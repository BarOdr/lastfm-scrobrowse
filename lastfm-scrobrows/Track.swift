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
    private var _overallPlayCount: Int?
    private var _userLove: Bool?
    private var _duration: String?
    private var _artist: Artist?
    
    var trackName: String {
        if _trackName == nil {
            _trackName = ""
        }
        return _trackName!
    }
    
    var userLove: Bool {
        return _userLove!
    }
    
    var userPlayCount: String {
        return _userPlayCount!
    }
    
    var overallPlayCount: Int {
        return _overallPlayCount!
    }
    
    var artist: Artist {
        return _artist!
    }
    
    /**
     Use this initializer for parse method userGetTopArtists
     */
    
    init(trackname: String, duration: String, userPlaycount: String, artistName: Artist) {
        self._trackName = trackname
        self._duration = duration
        self._userPlayCount = userPlaycount
        self._artist = artist
    }
}