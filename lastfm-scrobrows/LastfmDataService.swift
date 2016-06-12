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
    
    deinit {
        print("LastfmDataService is being deinitialized")
    }
    
    /** 
     This method performs a web request. This is a flexible data task, which allows to obtain any kind of data from last.fm to be handled in completion handler.
     
     - parameter type: type of the request: Alamofire.Method (typically .GET or .POST)
     - parameter parser: a function to parse the response data
     - parameter parameters: Dictionary of type Dictionary<String, AnyObject> with all the parameters for the request
     - parameter completion: completion handler of type LastfmDownloadComplete
     
     */
    
    func lastfmDownloadTask(type: Alamofire.Method, parameters: Dictionary<String, AnyObject>, completion: LastfmDownloadComplete) {
        
        Alamofire.request(type, LASTFM_BASE_URL, parameters: parameters).response { (request, response, data, error) in
            
            if error == nil {
                
                if let data = data {
                    let json = JSON(data: data)
                    print(json)
                    completion(objectFromParser: json)
                }

            } else {
                print(error)
            }
        }
    }
    

 // USER parser methods
    
    func userGetTopAlbums(amount: Int, json: JSON) -> [Album] {
        
        var albumsArray = [Album]()
        
        for i in 0...amount - 1 {
            
            var album = Album()
            
            if let name = json[LASTFM_TOPALBUMS][LASTFM_ALBUM][i][LASTFM_NAME].string {
               album.albumName = name
            }
            if let userPlayCount = json[LASTFM_TOPALBUMS][LASTFM_ALBUM][i][LASTFM_PLAYCOUNT].string {
                album.userPlayCount = userPlayCount
            }
            if let albumArtist = json[LASTFM_TOPALBUMS][LASTFM_ALBUM][i][LASTFM_ARTIST][LASTFM_NAME].string {
                var artist = Artist()
                artist.artistName = albumArtist
                album.albumArtist = artist
            }
            if let imageUrl = json[LASTFM_TOPALBUMS][LASTFM_ALBUM][i][LASTFM_IMAGE][3][LASTFM_TEXT].string {
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
            
            if let name = json[LASTFM_TOPARTISTS][LASTM_ARTIST][i][LASTFM_NAME].string {
                artist.setName(name)
                print("name is \(name)")
                print("and saved name is: \(artist.artistName)")
            }
            if let userPlaycount = json[LASTFM_TOPARTISTS][LASTM_ARTIST][i][LASTFM_PLAYCOUNT].string {
                artist.userPlaycount = userPlaycount
                print("Playcount is \(userPlaycount)")
            }
            if let imageUrl = json[LASTFM_TOPARTISTS][LASTM_ARTIST][i][LASTFM_IMAGE][4][LASTFM_TEXT].string {
                artist.artistImgUrl = imageUrl
                print("Image url is \(imageUrl)")
            }
            
            artistsArray.append(artist)
        }
        return artistsArray
    }
    
    func userGetTopTracks(amount: Int, json: JSON) -> [Track] {
        
        var tracksArray = [Track]()
        
        for i in 0...amount {
            
            var track = Track()
            
            if let name = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTFM_NAME].string {
                track.trackName = name
            }
            if let duration = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTFM_DURATION].string {
                track.duration = duration
            }
            if let userPlayCount = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTFM_PLAYCOUNT].string {
                track.userPlayCount = userPlayCount
            }
            if let artistName = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTFM_ARTIST].string {
                let artist = Artist()
                artist.artistName = artistName
                track.artist = artist
            }
            
            tracksArray.append(track)
        }
        
        return tracksArray
    }
    
    func userGetUserInfo(json: JSON) -> LastfmUser {
        
        let user = LastfmUser()
        
        if let name = json[LASTFM_USER][LASTFM_NAME].string {
            user.username = name
        }
        if let realname = json[LASTFM_USER][LASTFM_REALNAME].string {
            user.realName = realname
        }
        if let userImageUrl = json[LASTFM_USER][LASTFM_IMAGE][2][LASTFM_TEXT].string {
            user.userImageUrl = userImageUrl
        }
        if let userPlaycount = json[LASTFM_USER][LASTFM_PLAYCOUNT].int {
            user.playcount = userPlaycount
        }
        if let userRegistrationDate = json[LASTFM_USER][LASTFM_REGISTERED][LASTFM_TEXT].double {
            user.registeredUnixtime = userRegistrationDate
        }

        return user
    }
    
    func userGetRecentTracks(amount: Int, json: JSON) -> [Track] {
        
        var tracks = [Track]()
        
        for i in 0...amount - 1 {
            
            var track = Track()
            
            if let trackName = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTFM_NAME].string {
                track.trackName = trackName
            }
            if let duration = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTFM_DURATION].string {
                track.duration = duration
            }
            if let userPlaycount = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTFM_PLAYCOUNT].string {
                track.userPlayCount = userPlaycount
            }
            if let artistName = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTM_ARTIST][LASTFM_NAME].string {
                let artist = Artist()
                artist.artistName = artistName
                track.artist = artist
            }

            tracks.append(track)
        }
        return tracks
    }
    
    // ARTIST parser methods
    
    func artistGetInfo(json: JSON) -> Artist {
    
        let artist = Artist()
        
        if let artistName = json[LASTM_ARTIST][LASTFM_NAME].string {
            artist.artistName = artistName
        }
        if let imageUrl = json[LASTM_ARTIST][LASTFM_IMAGE][3][LASTFM_TEXT].string {
            artist.artistImgUrl = imageUrl
        }
        if let onTour = json[LASTM_ARTIST][LASTFM_ONTOUR].string {
            artist.onTour = onTour
        }
        if let listenerCount = json[LASTM_ARTIST][LASTFM_STATS][LASTFM_LISTENERS].string {
            artist.listenersCount = listenerCount
        }
        if let playcount = json[LASTM_ARTIST][LASTFM_STATS][LASTFM_PLAYCOUNT].string {
            artist.playcount = playcount
        }
        if let userPlaycount = json[LASTM_ARTIST][LASTFM_STATS][LASTFM_USERPLAYCOUNT].string {
            artist.userPlaycount = userPlaycount
        }
        
        var similarArtists = [Artist]()
        
        for i in 0...2 {
            let artist = Artist()
            if let similarName = json[LASTFM_ARTIST][LASTFM_SIMILAR][LASTFM_ARTIST][i][LASTFM_NAME].string {
                artist.artistName = similarName
            }
                if let similarImageUrl = json[LASTFM_ARTIST][LASTFM_SIMILAR][LASTFM_ARTIST][LASTFM_IMAGE][2][LASTFM_TEXT].string {
                        artist.artistImgUrl = similarImageUrl
            }
            similarArtists.append(artist)
        }
        artist.similarArtists = similarArtists
        return artist
    }
    
    func artistGetTopTracks(amount: Int, json: JSON) -> [Track] {
        
        var tracks = [Track]()
        
        for i in 0...amount - 1 {
            
            var track = Track()
            
            if let trackName = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTFM_NAME].string {
                track.trackName = trackName
            }
            if let trackPlaycount = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTFM_PLAYCOUNT].string {
                track.overallPlayCount = trackPlaycount
            }
            if let listenersCount = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTFM_LISTENERS].string {
                track.listenerCount = listenersCount
            }
            if let trackArtist = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTM_ARTIST][LASTFM_NAME].string {
                let artist = Artist()
                artist.artistName = trackArtist
                track.artist = artist
            }
            
            tracks.append(track)
        }
        return tracks
    }

    func artistGetTopAlbums(amount: Int, json: JSON) -> [Album] {
        
        var albums = [Album]()
        
        for i in 0...amount - 1 {
            
            var album = Album()
            
            if let albumName = json[LASTFM_TOPALBUMS][LASTFM_ALBUM][i][LASTFM_NAME].string {
                album.albumName = albumName
            }
            if let playcount = json[LASTFM_TOPALBUMS][LASTFM_ALBUM][i][LASTFM_PLAYCOUNT].string {
                album.overallPlayCount = playcount
            }
            if let artist =  json[LASTFM_TOPALBUMS][LASTFM_ALBUM][i][LASTM_ARTIST][LASTFM_NAME].string {
                let albumArtist = Artist()
                albumArtist.artistName = artist
                album.albumArtist = albumArtist
            }
            if let albumCoverUrl = json[LASTFM_TOPALBUMS][LASTFM_ALBUM][i][LASTFM_IMAGE][2][LASTFM_TEXT].string {
                album.coverUrl = albumCoverUrl
            }
            
            albums.append(album)
        }
        return albums
    }
    
    func artistGetSimilarArtists(amount: Int, json: JSON) -> [Artist] {
        
        var artists = [Artist]()
        
        for i in 0...amount - 1 {
            
            let artist = Artist()
            
            if let artistName = json[LASTFM_SIMILARARTISTS][LASTM_ARTIST][i][LASTFM_NAME].string {
                artist.artistName = artistName
            }
            if let imageUrl = json[LASTFM_SIMILARARTISTS][LASTM_ARTIST][i][LASTFM_IMAGE][3][LASTFM_TEXT].string  {
                artist.artistImgUrl = imageUrl
            }
            if let match = json[LASTFM_SIMILARARTISTS][LASTM_ARTIST][i][LASTFM_MATCH].string {
                artist.match = match
            }
            
            artists.append(artist)
        }
        
        return artists
    }  
}




































