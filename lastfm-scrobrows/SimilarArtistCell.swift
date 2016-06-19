//
//  SimilarArtistCell.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 19/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit

class SimilarArtistCell: UITableViewCell {

    let api = API()
    var similarArtist = Artist()
    
    @IBOutlet weak var artistImage: RoundImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        artistImage.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell() {
        
        api.imageAlamofireRequest(similarArtist.artistImgUrl) { (img) in
            self.artistImage.image = img
        }
        artistNameLabel.text = similarArtist.artistName
    }
}
