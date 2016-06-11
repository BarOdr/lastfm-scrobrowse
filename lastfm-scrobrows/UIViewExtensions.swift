//
//  UIViewExtensions.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 06/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /**
     This method sets an UIView's alpha to 1.0 by animation it, creating a fade in effect.
     
     - parameter time: Time of animation (Double)
     
    */
    
    func fadeIn(time: Double) {
        UIView.animateWithDuration(time, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alpha = 1.0
            }, completion: nil)
    }
    
    /**
     This method sets an UIView's alpha to 0 by animation it, creating a fade out effect.
     
     - parameter time: Time of animation (Double)
     
     */
    
    func fadeOut(time: Double) {
        UIView.animateWithDuration(time, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.alpha = 0.0
            }, completion: nil)
    }
    
}