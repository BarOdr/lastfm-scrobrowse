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
    
    var currentPage = currentPageView {
        didSet(page) {
            changePageIndicator(page)
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        artistImage.clipsToBounds = true
        artistNameLabel.text = artist.artistName
        artistImage.image = artist._image
        
        // Do any additional setup after loading the view.
        
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

    func changePageIndicator(pageNumber: Int) {
        if currentPage == 0 {
            print("We are at stats")
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
