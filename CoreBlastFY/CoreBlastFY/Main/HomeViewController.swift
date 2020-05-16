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
        NotificationCenter.default.addObserver(self, selector: #selector(handleVC), name: NSNotification.Name("ExercisesLoadedNotification"), object: nil)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        ExerciseStorage.failedCompletion = { (errorMessage) in
            AlertController.createAlert(errorMessage: errorMessage, viewController: self)
        
        }
    }
    
    @objc private func handleVC() {
        DispatchQueue.main.async {
            let workoutViewController = PreWorkoutViewController()
            self.workoutNavController = UINavigationController(rootViewController: workoutViewController)
            self.workoutNavController.navigationItem.title = "Flexx"
            self.workoutNavController.navigationBar.barStyle = .black
            self.workoutNavController.navigationBar.tintColor = .white
            self.workoutNavController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            self.workoutNavController.tabBarItem = UITabBarItem(title: "Workout", image: #imageLiteral(resourceName: "muscleflex"), selectedImage: nil)
            self.setViewControllers([self.progressionNavController, self.workoutNavController, self.nutritionVC, self.settingsNavController], animated: true)
            self.view.setNeedsLayout()
        }
    }
    
    var progressionNavController: UINavigationController!
    var workoutNavController: UINavigationController!
    var nutritionVC: MealPlansViewController!
    var settingsNavController: UINavigationController!
   
    
    private func setup() {
        setupTabBar()
        
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal

        let progressionViewController = ProgressionCollectionViewController(collectionViewLayout: layout)
         progressionNavController = UINavigationController(rootViewController: progressionViewController)
        progressionNavController.tabBarItem = UITabBarItem(title: "Progression", image:#imageLiteral(resourceName: "newcamera") , selectedImage: nil)
        progressionNavController.navigationBar.prefersLargeTitles = true
        progressionNavController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        
        nutritionVC = MealPlansViewController()
        nutritionVC.tabBarItem = UITabBarItem(title: "Meal Plans", image: #imageLiteral(resourceName: "silverware"), selectedImage: nil)

        let settingsViewController = SettingsViewController()
        settingsNavController = UINavigationController(rootViewController: settingsViewController)
        settingsNavController.tabBarItem = UITabBarItem(title: "More", image: #imageLiteral(resourceName: "setting"), selectedImage: nil)
        settingsNavController.navigationBar.prefersLargeTitles = true
        settingsNavController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
   
        
        if ExerciseStorage.exercises.isEmpty {
            viewControllers = [progressionNavController, nutritionVC, settingsNavController]
        } else {
            let workoutViewController = PreWorkoutViewController()
                   workoutNavController = UINavigationController(rootViewController: workoutViewController)
                   workoutNavController.navigationItem.title = "Flexx"
                   workoutNavController.navigationBar.barStyle = .black
                   workoutNavController.navigationBar.tintColor = .white
                   workoutNavController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
                   workoutNavController.tabBarItem = UITabBarItem(title: "Workout", image: #imageLiteral(resourceName: "muscleflex"), selectedImage: nil)
            viewControllers = [progressionNavController, workoutNavController, nutritionVC, settingsNavController]
        }
        
        selectedViewController = viewControllers?[0]
    }

    private func setupTabBar() {
          tabBar.isTranslucent = false
          tabBar.barTintColor = .goatBlack
          tabBar.tintColor = .goatBlue
          
      }

}

