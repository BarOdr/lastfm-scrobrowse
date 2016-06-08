//
//  Constants.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 05/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import Foundation

// User credentials constants
let STORED_USER_SECRET_KEY = "userSecretKey"
let STORED_USERNAME = "storedUserName"


// Request string's components constants
let LASTFM_BASE_URL = "http://ws.audioscrobbler.com/2.0/"
let LASTFM_API_KEY = "c00c40405d802400d6d8d933ae91bfc2"
let LASTFM_SECRET = "fe0b37c94fc1dd374bde905508379fe1"
let LASTFM_GET_MOBILE_SESSION = "auth.getMobileSession"

//Typealiases

typealias DownloadComplete = (userSecret: String, userName: String) -> Void
typealias CompletionHandler = () -> ()
