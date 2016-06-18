//
//  ArtistListVC.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 08/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit

class ArtistListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
//    let ds = LastfmDataService()
    let api = API()
    
    var artistsArray = [Artist]()
    var currentUser = LastfmUser()
    
    deinit {
        print("artistListVC is being deinitialized")
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        print("There is \(artistsArray.count) artists in the array")

    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("ArtistCell") as? ArtistCell {
            let artist = artistsArray[indexPath.row]
            cell.configureCell(artist)
            return cell
        } else {
            return ArtistCell()
        }
    }
    
    func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var selectedArtist = artistsArray[indexPath.row]
        if let cachedArtist = CacheService.artistCache.objectForKey(selectedArtist.artistName) as? Artist {
            print("Loaded \(cachedArtist.artistName) from cache")
            goToDetails(cachedArtist)
        } else {
            let username = currentUser.username
            let paramsDict = api.generateParametersForArtistMethods(PARAM_ARTIST_GET_INFO, apiKey: LASTFM_API_KEY, artist: selectedArtist, username: username)
            
            api.lastfmDownloadTask(.GET, parameters: paramsDict) { (json) in
                
                
                selectedArtist = self.api.artistGetInfo(selectedArtist, json: json)
                CacheService.artistCache.setObject(selectedArtist, forKey: selectedArtist.artistName)
                print("Saved \(selectedArtist.artistName) to cache")
                self.goToDetails(selectedArtist)
            }
        }
    }
    
    
    func goToDetails(artist: Artist) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier(VIEWCONTR_ARTIST_DETAILS_VC) as! ArtistDetailsVC
        vc.artist = artist
        presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
