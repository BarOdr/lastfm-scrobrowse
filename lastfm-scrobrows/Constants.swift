//
//  Constants.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 05/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


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
let LASTFM_CONTENT = "content"
let LASTFM_STATS = "stats"
let LASTFM_BIO = "bio"
let LASTFM_LISTENERS = "listeners"
let LASTFM_USERPLAYCOUNT = "userplaycount"
let LASTFM_SIMILAR = "similar"
let LASTFM_SIMILARARTISTS = "similarartists"
let LASTFM_ONTOUR = "ontour"
let LASTFM_REGISTERED = "registered"
let LASTFM_MATCH = "match"


// Request string's components constants
let LASTFM_GET_MOBILE_SESSION = "auth.getMobileSession"
let GET = Alamofire.Method.GET
let POST = Alamofire.Method.POST

//Typealiases

typealias LastfmDownloadComplete = (json: JSON) -> Void
typealias ImagesDownloaded = (artists: [Artist]) -> Void
typealias UserLoginComplete = (userSecret: String, userName: String) -> Void
typealias ImageDownloadComplete = (img: UIImage) -> Void

// View controllers' identifiers

let VIEWCONTR_ARTIST_DETAILS_VC = "ArtistDetailsVC"
let VIEWCONTR_ARTIST_GENERAL_INFO_VC = "ArtistGeneralInfo"
let VIEWCONTR_ARTIST_TOP_SONGS_VC = "ArtistTopSongs"
let VIEWCONTR_ARTIST_TOP_ALBUMS_VC = "ArtistTopAlbums"
let VIEWCONTR_ARTIST_SIMILAR_VC = "ArtistSimilar"

