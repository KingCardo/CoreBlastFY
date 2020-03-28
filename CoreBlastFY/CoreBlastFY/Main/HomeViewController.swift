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
        registerForNotifications()
    }
    
    private func setup() {
        setupTabBar()
        
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal

        let progressionViewController = ProgressionCollectionViewController(collectionViewLayout: layout)
        let progressionNavController = UINavigationController(rootViewController: progressionViewController)
        progressionNavController.tabBarItem = UITabBarItem(title: "Progression", image: #imageLiteral(resourceName: "camera"), selectedImage: nil)
        progressionNavController.navigationBar.prefersLargeTitles = true
        progressionNavController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        let workoutViewController = PreWorkoutViewController()
        let workoutNavController = UINavigationController(rootViewController: workoutViewController)
        workoutNavController.navigationItem.title = "Flexx"
        workoutNavController.navigationBar.barStyle = .black
        workoutNavController.navigationBar.tintColor = .white
        workoutNavController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        workoutNavController.tabBarItem = UITabBarItem(title: "Workout", image: #imageLiteral(resourceName: "workout"), selectedImage: nil)
        
//        let nutritionVC = NutritonViewController()
//        nutritionVC.tabBarItem = UITabBarItem(title: "Nutrition", image: #imageLiteral(resourceName: "icons8-dining-room-50"), selectedImage: nil)

        let settingsViewController = SettingsViewController()
        let settingsNavController = UINavigationController(rootViewController: settingsViewController)
        settingsNavController.tabBarItem = UITabBarItem(title: "More", image: #imageLiteral(resourceName: "icons8-plus-32"), selectedImage: nil)
        settingsNavController.navigationBar.prefersLargeTitles = true
        settingsNavController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        viewControllers = [progressionNavController, workoutNavController, /*nutritionVC,*/ settingsNavController]
        selectedViewController = viewControllers?[1]
    }

    private func setupTabBar() {
          tabBar.isTranslucent = false
          tabBar.barTintColor = .goatBlack
          tabBar.tintColor = .goatBlue
          
      }

}

