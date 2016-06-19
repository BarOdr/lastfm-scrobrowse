//
//  Helper.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 09/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    
    static func registrationDateFromUnixTime(unixTime: Double) -> String {
        let date = NSDate(timeIntervalSince1970: unixTime)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM d y"
        let timeStr = dateFormatter.stringFromDate(date)
        return timeStr
    }
    
    /**
     This method turns the activity indication on or off.
     
     - Parameter active: Bool
     */
    
    static func activity(active: Bool, dimView: UIView, indicator: UIActivityIndicatorView) {
        if active {
            indicateActivity(dimView, indicator: indicator)
        } else {
            stopIndicatingActivity(dimView, indicator: indicator)
        }
    }
    
    /**
     This method shows the activity indicator and stops its animation.
     */
    
    static func indicateActivity(dimView: UIView, indicator: UIActivityIndicatorView) {
        dimView.alpha = 0
        dimView.hidden = false
        dimView.fadeIn(0.2)
        indicator.fadeIn(0.3)
        indicator.startAnimating()
    }
    
    /**
     This method shows the activity indicator and stops its animation.
     */
    
    static func stopIndicatingActivity(dimView: UIView, indicator: UIActivityIndicatorView) {
        indicator.fadeOut(0.3)
        indicator.stopAnimating()
        dimView.fadeOut(0.2)
        dimView.hidden = false
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
    
    static func formattedTagString(tags: [String]) -> String {
        
        
        return ""
    }
    
}