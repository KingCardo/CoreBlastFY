//
//  ViewController.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/8/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupTabBar()
        
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal

        let progressionViewController = ProgressionCollectionViewController(collectionViewLayout: layout)
        let progressionNavController = UINavigationController(rootViewController: progressionViewController)
        progressionNavController.tabBarItem = UITabBarItem(title: "Progression", image: #imageLiteral(resourceName: "camera"), selectedImage: nil)
        progressionNavController.navigationBar.prefersLargeTitles = true
        
        let workoutViewController = PreWorkoutViewController()
        let workoutNavController = UINavigationController(rootViewController: workoutViewController)
        workoutNavController.navigationItem.title = "Flexx"
        workoutNavController.tabBarItem = UITabBarItem(title: "Workout", image: #imageLiteral(resourceName: "workout"), selectedImage: nil)
        workoutNavController.navigationBar.prefersLargeTitles = true
        
        let settingsViewController = SettingsViewController()
        let settingsNavController = UINavigationController(rootViewController: settingsViewController)
        settingsNavController.tabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "settings"), selectedImage: nil)
        settingsNavController.navigationBar.prefersLargeTitles = true
        
        viewControllers = [progressionNavController, workoutNavController, settingsNavController]
        selectedViewController = viewControllers?[1]
//        let progressionTabBarItem = UITabBarItem(title: "Flexx", image: nil, selectedImage: nil)
//        let workoutTabBarItem = UITabBarItem(title: "Workout", image: nil, selectedImage: nil)
//        let settingsTabBarItem = UITabBarItem(title: "Settings", image: nil, selectedImage: nil)
        //tabBar.items = [progressionTabBarItem, workoutTabBarItem, settingsTabBarItem]
    }

    private func setupTabBar() {
          tabBar.isTranslucent = false
          tabBar.barTintColor = .goatBlack
          tabBar.tintColor = .goatBlue
          
      }

}

