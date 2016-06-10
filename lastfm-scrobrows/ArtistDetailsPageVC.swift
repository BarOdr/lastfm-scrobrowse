//
//  ArtistDetailsPageVC.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 10/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit

class ArtistDetailsPageVC: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
    }

    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [
            self.newArtistDetailPageVCPage("GeneralInfo"),
            self.newArtistDetailPageVCPage("TopSongs"),
            self.newArtistDetailPageVCPage("TopAlbums"),
            self.newArtistDetailPageVCPage("TopSongs"),
            self.newArtistDetailPageVCPage("Bio"),
            self.newArtistDetailPageVCPage("Concerts")
        ]
    }()
    
    private func newArtistDetailPageVCPage(detail: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Artist\(detail)")
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

extension ArtistDetailsPageVC: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
}