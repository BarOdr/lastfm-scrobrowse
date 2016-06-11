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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
//
//    func changePageControlIndex(notification: NSNotification) {
//        print(notification.userInfo!["pageControlIndex"])
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func loveBtnPressed(sender: AnyObject) {
        
    }
    
    @IBAction func pinBtnPressed(sender: AnyObject) {
        
    }
}
