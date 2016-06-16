//
//  Helper.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 09/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import Foundation

class Helper {
    
    static func registrationDateFromUnixTime(unixTime: Double) -> String {
        let date = NSDate(timeIntervalSince1970: unixTime)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM d y"
        let timeStr = dateFormatter.stringFromDate(date)
        return timeStr
    }
    
    
}