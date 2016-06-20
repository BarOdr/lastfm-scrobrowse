//
//  ArtistDetailsGeneralInfoVC.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 14/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit

class ArtistDetailsGeneralInfoVC: UIViewController {

    var selectedArtist = Artist()
    
    @IBOutlet weak var tagsLabel: LabelOnDimmedBackground!
    @IBOutlet weak var playcountLabel: LabelOnDimmedBackground!
    @IBOutlet weak var listenersCountLabel: LabelOnDimmedBackground!
    @IBOutlet weak var topAlbumLabel: LabelOnDimmedBackground!
    @IBOutlet weak var topTrackLabel: LabelOnDimmedBackground!
    @IBOutlet weak var bioTextView: UITextView!
    
    var currentPage = 0
    
    convenience init() {
        self.init()
        print("Artist general info VC is being initialized")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.4)

        print("Artist named \(selectedArtist.artistName) passed to general info vc - success!")
        configureUI()
    }

    override func viewWillAppear(animated: Bool) {
        let dictionary = ["currentPage": 0]
        NSNotificationCenter.defaultCenter().postNotificationName("changeCurrentPage", object: nil, userInfo: dictionary)
    }
    
    func configureUI() {
        
        let playcount = selectedArtist.playcount
        let listenersCount = selectedArtist.listenersCount
        
        let formattedPlayc = Helper.formattedPlaycount(playcount)
        let formattedListCount = Helper.formattedPlaycount(listenersCount)
        tagsLabel.text = "Here are the artist's top tags!"
        playcountLabel.text = formattedPlayc
        listenersCountLabel.text = formattedListCount
        topAlbumLabel.text = selectedArtist.topAlbums[0].albumName
        topTrackLabel.text = selectedArtist.topTracks[0].trackName
        bioTextView.text = selectedArtist.biography
        bioTextView.font = bioTextView.font?.fontWithSize(20)
        bioTextView.textColor = UIColor.whiteColor()

    }
}
