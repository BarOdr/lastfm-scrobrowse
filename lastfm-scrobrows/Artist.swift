//
//  Artist.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 08/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import Foundation

struct Artist {
    
    private var _artistName: String?
    private var _artistImgUrl: String?
    private var _listenersCount: String?
    private var _playcount: String?
    private var _userPlaycount: String?
    private var _topTracks: [Track]?
    private var _topAlbums: [Album]?
    private var _similarArtists: [Artist]?
    private var _relatedTags: [String]?
    private var _biography: String?
    private var _onTour: String?
    private var _match: String?
    
    var artistName: String! {
        mutating get {
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
        mutating get {
            if _artistImgUrl == nil {
                _artistImgUrl = ""
            }
            return _artistImgUrl!
        }
        set {
            _artistImgUrl = artistImgUrl
        }
    }
    
    var listenersCount: String {
        mutating get {
            if _listenersCount == nil {
                _listenersCount = "0"
            }
            return _listenersCount!
        }
        set {
            _listenersCount = listenersCount
        }
    }
    
    var playcount: String {
        mutating get {
            if _playcount == nil {
                _playcount = "0"
            }
            return _playcount!
        }
        set {
            _playcount = playcount
        }
    }
    
    var userPlaycount: String {
        mutating get {
            if _userPlaycount == nil {
                _userPlaycount = "0"
            }
            return _userPlaycount!
        }
        set {
            _userPlaycount = userPlaycount
        }
    }
    
    var topTracks: [Track] {
        mutating get {
            if _topTracks == nil {
                _topTracks = [Track]()
            }
            return _topTracks!
        }
        set {
            _topTracks = topTracks
        }
    }
    
    var topAlbums: [Album] {
        mutating get {
            if _topAlbums == nil {
                _topAlbums = [Album]()
            }
            return _topAlbums!
        }
        set {
            _topAlbums = topAlbums
        }
    }
    
    var relatedTags: [String] {
        mutating get {
            if _relatedTags == nil {
                _relatedTags = [String]()
            }
            return _relatedTags!
        }
        set {
            _relatedTags = relatedTags
        }
    }
    
    var biography: String {
        mutating get {
            if _biography == nil {
                _biography = "No biography yet."
            }
            return _biography!
        }
        set {
            _biography = biography
        }
    }
    
    var onTour: String {
        mutating get {
            if _onTour == nil {
                _onTour = "0"
            }
            return _onTour!
        }
        set {
            _onTour = onTour
        }
    }
    
    var similarArtists: [Artist] {
        mutating get {
            if _similarArtists == nil {
                _similarArtists = [Artist]()
            }
            return _similarArtists!
        }
        set {
            _similarArtists = similarArtists
        }
    }
    
    var match: String {        
        mutating get {
            if _match == nil {
                _match = "0"
            }
            return _match!
        }
        set {
            _match = match
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}