//
//  ArtistDetailsSongsVC.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 14/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit

class ArtistDetailsSongsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    var selectedArtist = Artist()
    let api = API()

    var currentPage = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        print("This is top songs vc speaking. Current artist is \(selectedArtist.artistName)")
        view.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.4)
        
        for track in selectedArtist.topTracks {
            print("Top track: \(track.trackName)")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        let dictionary = ["currentPage": 1]
        NSNotificationCenter.defaultCenter().postNotificationName("changeCurrentPage", object: nil, userInfo: dictionary)    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedArtist.topTracks.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("TrackCell") as? TrackCell {
            cell.configureCell(selectedArtist.topTracks[indexPath.row])
            return cell
        } else {
            return TrackCell()
        }
    }


}
