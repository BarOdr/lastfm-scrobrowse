//
//  RequestParametersDictionaries.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 12/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import Foundation

// Request methods

let PARAM_USER_GET_TOP_ALBUMS = "user.getTopAlbums"
let PARAM_USER_GET_TOP_TRACKS = "user.getTopTracks"
let PARAM_USER_GET_TOP_ARTISTS = "user.getTopArtists"
let PARAM_USER_GET_LOVED_TRACKS = "user.getLovedTracks"
let PARAM_USER_GET_RECENT_TRACKS = "user.getRecentTracks"

let PARAM_FORMAT = "format"
let PARAM_JSON = "json"
let PARAM_METHOD = "method"
let PARAM_USER = "user"
let PARAM_PERIOD = "period"
let PARAM_OVERALL = "overall"
let PARAM_7DAY = "7day"
let PARAM_1MONTH = "1month"
let PARAM_3MONTH = "3month"
let PARAM_6MONTH = "6month"
let PARAM_12MONTH = "12month"
let PARAM_APIKEY = "api_key"
let PARAM_SECRET = "secret"

let PARAM_DICT_USER_GETTOPARTISTS = [PARAM_USER: "Fez1979", PARAM_PERIOD: PARAM_OVERALL, PARAM_APIKEY: LASTFM_API_KEY, PARAM_METHOD: PARAM_USER_GET_TOP_ARTISTS, PARAM_FORMAT: PARAM_JSON]