//
//  UserAvatarImageView.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 09/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {

    override func awakeFromNib() {
        
        self.clipsToBounds = true
        layer.cornerRadius = self.frame.size.height / 2
    }

}
