//
//  AlbumCell.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 18/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit



class AlbumCell: UITableViewCell {

    let api = API()
    var album = Album()
    

    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var playcountLabel: LabelOnDimmedBackground!
    @IBOutlet weak var albumImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell() {
        
        api.imageAlamofireRequest(self.album.coverUrl) { (img) in
            self.albumImage.image = img
        }
        
        let formattedPlaycount = Helper.formattedPlaycountFromInt(album.overallPlayCount)
        albumNameLabel.text = album.albumName
        playcountLabel.text = formattedPlaycount
        
        
        
    }
}
