//
//  Album.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 08/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import Foundation

class Album {
    
    private var _albumName: String!
    private var _tracks: [Track]!
    private var _runningTime: String!
    private var _userPlayCount = 0
    private var _overallPlayCount = 0
    private var _coverUrl: String!
    
    var trackCount: Int {
        return tracks.count
    }
    
    var tracks: [Track] {
        return _tracks
    }
    
    var runningTime: String {
        return _runningTime
    }
    
    var userPlayCount: Int {
        return _userPlayCount
    }
    
    var overallPlayCount: Int {
        return _overallPlayCount
    }
    
    var coverUrl: String {
        return _coverUrl
    }
    
}