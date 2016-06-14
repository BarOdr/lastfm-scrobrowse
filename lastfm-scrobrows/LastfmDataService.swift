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
    
    func lastfmDownloadTask(type: Alamofire.Method, parameters: Dictionary<String, String>, completion: LastfmDownloadComplete) {
        
        Alamofire.request(type, LASTFM_BASE_URL, parameters: parameters).response { (request, response, data, error) in
            
            if error == nil {
                
                if let data = data {
                    let json = JSON(data: data)
                    completion(json: json)
                }

            } else {
                print(error)
            }
        }
    }
    
    
    // Image downloader
    
    func imagesDownloader(artists: [Artist], complete: ImagesDownloaded) {
        
        for artist in artists {
            
            let imgUrl = artist.artistImgUrl
            Alamofire.request(.GET, imgUrl).responseImage { (response) in
                
                if let image = response.result.value {
                    artist._artistImg = image
                    print("Image for \(artist.artistName) downloaded: \(image)")
                }
            }
        }
        complete(artists: artists)
    }
    
    func imageFromData(data: NSData) -> UIImage {
        print(data)
        let image = UIImage(data: data)
        return image!
    }

 // USER parser methods
    
    func userGetTopAlbums(amount: Int, json: JSON) -> [Album] {
        
        var albumsArray = [Album]()
        
        for i in 0...amount - 1 {
            
            let album = Album()
            
            if let name = json[LASTFM_TOPALBUMS][LASTFM_ALBUM][i][LASTFM_NAME].string {
               album.setName(name)
            }
            if let userPlayCount = json[LASTFM_TOPALBUMS][LASTFM_ALBUM][i][LASTFM_PLAYCOUNT].string {
                album.setUserPlaycount(userPlayCount)
            }
            if let albumArtist = json[LASTFM_TOPALBUMS][LASTFM_ALBUM][i][LASTFM_ARTIST][LASTFM_NAME].string {
                let artist = Artist()
                artist.setName(albumArtist)
                album.albumArtist = artist
            }
            if let imageUrl = json[LASTFM_TOPALBUMS][LASTFM_ALBUM][i][LASTFM_IMAGE][3][LASTFM_TEXT].string {
                album.setCoverUrl(imageUrl)
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
            }
            if let userPlaycount = json[LASTFM_TOPARTISTS][LASTM_ARTIST][i][LASTFM_PLAYCOUNT].string {
                artist.setUserPlaycount(userPlaycount)
            }
            if let imageUrl = json[LASTFM_TOPARTISTS][LASTM_ARTIST][i][LASTFM_IMAGE][4][LASTFM_TEXT].string {
                artist.setImgUrl(imageUrl)
            }
            
            artistsArray.append(artist)
        }
        return artistsArray
    }
    
    func userGetTopTracks(amount: Int, json: JSON) -> [Track] {
        
        var tracksArray = [Track]()
        
        for i in 0...amount {
            
            let track = Track()
            
            if let name = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTFM_NAME].string {
                track.setTrackName(name)
            }
            if let duration = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTFM_DURATION].string {
                track.setDuration(duration)
            }
            if let userPlayCount = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTFM_PLAYCOUNT].string {
                track.setUserPlayCount(userPlayCount)
            }
            if let artistName = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTFM_ARTIST].string {
                let artist = Artist()
                artist.setName(artistName)
                track.setArtist(artist)
            }
            
            tracksArray.append(track)
        }
        
        return tracksArray
    }
    
    func userGetUserInfo(json: JSON) -> LastfmUser {
        
        let user = LastfmUser()
        
        if let name = json[LASTFM_USER][LASTFM_NAME].string {
            user.setUsername(name)
        }
        if let realname = json[LASTFM_USER][LASTFM_REALNAME].string {
            user.setRealName(realname)
        }
        if let userImageUrl = json[LASTFM_USER][LASTFM_IMAGE][2][LASTFM_TEXT].string {
            user.setImageUrl(userImageUrl)
        }
        if let userPlaycount = json[LASTFM_USER][LASTFM_PLAYCOUNT].string {
            user.setPlaycount(userPlaycount)
        }
        if let userRegistrationDate = json[LASTFM_USER][LASTFM_REGISTERED][LASTFM_TEXT].double {
            user.setRegisterUnixtime(userRegistrationDate)
        }

        return user
    }
    
    func userGetRecentTracks(amount: Int, json: JSON) -> [Track] {
        
        var tracks = [Track]()
        
        for i in 0...amount - 1 {
            
            let track = Track()
            
            if let trackName = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTFM_NAME].string {
                track.setTrackName(trackName)
            }
            if let duration = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTFM_DURATION].string {
                track.setDuration(duration)
            }
            if let userPlaycount = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTFM_PLAYCOUNT].string {
                track.setUserPlayCount(userPlaycount)
            }
            if let artistName = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTM_ARTIST][LASTFM_NAME].string {
                let artist = Artist()
                artist.setName(artistName)
                track.setArtist(artist)
            }

            tracks.append(track)
        }
        return tracks
    }
    
    // ARTIST parser methods
    
    func artistGetInfo(artist: Artist, json: JSON) -> Artist {
        
        if let artistName = json[LASTM_ARTIST][LASTFM_NAME].string {
            artist.setName(artistName)
        }
        if let imageUrl = json[LASTM_ARTIST][LASTFM_IMAGE][3][LASTFM_TEXT].string {
            artist.setImgUrl(imageUrl)
        }
        if let onTour = json[LASTM_ARTIST][LASTFM_ONTOUR].string {
            artist.setOnTour(onTour)
        }
        if let listenerCount = json[LASTM_ARTIST][LASTFM_STATS][LASTFM_LISTENERS].string {
            artist.setListenersCount(listenerCount)
        }
        if let playcount = json[LASTM_ARTIST][LASTFM_STATS][LASTFM_PLAYCOUNT].string {
            artist.setPlaycount(playcount)
        }
        if let userPlaycount = json[LASTM_ARTIST][LASTFM_STATS][LASTFM_USERPLAYCOUNT].string {
            artist.setUserPlaycount(userPlaycount)
        }
        if let bio = json[LASTFM_ARTIST][LASTFM_BIO][LASTFM_CONTENT].string {
            artist.setBiography(bio)
        }
        var similarArtists = [Artist]()
        
        for i in 0...2 {
            let artist = Artist()
            if let similarName = json[LASTFM_ARTIST][LASTFM_SIMILAR][LASTFM_ARTIST][i][LASTFM_NAME].string {
                artist.setName(similarName)
            }
                if let similarImageUrl = json[LASTFM_ARTIST][LASTFM_SIMILAR][LASTFM_ARTIST][LASTFM_IMAGE][2][LASTFM_TEXT].string {
                        artist.setImgUrl(similarImageUrl)
            }
            similarArtists.append(artist)
        }
        artist.setSimilarArtists(similarArtists)
        return artist
    }
    
    func artistGetTopTracks(amount: Int, json: JSON) -> [Track] {
        
        var tracks = [Track]()
        
        for i in 0...amount - 1 {
            
            let track = Track()
            
            if let trackName = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTFM_NAME].string {
                track.setTrackName(trackName)
            }
            if let trackPlaycount = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTFM_PLAYCOUNT].string {
                track.setOverallPlayCount(trackPlaycount)
            }
            if let listenersCount = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTFM_LISTENERS].string {
                track.setListenersCount(listenersCount)
            }
            if let trackArtist = json[LASTFM_TOPTRACKS][LASTFM_TRACK][i][LASTM_ARTIST][LASTFM_NAME].string {
                let artist = Artist()
                artist.setName(trackArtist)
                track.setArtist(artist)
            }
            
            tracks.append(track)
        }
        return tracks
    }

    func artistGetTopAlbums(amount: Int, json: JSON) -> [Album] {
        
        var albums = [Album]()
        
        for i in 0...amount - 1 {
            
            let album = Album()
            
            if let albumName = json[LASTFM_TOPALBUMS][LASTFM_ALBUM][i][LASTFM_NAME].string {
                album.setName(albumName)
            }
            if let playcount = json[LASTFM_TOPALBUMS][LASTFM_ALBUM][i][LASTFM_PLAYCOUNT].string {
                album.setOverallPlaycount(playcount)
            }
            if let artist =  json[LASTFM_TOPALBUMS][LASTFM_ALBUM][i][LASTM_ARTIST][LASTFM_NAME].string {
                let albumArtist = Artist()
                albumArtist.setName(artist)
                album.setAlbumArtist(albumArtist)
            }
            if let albumCoverUrl = json[LASTFM_TOPALBUMS][LASTFM_ALBUM][i][LASTFM_IMAGE][2][LASTFM_TEXT].string {
                album.setCoverUrl(albumCoverUrl)
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
                artist.setName(artistName)
            }
            if let imageUrl = json[LASTFM_SIMILARARTISTS][LASTM_ARTIST][i][LASTFM_IMAGE][3][LASTFM_TEXT].string  {
                artist.setImgUrl(imageUrl)
            }
            if let match = json[LASTFM_SIMILARARTISTS][LASTM_ARTIST][i][LASTFM_MATCH].string {
                artist.setMatch(match)
            }
            
            artists.append(artist)
        }
        
        return artists
    }
    
    func generateParametersForUserMethods(method: String, apiKey: String, user: String, period: String, limit: String, page: String) -> Dictionary<String, String> {
        let parameters: Dictionary<String, String>
        parameters = [KEY_METHOD: method, KEY_APIKEY: apiKey, KEY_USER: user, KEY_PERIOD: period, KEY_PAGE: page, KEY_FORMAT: PARAM_JSON]
        return parameters
    }
    
    func generateParametersForAlbumOrTrackMethods(method: String, apiKey: String, username: String, artist: String, albumOrTrack: String) -> Dictionary<String, String> {
        
        let parameters: Dictionary<String, String>
        var albumOrTrack = ""
        if method == PARAM_TRACK_GET_INFO {
            albumOrTrack = KEY_TRACK
        } else {
            albumOrTrack = KEY_ALBUM
        }
        parameters = [KEY_METHOD: method, KEY_APIKEY: apiKey, KEY_USERNAME: username, KEY_ARTIST: artist, albumOrTrack: albumOrTrack, KEY_FORMAT: PARAM_JSON]
        return parameters
    }
    
    func generateParametersForArtistMethods(method: String, apiKey: String, artist: String, username: String) -> Dictionary<String, String> {
        let parameters: Dictionary<String, String>
        parameters = [KEY_METHOD: method, KEY_APIKEY: apiKey, KEY_ARTIST: artist, KEY_USERNAME: username, KEY_FORMAT: PARAM_JSON]
        return parameters
    }
}




































