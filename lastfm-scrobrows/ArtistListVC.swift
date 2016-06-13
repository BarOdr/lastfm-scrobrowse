//
//  ArtistListVC.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 08/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit

class ArtistListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let ds = LastfmDataService()
    
    var artistsArray = [Artist]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        print("There is \(artistsArray.count) artists in the array")

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
        let vc = storyboard?.instantiateViewControllerWithIdentifier("ArtistDetailsVC") as! ArtistDetailsVC
        vc.artist = artistsArray[indexPath.row]
        presentViewController(vc, animated: true, completion: nil)
        
    }
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func testbtn(sender: AnyObject) {
        print(artistsArray[0].listenersCount)
    }
}
