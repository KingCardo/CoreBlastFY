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
        StoreManager.shared.delegate = self
        StoreObserver.shared.delegate = self
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
            self.workoutNavController.navigationBar.barStyle = .black
            self.workoutNavController.navigationBar.tintColor = .white
            self.workoutNavController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            self.workoutNavController.tabBarItem = UITabBarItem(title: "Workout", image: #imageLiteral(resourceName: "muscleflex"), selectedImage: nil)
            
            let exerciseVC = ExerciseViewController()
            self.exercisesNavVC = UINavigationController(rootViewController: exerciseVC)
            self.exercisesNavVC.navigationBar.barStyle = .black
            self.exercisesNavVC.navigationBar.tintColor = .white
            self.exercisesNavVC.tabBarItem = UITabBarItem(title: "Exercises", image: #imageLiteral(resourceName: "exercises"), selectedImage: nil)
            self.exercisesNavVC.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

            self.setViewControllers([self.progressionNavController, self.workoutNavController, self.nutritionVC, self.exercisesNavVC, self.settingsNavController], animated: true)
            self.view.setNeedsLayout()
        }
    }
    
    var progressionNavController: UINavigationController!
    var workoutNavController: UINavigationController!
    var nutritionVC: MealPlansViewController!
    var exercisesNavVC: UINavigationController!
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
            setViewControllers([progressionNavController, nutritionVC, settingsNavController], animated: true)
        } else {
            let workoutViewController = PreWorkoutViewController()
                   workoutNavController = UINavigationController(rootViewController: workoutViewController)
                   workoutNavController.navigationBar.barStyle = .black
                   workoutNavController.navigationBar.tintColor = .white
                   workoutNavController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
                   workoutNavController.tabBarItem = UITabBarItem(title: "Workout", image: #imageLiteral(resourceName: "muscleflex"), selectedImage: nil)

            let exerciseVC = ExerciseViewController()
            exercisesNavVC = UINavigationController(rootViewController: exerciseVC)
            exercisesNavVC.navigationBar.barStyle = .black
            exercisesNavVC.navigationBar.tintColor = .white
            exercisesNavVC.tabBarItem = UITabBarItem(title: "Exercises", image: #imageLiteral(resourceName: "exercises"), selectedImage: nil)
            exercisesNavVC.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

            setViewControllers([progressionNavController, workoutNavController, nutritionVC, exercisesNavVC, settingsNavController], animated: true)
        }
        
        selectedViewController = viewControllers?[0]
    }

    private func setupTabBar() {
          tabBar.isTranslucent = false
          tabBar.barTintColor = .goatBlack
          tabBar.tintColor = .goatBlue
          
      }
    
    

}

extension HomeViewController: StoreManagerDelegate {
    
    func storeManagerDidReceiveMessage(_ message: String) {
        let ac = AlertController.alert(Messages.productRequestStatus, message: message)
        navigationController?.present(ac, animated: true, completion: nil)
    }
    
}

extension HomeViewController: StoreObserverDelegate {
    func storeObserverDidReceiveMessage(_ message: String) {
        let ac = AlertController.alert(Messages.purchaseStatus, message: message)
        present(ac, animated: true, completion: nil)
    }

    func storeObserverRestoreDidSucceed() {
        let ac = AlertController.alert(Messages.purchaseStatus, message: "All successful purchases have been restored.")
        present(ac, animated: true, completion: nil)
    }
}
