//
//  ArtistDetailsPageVC.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 10/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit

class ArtistDetailsPageVC: UIPageViewController {

    var selectedArtist = Artist()
    var dimView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var currentPage = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        dataSource = self
        
        print("Name in page view controller is : \(selectedArtist.artistName)")
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .Forward, animated: true, completion: nil)
        }
    }

    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return self.instantiateChildViewControllers()
    }()
    
    
    
    private func newArtistDetailPageVCPage(detail: String) -> UIViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Artist\(detail)") as? ArtistDetailsGeneralInfoVC
        vc?.selectedArtist = selectedArtist
        return vc!
        
    }
    
    private func instantiateChildViewControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()
        
        let generalInfoVC = storyboard?.instantiateViewControllerWithIdentifier(VIEWCONTR_ARTIST_GENERAL_INFO_VC) as? ArtistDetailsGeneralInfoVC
        generalInfoVC?.currentPage = self.currentPage
        generalInfoVC?.selectedArtist = self.selectedArtist
        viewControllers.append(generalInfoVC!)
        
        let topSongsVC = storyboard?.instantiateViewControllerWithIdentifier(VIEWCONTR_ARTIST_TOP_SONGS_VC) as? ArtistDetailsSongsVC
        topSongsVC?.currentPage = self.currentPage
        topSongsVC?.selectedArtist = self.selectedArtist
        viewControllers.append(topSongsVC!)
        
        let topAlbumsVC = storyboard?.instantiateViewControllerWithIdentifier(VIEWCONTR_ARTIST_TOP_ALBUMS_VC) as? ArtistDetailsAlbumsVC
        topAlbumsVC?.currentPage = self.currentPage
        topAlbumsVC?.selectedArtist = self.selectedArtist
        viewControllers.append(topAlbumsVC!)
        
        let similarVC = storyboard?.instantiateViewControllerWithIdentifier(VIEWCONTR_ARTIST_SIMILAR_VC) as? ArtistDetailsSimilarVC
        similarVC?.currentPage = self.currentPage
        similarVC?.selectedArtist = self.selectedArtist
        similarVC?.dimView = self.dimView
        similarVC?.activityIndicator = self.activityIndicator
        viewControllers.append(similarVC!)
        
        return viewControllers
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
        
        guard let vcIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let nextIndex = vcIndex + 1
        
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard nextIndex != orderedViewControllersCount else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
                return orderedViewControllers[nextIndex]
        
        }
    
}