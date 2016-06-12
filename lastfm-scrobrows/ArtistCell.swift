//
//  ArtistCell.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 08/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit

class ArtistCell: UITableViewCell {
    
    
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var listenersCountLabel: UILabel!
    @IBOutlet weak var scrobblesCountLabel: UILabel!
    @IBOutlet weak var topTrackLabel: UILabel!
    @IBOutlet weak var topAlbumLabel: UILabel!
    @IBOutlet weak var topTagsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(artist: Artist) {
        
        artistNameLabel.text = artist.artistName
        listenersCountLabel.text = artist.listenersCount
        scrobblesCountLabel.text = artist.playcount
//        topTrackLabel.text = artist.topTracks[0].trackName
//        topAlbumLabel.text = artist.topAlbums[0].albumName
//        topTagsLabel.text = artist.relatedTags[0]
    }

}
