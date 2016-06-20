//
//  ArtistDetailsAlbumsVC.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 14/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit

class ArtistDetailsAlbumsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var selectedArtist = Artist()
    
    var currentPage = 2

    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.4)

        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.4)

        for album in selectedArtist.topAlbums {
            print("Top album: \(album.albumName)")
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let dictionary = ["currentPage": 2]
        NSNotificationCenter.defaultCenter().postNotificationName("changeCurrentPage", object: nil, userInfo: dictionary)    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("AlbumCell") as? AlbumCell {
                cell.album = selectedArtist.topAlbums[indexPath.row]
                cell.configureCell()
            return cell
        }
        return AlbumCell()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
