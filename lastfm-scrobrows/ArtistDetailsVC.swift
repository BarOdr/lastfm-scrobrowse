//
//  ArtistDetailsVC.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 10/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit

class ArtistDetailsVC: UIViewController {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var heartImg: UIButton!
    @IBOutlet weak var pinImg: UIButton!
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var statsIndicator: UILabel!
    @IBOutlet weak var songsIndicator: UILabel!
    @IBOutlet weak var albumsIndicator: UILabel!
    @IBOutlet weak var similarIndicator: UILabel!
    
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var artist = Artist()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        artistImage.clipsToBounds = true
        artistNameLabel.text = artist.artistName
        artistImage.image = artist._image
        
        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ArtistDetailsVC.changePageIndicator(_:)), name: "changeCurrentPage", object: nil)
        Helper.activity(false, dimView: dimView, indicator: activityIndicator)
        
    }

    deinit {
        print("Artist details VC is being deinitialized")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func changePageIndicator(notif: NSNotification) {
        
        let currentPage = notif.userInfo!["currentPage"] as? Int
        
        indicateCurrentPage(currentPage!)
        
        if currentPage == 0 {
            print("We are at stats")
        } else  if currentPage == 1 {
            print("We are at top songs")
        } else if currentPage == 2 {
            print("We are at top albums")
        } else if  currentPage == 3 {
            print("We are at similar artists")
        }
    }
    
    func indicateCurrentPage(page: Int) {
        
        if page == 0 {
            statsIndicator.alpha = 1
            songsIndicator.alpha = 0.5
            albumsIndicator.alpha = 0.5
            similarIndicator.alpha = 0.5
        } else if page == 1 {
            statsIndicator.alpha = 0.5
            songsIndicator.alpha = 1
            albumsIndicator.alpha = 0.5
            similarIndicator.alpha = 0.5
        } else if page == 2 {
            statsIndicator.alpha = 0.5
            songsIndicator.alpha = 0.5
            albumsIndicator.alpha = 1
            similarIndicator.alpha = 0.5
        } else if page == 3 {
            statsIndicator.alpha = 0.5
            songsIndicator.alpha = 0.5
            albumsIndicator.alpha = 0.5
            similarIndicator.alpha = 1
        }
    }
    
    
    @IBAction func loveBtnPressed(sender: AnyObject) {
        
    }
    
    @IBAction func pinBtnPressed(sender: AnyObject) {
        
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let embeddedVC = segue.destinationViewController as? ArtistDetailsPageVC where segue.identifier == "ToArtistDetailsPageVC" {
            
            embeddedVC.dimView = self.dimView
            embeddedVC.activityIndicator = self.activityIndicator
            embeddedVC.selectedArtist = artist
        }
    }
}
