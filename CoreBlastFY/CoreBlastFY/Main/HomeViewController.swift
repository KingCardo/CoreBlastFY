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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ExerciseStorage.failedCompletion = { (errorMessage) in
            AlertController.createAlert(errorMessage: errorMessage, viewController: self)
        
        }
    }
   
    
    private func setup() {
        setupTabBar()
        
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal

        let progressionViewController = ProgressionCollectionViewController(collectionViewLayout: layout)
        let progressionNavController = UINavigationController(rootViewController: progressionViewController)
        progressionNavController.tabBarItem = UITabBarItem(title: "Progression", image:#imageLiteral(resourceName: "newcamera") /*  #imageLiteral(resourceName: "camera")*/, selectedImage: nil)
        progressionNavController.navigationBar.prefersLargeTitles = true
        progressionNavController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        let workoutViewController = PreWorkoutViewController()
        let workoutNavController = UINavigationController(rootViewController: workoutViewController)
        workoutNavController.navigationItem.title = "Flexx"
        workoutNavController.navigationBar.barStyle = .black
        workoutNavController.navigationBar.tintColor = .white
        workoutNavController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        workoutNavController.tabBarItem = UITabBarItem(title: "Workout", image: #imageLiteral(resourceName: "muscleflex"), selectedImage: nil)
        
        let nutritionVC = MealPlansViewController()
        nutritionVC.tabBarItem = UITabBarItem(title: "Meal Plans", image: #imageLiteral(resourceName: "silverware"), selectedImage: nil)

        let settingsViewController = SettingsViewController()
        let settingsNavController = UINavigationController(rootViewController: settingsViewController)
        settingsNavController.tabBarItem = UITabBarItem(title: "More", image: #imageLiteral(resourceName: "setting"), selectedImage: nil)
        settingsNavController.navigationBar.prefersLargeTitles = true
        settingsNavController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        viewControllers = [progressionNavController, workoutNavController, nutritionVC, settingsNavController]
        selectedViewController = viewControllers?[0]
    }

    private func setupTabBar() {
          tabBar.isTranslucent = false
          tabBar.barTintColor = .goatBlack
          tabBar.tintColor = .goatBlue
          
      }

}

