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
            let user = LastfmUser(name: username!, secret: secret!)
            return user
        } else {
            return nil
        }
        
    }

 // USER parser functions
    
    func userGetTopAlbums(amount: Int, json: JSON) -> [Album] {
        
        var albumsArray = [Album]()
        
        for i in 0...amount - 1 {
            
            let name = json["topalbums"]["album"][i]["name"].string
            let userPlayCount = json["topalbums"]["album"][i]["playcount"].int
            let albumArtist = json["topalbums"]["album"][i]["artist"]["name"].string
            let imageUrl = json["topalbums"]["album"][i]["image"][3]["#text"].string
            
            let album = Album(name: name!, userPlaycount: userPlayCount!, albumArtist: albumArtist!, imageUrl: imageUrl!)
            albumsArray.append(album)
            }
        
        return albumsArray
    }
    
    func userGetTopArtists(amount: Int, json: JSON) -> [Artist] {
        
        var artistsArray = [Artist]()
        
        for i in 0...amount - 1 {
            
            let name = json["topartists"]["artist"][i]["name"].string
            let userPlaycount = json["topartists"]["artist"][i]["playcount"].int
            let imageUrl = json["topartists"]["artist"][i]["image"][3]["#text"].string
            
            let artist = Artist(name: name!, userPlaycount: userPlaycount!, imageUrl: imageUrl!)
            artistsArray.append(artist)
        }
        return artistsArray
    }
    
    func userGetUserInfo(json: JSON) -> LastfmUser {
        
        let name = json["user"]["name"].string
        let realname = json["user"]["realname"].string
        let userImageUrl = json["user"]["image"][2]["#text"].string
        let userPlaycount = json["user"]["playcount"].int
        let userRegistrationDate = json["user"]["registered"]["#text"].double
        
        let user = LastfmUser(name: name!, realname: realname!, userImageUrl: userImageUrl!, userPlaycount: userPlaycount!, userRegistrationDate: userRegistrationDate!)
        
        return user
    }
    
    func userGetRecentTracks(amount: Int, json: JSON) -> [Track] {
        
        var tracks = [Track]()
        
        for i in 0...amount - 1 {
            let trackName = json["toptracks"]["track"][i]["name"].string
            let duration = json["toptracks"]["track"][i]["duration"].string
            let userPlaycount = json["toptracks"]["track"][i]["playcount"].string
            let artistName = json["toptracks"]["track"][i]["artist"]["name"].string
            let track = Track(trackname: trackName!, duration: duration!, userPlaycount: userPlaycount!, artistName: Artist(name: artistName!))
            
            tracks.append(track)
            
        }
        
        return tracks
    }
    
    
    
}




































