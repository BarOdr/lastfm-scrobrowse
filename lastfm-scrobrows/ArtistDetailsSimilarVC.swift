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
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedArtist = Artist()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.4)

        // Do any additional setup after loading the view.
        print("This is artist details similar vc! Obey! And listen, that the selected artist is \(selectedArtist.artistName) and similar artists are \(selectedArtist.similarArtists[0])")
    }
    
    override func viewWillAppear(animated: Bool) {
        currentPageView = 3
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
