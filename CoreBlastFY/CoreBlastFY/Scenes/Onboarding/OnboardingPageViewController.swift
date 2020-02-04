//
//  OnboardingPageViewController.swift
//  ForeverYoungFitness
//
//  Created by Riccardo Washington on 7/8/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var pageHeadings = ["Welcome to Forever Young Fitness!", "Flexx Pics!", "Programs!", "Workout Reminder!"]
   
    var pageContent = ["Where being Forever Young is a mentality, lifestyle, and choice!",
                       "Consistency is Key! \nTaking weekly pics will help us stay motivated and on track with our workouts and nutrition in-take!",
                       "All Programs are Goal Oriented to get you the results your looking for as safely and efficiently as possible! \nIf you're ready for change, work hard, be consistent and have fun!",
                       "What days and times would you like to be reminded to workout?"
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .goatBlack
        dataSource = self
        
        //Create the first walkthrough screen
        
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
        
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
