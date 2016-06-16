//
//  ArtistCell.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 08/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit

class ArtistCell: UITableViewCell {
    
    let lastfmDataService = LastfmDataService()
    
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artistImage: RoundImageView!
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        artistImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(artist: Artist) {
        
        
        artistNameLabel.text = artist.artistName
        
        self.artistImage.image = nil
        if let cachedImage = CacheService.imageCache.objectForKey(artist.artistImgUrl) {
            artistImage.image = cachedImage as? UIImage
            artistImage.fadeIn(1.5)
        } else {
            lastfmDataService.imageAlamofireRequest(artist, completion: { (img) in
                self.artistImage.image = img
                self.artistImage.fadeIn(1.5)
            })
        }
        
    }
}
