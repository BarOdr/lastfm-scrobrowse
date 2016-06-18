//
//  Artist.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 08/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import Foundation
import UIKit

class Artist {
    
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
    private var _image: UIImage?
    
    var artistName: String {
        get {
            if _artistName == nil {
                _artistName = ""
            }
            return _artistName!
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
    
    var listenersCount: String {
        get {
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
        get {
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
        get {
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
        get {
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
        get {
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
        get {
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
    
    var onTour: String {
        get {
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
        get {
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
        get {
            if _match == nil {
                _match = "0"
            }
            return _match!
        }
        set {
            _match = match
        }
    }
    
    var image: UIImage {
        get {
//            self.setImage(UIImage(named: "selah1")!)
            return _image!
        }
    }
    
    func setName(name: String) {
        _artistName = name
    }
    
    func setImgUrl(url: String) {
        _artistImgUrl = url
    }
    
    func setListenersCount(count: String) {
        _listenersCount = count
    }
    
    func setPlaycount(count: String) {
        _playcount = count
    }
    
    func setUserPlaycount(count: String) {
        _userPlaycount = count
    }
    
    func setTopTracks(tracks: [Track]) {
        _topTracks = tracks
    }
    
    func setTopAlbums(albums: [Album]) {
        _topAlbums = albums
    }
    
    func setSimilarArtists(artists: [Artist]) {
        _similarArtists = artists
    }
    
    func setTags(tags: [String]) {
        _relatedTags = tags
    }
    
    func setBiography(bio: String) {
        _biography = bio
    }
    
    func setOnTour(onTour: String) {
        _onTour = onTour
    }
    
    func setMatch(match: String) {
        _match = match
    }
    
    func setImage(img: UIImage) {
        _image = img
    }
  
    
}