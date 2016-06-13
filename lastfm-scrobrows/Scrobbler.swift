//
//  Scrobbler.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 13/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit
import MediaPlayer

class Scrobbler: NSObject {

    let songsQuery = MPMediaQuery.songsQuery()

    func scrobble(since: NSDate) {
        let timeInterval = since.timeIntervalSince1970
        let songsArray: [MPMediaItem] = songsQuery.items!
        let songsNSarray: NSArray = NSArray(array: songsArray)
        
        for song in songsArray {
            if let lastPlayed = song.lastPlayedDate {
                print("Song title: \(song.title), played date: \(lastPlayed)")
            }
        }
        
    }
    
//    func getPlaysSince(since:NSDate, onSuccess: (tracks: [MPMediaItem])->(), onFail: (error: NSError?)->()) {
//        
//        var rValue = [MPMediaItem]()
//        let timeInterval = since.timeIntervalSince1970
//        let query = MPMediaQuery.songsQuery()
//        let songs = query.items
//        let then = NSDate()
//        for song in songs! {
//            if let lastPlayedDate = song.lastPlayedDate {
//                if lastPlayedDate != nil {
//                    if lastPlayedDate.timeIntervalSince1970 > timeInterval {
//                        rValue.append(item)
//                    }
//                }
//            }
//        }
//        let taken = NSDate().timeIntervalSinceDate(then)
//        
//        onSuccess(tracks: rValue)
//        
//    }
    
}
