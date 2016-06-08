//
//  Track.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 08/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import Foundation

class Track {
    
    private var _trackName: String!
    private var _userPlayCount = 0
    private var _overallPlayCount = 0
    private var _userLove = false
    
    var trackName: String {
        if _trackName == nil {
            _trackName = ""
        }
        return _trackName
    }
    
    var userLove: Bool {
        return _userLove
    }
    
    var userPlayCount: Int {
        return _userPlayCount
    }
    
    var overallPlayCount: Int {
        return _overallPlayCount
    }
    
}