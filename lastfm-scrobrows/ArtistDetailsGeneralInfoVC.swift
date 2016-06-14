//
//  ArtistDetailsGeneralInfoVC.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 14/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit

class ArtistDetailsGeneralInfoVC: UIViewController {

    @IBOutlet weak var tagsLabel: LabelOnDimmedBackground!
    @IBOutlet weak var playcountLabel: LabelOnDimmedBackground!
    @IBOutlet weak var listenersCountLabel: LabelOnDimmedBackground!
    @IBOutlet weak var topAlbumLabel: LabelOnDimmedBackground!
    @IBOutlet weak var topArtistLabel: LabelOnDimmedBackground!
    @IBOutlet weak var bioTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.4)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func artistGeneralIsItThere() {
        
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
