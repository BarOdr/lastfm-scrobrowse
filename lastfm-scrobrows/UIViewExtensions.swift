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
    func fadeIn(time: Double) {
        UIView.animateWithDuration(time, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alpha = 1.0
            }, completion: nil)
    }
    
    func fadeOut(time: Double) {
        UIView.animateWithDuration(time, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.alpha = 0.0
            }, completion: nil)
    }
}