//
//  TrackCell.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 18/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {

    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var playcountLabel: LabelOnDimmedBackground!
    @IBOutlet weak var loveImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(track: Track) {
        
        let formattedPlaycount = Helper.formattedPlaycount(track.overallPlayCount)
        trackNameLabel.text = track.trackName
        playcountLabel.text = formattedPlaycount
    }
}
