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
    
    func lastfmDownloadTask(type: Alamofire.Method, parameters: Dictionary<String, AnyObject>, completion: LastfmDownloadComplete ) {
        
        Alamofire.request(type, LASTFM_BASE_URL, parameters: parameters).response { (request, response, data, error) in
            
            if error == nil {
//                parserMethod // <---- lastfmDownloadTask parameter
                // ,for example: Parser.UserParser().getTopAlbums(data!)
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
    
    func userGetTopAlbums(data: NSData) -> [Album] {
        
        
        return [Album]()
    }
    

    
}