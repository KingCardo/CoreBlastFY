//
//  OnboardingPageViewController.swift
//  ForeverYoungFitness
//
//  Created by Riccardo Washington on 7/8/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var pageHeadings = ["Welcome to Forever Young Fitness!", "Flexx Pics!", "Programs!", "Simplicity", ""]
   
    var pageContent = ["Forever Young is a mentality, lifestyle, and choice!",
                       "Consistency is key! \nTaking weekly pics will help us stay motivated and on track with our workouts and nutrition in-take!",
                       "All programs are Goal Oriented to get you the results you're looking for as safely and efficiently as possible! \nIf you're ready for change, work hard, be consistent and have fun!",
                      "Workouts slowly increase in intensity as you complete daily workouts, so you don't have to think, just hit start and put in the work!", ""
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
         NotificationCenter.default.addObserver(self, selector: #selector(handleFailedFetch), name: FetchingExercisesFailedNotification, object: nil)
        view.backgroundColor = .goatBlack
        dataSource = self
        
        //Create the first walkthrough screen
        
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    @objc func handleFailedFetch() {
               if notificationsAllowed {
                   workoutsFailedNotification()
               }
       
               AlertController.createAlert(errorMessage: "Network connectivity not strong enough. Please try again when connected to WiFi", title: "Network Download Error", viewController: self, actionTitle: "Try Again", handler: retryHandler)
           
       }
       
       func retryHandler(alertAction: UIAlertAction) {
           
           let exerciseFetcher = SceneExerciseFetcher()
           exerciseFetcher.fetchExercises { (success) in
             DispatchQueue.main.async {
               if success == true {
                   workoutsReadyNotification()
               } else if success == false {
                   NotificationCenter.default.post(name: FetchingExercisesFailedNotification, object: self)
                   workoutsFailedNotification()
               }
            }
           }
       }
    
    override var prefersStatusBarHidden: Bool {
           return true
       }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! OnboardingViewController).index
        index -= 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! OnboardingViewController).index
        index += 1
        
        return contentViewController(at: index)
        
    }
    
    func contentViewController(at index: Int) -> OnboardingViewController? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        
        //Create new view controller and pass data
        
        let pageContentViewController = OnboardingViewController()
           
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.content = pageContent[index]
            pageContentViewController.index = index
            return pageContentViewController
    }
    
    
    
    func forward(index: Int) {
        if let nextViewController = contentViewController(at: index + 1) {
            setViewControllers([nextViewController], direction: .forward, animated: true)
        }
    }
    
}
