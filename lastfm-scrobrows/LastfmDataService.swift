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
    
    
    
    /**
     This method iterates through an Artists array and downloads images for them.
     
     - if there is a cached image for the given url, it is set as the artist's image
     - if there isn't a cached image for the given url, the image is downloaded, set as the artist's image, and saved in cache
     
     - parameter artists: [Artist] An array of artists
     - complete: (artists: [Artist]) -> Void. A new, updated with artist images, array, may be used in the completion handler.
     
     */
    
    func imagesDownloader(artists: [Artist], complete: ImagesDownloaded) {
        
        for artist in artists {
            
            let cachedImage = CacheService.imageCache.objectForKey(artist.artistImgUrl) as? UIImage
            
            if cachedImage == nil {
                imageAlamofireRequest(artist, completion: { image in
                    artist.setImage(image)
                    print("\(artist.artistName) image downloaded and saved to cache")
                    CacheService.imageCache.setObject(image, forKey: artist.artistImgUrl)
                })
            } else {
                artist.setImage(cachedImage!)
                print("\(artist.artistName) image set from cache")
            }
        }
        
        complete(artists: artists)
    }
    
    
    /**
     This method performs an Alamofire request to fetch an image from an url. Should the request fail, the method will retry, 3 times in total. Should the request fail three times, a default image will be provided, which will NOT be saved to imageCache.
     
     - parameter artist: An Artist object
     - parameter completion: (img: UIImage) -> Void
     
     */
    
    func imageAlamofireRequest(artist: Artist, completion: ImageDownloadComplete) {
        let url = artist.artistImgUrl
        
        Alamofire.request(.GET, url).responseImage { (response) in
            switch response.result {
            case .Success(let img):
                CacheService.imageCache.setObject(img, forKey: url)
                completion(img: img)
                
            case .Failure(let error):
                print("Image download for \(artist.artistName) failed. Error: \(error)")
                print("Image download for \(artist.artistName): retry")
                self.imageAlamofireRequest(artist, completion: { img in
                    completion(img: img)
                })
                
            }
        }
    }
    
    /**
     This method creates an array of artist image urls.
     
     - parameter artists: [Artist] Array of artist objects
     
     - returns: [String] An array of artist image urls.
     */
    
    func urlsDictionaryFromArtistsArray(artists: [Artist]) -> [String] {
        
        var urlsDictionary = [String]()
        for artist in artists {
            urlsDictionary.append(artist.artistImgUrl)
        }
        return urlsDictionary
    }
    
    /**
     This method creates an UIImage from NSData.
     
     - parameter data: NSData to fetch the image from.
     - returns: An UIImage from the data, or an empty image if an image can not be obtained from the data.
     
     */
    
    func imageFromData(data: NSData) -> UIImage {
        
        if let image = UIImage(data: data) {
            return image
        } else {
            return UIImage()
        }
    }
    
    
    /**
     Use this method to parse data received from an user.getTopAlbums request to Last.fm API.
     This method sets the following properties for the final Album objects:
     
     - albumName
     - userPlaycount
     - albumArtist (provides value for the artistName property of the artist)
     - coverImageUrl
     
     - parameter amount: (Int) Amount of top albums to be appended to similar artists array
     - parameter json: (JSON) JSON object to parse data from.
     
     - returns: [Album] An array of Album objects.
     */
    
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
    
    /**
     Use this method to parse data received from an user.getTopArtists request to Last.fm API.
     This method sets the following properties for the final Artist objects:
     
     - artistName
     - userPlaycount
     - imageUrl
     
     - parameter amount: (Int) Amount of top artists to be appended to similar artists array
     - parameter json: (JSON) JSON object to parse data from.
     
     - returns: [Artist] An array of Artist objects.
     */
    
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
    
    /**
     Use this method to parse data received from an user.getRecentTracks request to Last.fm API.
     This method sets the following properties for the final Track objects:
     
     - trackName
     - duration
     - userPlaycount
     - trackArtist (provides value for artistName property)
     
     - parameter amount: (Int) Amount of top tracks to be appended to the tracks array
     - parameter json: (JSON) JSON object to parse data from.
     
     - returns: [Track] An array of Track objects.
     */
    
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
    
    /**
     Use this method to parse data received from an user.getInfo request to Last.fm API.
     This method sets the following properties for the final Track objects:
     
     - userName
     - realName
     - userImageUrl
     - userPlaycount
     - registrationDate
     
     - parameter json: (JSON) JSON object to parse data from.
     
     - returns: A LastfmUser object with the values provided for the above properties.
     */
    
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
    
    /**
     Use this method to parse data received from an user.getRecentTracks request to Last.fm API.
     This method sets the following properties for the final Track objects:
     
     - trackName
     - duration
     - userPlaycount
     - trackArtist (provides value for artistName property)
     
     - parameter amount: (Int) Amount of recent tracks to be appended to track array
     - parameter json: (JSON) JSON object to parse data from.
     
     - returns: [Track] An array of Track objects.
     */
    
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
    
    /**
     Use this method to parse data received from an artist.getInfo request to Last.fm API.
     This method sets the following properties for the final Artist objects:
     
     - artistName
     - imageUrl
     - onTour
     - listenersCount
     - playcount
     - userPlaycount
     - biography
     - similarArtists (provides values for artistName and artistImgUrl properties)
     
     - parameter artist: (Artist) An object of type Artist to fetch the info for.
     - parameter json: (JSON) JSON object to parse data from.
     
     - returns: An Artist object with values provided for the above properties.
     
     */
    
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
    
    /**
     Use this method to parse data received from an artist.getTopTracks request to Last.fm API.
     This method sets the following properties for the final Track objects:
     
     - trackName
     - overallPlaycount
     - listenersCount
     - trackArtist (provides value for artistName property)
     
     - parameter amount: (Int) Amount of top tracks to be appended to the tracks array
     - parameter json: (JSON) JSON object to parse data from.
     
     - returns: [Track] An array of Track objects.
     */
    
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
    
    
    /**
     
     Use this method to parse data received from an artist.getTopAlbums request to Last.fm API.
     This method sets the following properties for the final Album objects:
     
     - albumName
     - overallPlaycount
     - artist (provides value for artistName property of the Artist)
     - albumArtist
     - albumCoverUrl
     
     - parameter amount: (Int) Amount of top albums to be appended to the albums array
     - parameter json: (JSON) JSON object to parse data from.
     
     - returns: [Album] An array of Album objects.
     
     */
    
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
    
    /**
     
     Use this method to parse data received from an artist.getSimilarArtists request to Last.fm API.
     This method sets the following properties for the final Artist objects:
     
     - artistName
     - imageUrl
     - match
     
     - parameter amount: (Int) Amount of similar artists to be appended to similar artists array
     - parameter json: (JSON) JSON object to parse data from.
     
     - returns: [Artist] An array of Artist objects.
     
     */
    
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
    
    /**
     This method generates request parameters for User web request methods to Last.fm API.
     
     - parameter method: (String) This is a method parameter for Last.fm API request, e.g user.getInfo. The method names are included in constants, use them in order to avoid spelling mistakes.
     - parameter apiKey: (String) Api key for the application
     - parameter username: (String) Last.fm user name. This parameter will make Last.fm API send back some additional information about artist, usually playback count of the track or album by a specific user. Refer to Last.fm API documentation for more information. If the name provided is incorrect, the Last.fm API will simply omit the additional info in the response
     
     - returns: Dictionary<String, String> containing keys and values of a request to Last.fm API. Use this dictionary as the 'parameters' parameter of an Alamofire request.
     */
    
    func generateParametersForUserMethods(method: String, apiKey: String, user: String, period: String, limit: String, page: String) -> Dictionary<String, String> {
        let parameters: Dictionary<String, String>
        parameters = [KEY_METHOD: method, KEY_APIKEY: apiKey, KEY_USER: user, KEY_PERIOD: period, KEY_PAGE: page, KEY_FORMAT: PARAM_JSON]
        return parameters
    }
    
    /**
     This method generates request parameters for Album or Track web request methods to Last.fm API.
     
     - parameter method: (String) This is a method parameter for Last.fm API request. Use track.getInfo or album.getInfo. The method names are included in constants, use them in order to avoid spelling mistakes.
     - parameter apiKey: (String) Api key for the application
     - parameter artist: (Artist) An artist object. This is required, because in order to fetch track or album info, you must also provide the artist's name as the request's parameter
     - parameter username: (String) Last.fm user name. This parameter will make Last.fm API send back some additional information about artist, usually playback count of the track or album by a specific user. Refer to Last.fm API documentation for more information. If the name provided is incorrect, the Last.fm API will simply omit the additional info in the response
     
     - returns: Dictionary<String, String> containing keys and values of a request to Last.fm API. Use this dictionary as the 'parameters' parameter of an Alamofire request.
     */
    
    func generateParametersForAlbumOrTrackMethods(method: String, apiKey: String, username: String, artist: Artist, albumOrTrack: String) -> Dictionary<String, String> {
        
        let parameters: Dictionary<String, String>
        var albumOrTrack = ""
        if method == PARAM_TRACK_GET_INFO {
            albumOrTrack = KEY_TRACK
        } else {
            albumOrTrack = KEY_ALBUM
        }
        parameters = [KEY_METHOD: method, KEY_APIKEY: apiKey, KEY_USERNAME: username, KEY_ARTIST: artist.artistName, albumOrTrack: albumOrTrack, KEY_FORMAT: PARAM_JSON]
        return parameters
    }
    
    /**
     This method generates request parameters for Artist web request methods to Last.fm API.
     
     - parameter method: (String) This is a method parameter for Last.fm API request, e.g. artist.getInfo. The method names are included in constants, use them in order to avoid spelling mistakes.
     - parameter apiKey: (String) Api key for the application
     - parameter artist: (Artist) An artist object, for which the additional information will be requested from Last.fm API
     - parameter username: (String) Last.fm user name. This parameter will make Last.fm API send back some additional information about artist, usually playback count of the artist by a specific user. Refer to Last.fm API documentation for more information
     
     - returns: Dictionary<String, String> containing keys and values of a request to Last.fm API. Use this dictionary as the 'parameters' parameter of an Alamofire request.
     */
    
    
    func generateParametersForArtistMethods(method: String, apiKey: String, artist: Artist, username: String) -> Dictionary<String, String> {
        let parameters: Dictionary<String, String>
        parameters = [KEY_METHOD: method, KEY_APIKEY: apiKey, KEY_ARTIST: artist.artistName, KEY_USERNAME: username, KEY_FORMAT: PARAM_JSON]
        return parameters
    }
}




































