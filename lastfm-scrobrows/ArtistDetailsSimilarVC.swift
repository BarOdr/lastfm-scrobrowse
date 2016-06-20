//
//  ArtistDetailsConcertsVC.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 14/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit

class ArtistDetailsSimilarVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

//    @IBOutlet weak var tableView: UITableView!
    
    let api = API()
    
    var dimView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedArtist = Artist()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.4)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        currentPageView = 3
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        Helper.activity(false, dimView: dimView, indicator: activityIndicator)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedArtist.similarArtists.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("SimilarArtistCell") as? SimilarArtistCell {
            cell.similarArtist = selectedArtist.similarArtists[indexPath.row]
            cell.configureCell()
            return cell
        } else {
            return SimilarArtistCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        Helper.activity(true, dimView: dimView, indicator: activityIndicator)
        var newArtist = selectedArtist.similarArtists[indexPath.row]
        
        let params = api.generateParametersForArtistMethods(PARAM_ARTIST_GET_INFO, apiKey: LASTFM_API_KEY, artist: newArtist, username: "")
        
        
        api.lastfmDownloadTask(GET, parameters: params) { (json) in
            
            newArtist = self.api.artistGetInfo(newArtist, json: json)

            let params = self.api.generateParametersForArtistMethods(PARAM_ARTIST_GET_TOPTRACKS, apiKey: LASTFM_API_KEY, artist: newArtist, username: "")
            
            self.api.lastfmDownloadTask(GET, parameters: params, completion: { (json) in
                
                let topTracks = self.api.artistGetTopTracks(20, json: json)
                newArtist.setTopTracks(topTracks)
                
                let params = self.api.generateParametersForArtistMethods(PARAM_ARTIST_GET_TOPALBUMS, apiKey: LASTFM_API_KEY, artist: newArtist, username: "")
                
                self.api.lastfmDownloadTask(GET, parameters: params, completion: { (json) in
                    
                    let topAlbums = self.api.artistGetTopAlbums(20, json: json)
                    newArtist.setTopAlbums(topAlbums)
                    
                    CacheService.artistCache.setObject(newArtist, forKey: newArtist.artistName)
                    
                    self.api.imageAlamofireRequest(newArtist.artistImgUrl, completion: { (img) in
                        newArtist.setImage(img)
                        
                        self.presentSimilarArtistDetails(newArtist)
                    })
                })
            })
            
            
        }
    }
    
    func presentSimilarArtistDetails(artist: Artist) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("ArtistDetailsVC") as? ArtistDetailsVC
        vc?.artist = artist
        vc?.dimView = self.dimView
        vc?.activityIndicator = self.activityIndicator
        presentViewController(vc!, animated: true, completion: nil)
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
