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
    

    static func formattedPlaycount(playcount: String) -> String {
        
        let number = Double(playcount)
        
        if number <= 1000 {
            return "\(number!)"
            
        } else if number > 1000 && number < 10000 {
            let dividedNumber = number! / 1000
            return String(format: "%.3f", dividedNumber)
            
        } else if number >= 10000 && number < 1000000 {
            let dividedNumber = number! / 1000
            return String(format: "%.1fK", dividedNumber)
            
        } else if number >= 1000000 {
            let dividedNumber = number! / 1000000
            return String(format: "%.1fM", dividedNumber)
            
        } else {
            return String(number)
        }
    }
    
    static func formattedPlaycountFromInt(playcount: Int) -> String {
        
        let stringNumber = String(playcount)
        return formattedPlaycount(stringNumber)
    }
    
}