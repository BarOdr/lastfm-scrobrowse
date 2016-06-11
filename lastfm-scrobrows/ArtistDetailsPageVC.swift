//
//  ArtistDetailsPageVC.swift
//  lastfm-scrobrows
//
//  Created by Bartosz Odrzywołek on 10/06/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit

class ArtistDetailsPageVC: UIPageViewController {

    
    let test = 23
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .Forward, animated: true, completion: nil)
        }
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
        
        postNotificationToChangePageControlPage(previousIndex)
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
        
        postNotificationToChangePageControlPage(nextIndex)
        print(nextIndex)
        return orderedViewControllers[nextIndex]
        
        }
    
    //NOT WORKING YET//
    
    func postNotificationToChangePageControlPage(changeTo: Int) {
        
        let dictionary = ["pageControlIndex":  changeTo]
        NSNotificationCenter.defaultCenter().postNotificationName("changePageControlIndex", object: nil, userInfo: dictionary)
    }
//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return orderedViewControllers.count
//    }
//    
//    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        
//            return 0
//    }
    
}