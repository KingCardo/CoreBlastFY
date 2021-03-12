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
        UserAPI.user = UserManager.loadUserFromFile()
        registerForNotifications()
        StoreManager.shared.delegate = self
        StoreObserver.shared.delegate = self
    }
    
    
    private func setupPreworkoutVC() {
        let workoutViewController = PreWorkoutViewController()
        self.workoutNavController = UINavigationController(rootViewController: workoutViewController)
        self.workoutNavController.navigationBar.barStyle = .black
        self.workoutNavController.navigationBar.tintColor = .white
        self.workoutNavController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.workoutNavController.tabBarItem = UITabBarItem(title: "Workout", image: #imageLiteral(resourceName: "muscleflex"), selectedImage: nil)
    }
    
    private func setupExerciseVC() {
        let exerciseVC = ExerciseViewController()
        self.exercisesNavVC = UINavigationController(rootViewController: exerciseVC)
        self.exercisesNavVC.navigationBar.barStyle = .black
        self.exercisesNavVC.navigationBar.tintColor = .white
        self.exercisesNavVC.tabBarItem = UITabBarItem(title: "Exercises", image: #imageLiteral(resourceName: "exercises"), selectedImage: nil)
        self.exercisesNavVC.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private var progressionNavController: UINavigationController!
    private var workoutNavController: UINavigationController!
    private var journalNavViewController: UINavigationController!
    private var nutritionVC: MealPlansViewController!
    private var exercisesNavVC: UINavigationController!
    private var settingsNavController: UINavigationController!
    
    
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
        
        let journalViewController = JournalViewController()
        journalNavViewController = UINavigationController(rootViewController: journalViewController)
        journalNavViewController.navigationBar.barStyle = .black
        journalNavViewController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.makeTitleFont(size: 22)]
        let journalImage = UIImage(systemName: "list.dash")
        journalNavViewController.tabBarItem = UITabBarItem(title: "Journal", image: journalImage, selectedImage: nil)
                
        

        
        let settingsViewController = SettingsViewController()
        settingsNavController = UINavigationController(rootViewController: settingsViewController)
        settingsNavController.tabBarItem = UITabBarItem(title: "More", image: #imageLiteral(resourceName: "setting"), selectedImage: nil)
        settingsNavController.navigationBar.prefersLargeTitles = true
        settingsNavController.navigationBar.barStyle = .black
        settingsNavController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.setupPreworkoutVC()
        setViewControllers([progressionNavController, workoutNavController, nutritionVC, journalNavViewController, settingsNavController], animated: true)
        self.customizableViewControllers = []
        
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
