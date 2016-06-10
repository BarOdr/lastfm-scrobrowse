//
//  LastfmDataService.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 08/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LastfmDataService: NSObject {
    
    
    /** 
     This method performs a web request. This is a flexible data task, which allows to obtain any kind of data from last.fm to be handled in completion handler.
     
     - parameter type: type of the request: Alamofire.Method (typically .GET or .POST)
     - parameter parser: a function to parse the response data
     - parameter parameters: Dictionary of type Dictionary<String, AnyObject> with all the parameters for the request
     - parameter completion: completion handler of type LastfmDownloadComplete
     
     */
    
    //ADD parsing function as a parameter!
    func lastfmDownloadTask(type: Alamofire.Method, parameters: Dictionary<String, AnyObject>, completion: LastfmDownloadComplete ) {
        
        Alamofire.request(type, LASTFM_BASE_URL, parameters: parameters).response { (request, response, data, error) in
            
            if error == nil {
                
                if let data = data {
                    let json = JSON(data)
                    print(json)
                    // parsing function taking data as parameter
                }

            } else {
                print(error)
            }
        }
    }
    
    /**
     This method retrieves the current logged user (if exists) and returns an optional LastfmUser object or nil
     - returns: LastfmUser?
     */
    
    func getCurrentUser() -> LastfmUser? {
        let username = NSUserDefaults.standardUserDefaults().valueForKey(STORED_USERNAME) as? String
        let secret = NSUserDefaults.standardUserDefaults().valueForKey(STORED_USER_SECRET_KEY) as? String
        if username != nil && secret != nil {
            
            let user = LastfmUser()
            user.username = username!
            user.secret = secret!
            return user
        } else {
            return nil
        }
        
    }

 // USER parser methods
    
    func userGetTopAlbums(amount: Int, json: JSON) -> [Album] {
        
        var albumsArray = [Album]()
        
        for i in 0...amount - 1 {
            
            let album = Album()
            if let name = json["topalbums"]["album"][i]["name"].string {
                album.albumName = name
            }
            if let userPlayCount = json["topalbums"]["album"][i]["playcount"].int {
                album.userPlayCount = userPlayCount
            }
            if let albumArtist = json["topalbums"]["album"][i]["artist"]["name"].string {
                album.albumArtist = albumArtist
            }
            if let imageUrl = json["topalbums"]["album"][i]["image"][3]["#text"].string {
                album.coverUrl = imageUrl
            }
            
            albumsArray.append(album)
            
            }
        
        return albumsArray
    }
    
    
    
    func userGetTopArtists(amount: Int, json: JSON) -> [Artist] {
        
        var artistsArray = [Artist]()
        
        for i in 0...amount - 1 {
            
            let artist = Artist()
            
            if let name = json["topartists"]["artist"][i]["name"].string {
                artist.artistName = name
            }
            if let userPlaycount = json["topartists"]["artist"][i]["playcount"].int {
                artist.userPlaycount = userPlaycount
            }
            if let imageUrl = json["topartists"]["artist"][i]["image"][3]["#text"].string {
                artist.artistImgUrl = imageUrl
            }
            
            artistsArray.append(artist)
        }
        return artistsArray
    }
    
    func userGetUserInfo(json: JSON) -> LastfmUser {
        
        let user = LastfmUser()
        
        if let name = json["user"]["name"].string {
            user.username = name
        }
        if let realname = json["user"]["realname"].string {
            user.realName = realname
        }
        if let userImageUrl = json["user"]["image"][2]["#text"].string {
            user.userImageUrl = userImageUrl
        }
        if let userPlaycount = json["user"]["playcount"].int {
            user.playcount = userPlaycount
        }
        if let userRegistrationDate = json["user"]["registered"]["#text"].double {
            user.registeredUnixtime = userRegistrationDate
        }

        return user
    }
    
    func userGetRecentTracks(amount: Int, json: JSON) -> [Track] {
        
        var tracks = [Track]()
        
        for i in 0...amount - 1 {
            
            let track = Track()
            
            if let trackName = json["toptracks"]["track"][i]["name"].string {
                track.trackName = trackName
            }
            if let duration = json["toptracks"]["track"][i]["duration"].string {
                track.duration = duration
            }
            if let userPlaycount = json["toptracks"]["track"][i]["playcount"].string {
                track.userPlayCount = userPlaycount
            }
            if let artistName = json["toptracks"]["track"][i]["artist"]["name"].string {
                let artist = Artist()
                artist.artistName = artistName
                track.artist = artist
            }

            tracks.append(track)
        }
        return tracks
    }
    
    // ARTIST parser methods
    
//    func artistGetInfo(artist: Artist?, json: JSON) -> Artist {
//        
//        
//        if artist == nil {
//            
//        }
//        let tags = ""
//        let artistName = json["artist"]["name"].string
//        let imageUrl = json["artist"]["image"][3]["#text"].string
//        let playcount = json["artist"]["stats"]["playcount"].string
//        let listeners = json["artist"]["stats"]["listeners"].string
//        
//        for i in 0...4 {
//            let tag = json["artist"]["tags"]["tag"][i]["name"].string
//            tags.stringByAppendingString(" \(tag)")
//        }
//    }
}




































