//
//  StringExtensions.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 18/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import Foundation

extension String {
    
    var formattedPlaycount: String {
        get {
            return formattedPlaycount(self)
        }
    }
    
    func formattedPlaycount(playcount: String) -> String {
        let number = Double(playcount)
        
        if number >= 10000 {
            let dividedNumber = number! / 1000
            return String(format: "%.1f", dividedNumber)
            
        } else if number >= 1000000 {
            let dividedNumber = number! / 1000000
            return String(format: "%.2f", dividedNumber)
        } else {
            return String(number)
        }
    }
}