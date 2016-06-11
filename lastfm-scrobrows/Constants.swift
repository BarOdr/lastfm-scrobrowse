//
//  Constants.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 05/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import Foundation
import Alamofire


// User credentials constants
let STORED_USER_SECRET_KEY = "userSecretKey"
let STORED_USERNAME = "storedUserName"

// JSON parsing constants

let LASTFM_NAME = "name"
let LASTFM_REALNAME = "realname"
let LASTFM_DURATION = "duration"
let LASTFM_PLAYCOUNT = "playcount"
let LASTM_ARTIST = "artist"
let LASTFM_USER = "user"
let LASTFM_URL = "url"
let LASTFM_IMAGE = "image"
let LASTFM_TEXT = "#text"
let LASTFM_TOPTRACKS = "toptracks"
let LASTFM_TOPALBUMS = "topalbums"
let LASTFM_TOPARTISTS = "topartists"
let LASTFM_TRACK = "track"
let LASTFM_ARTIST = "artist"
let LASTFM_ALBUM = "album"
let LASTFM_STATS = "stats"
let LASTFM_LISTENERS = "listeners"
let LASTFM_USERPLAYCOUNT = "userplaycount"
let LASTFM_SIMILAR = "similar"
let LASTFM_ONTOUR = "ontour"
let LASTFM_REGISTERED = "registered"


// Request string's components constants
let LASTFM_BASE_URL = "https://ws.audioscrobbler.com/2.0/?"
let LASTFM_API_KEY = "c00c40405d802400d6d8d933ae91bfc2"
let LASTFM_SECRET = "fe0b37c94fc1dd374bde905508379fe1"
let LASTFM_GET_MOBILE_SESSION = "auth.getMobileSession"
let GET = Alamofire.Method.GET
let POST = Alamofire.Method.POST

//Typealiases

typealias LastfmDownloadComplete = (objectFromParser: AnyObject) -> Void
typealias UserLoginComplete = (userSecret: String, userName: String) -> Void
typealias CompletionHandler = () -> Void
