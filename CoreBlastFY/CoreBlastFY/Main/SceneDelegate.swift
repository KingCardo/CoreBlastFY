//
//  SceneDelegate.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/8/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

let PauseWorkoutNotification = NSNotification.Name("PauseWorkoutNotification")
let FetchingExercisesFailedNotification = Notification.Name("FetchingExercisesFailed")
let FetchingExercisesSucceededNotification = Notification.Name("FetchingExercisesSucceededNotification")

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    func userNotificationCenter(
           _ center: UNUserNotificationCenter,
           willPresent notification: UNNotification,
           withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
           -> Void) {
           completionHandler([.alert, .badge, .sound])
       }
    
    func retryHandler(alertAction: UIAlertAction) {
        
        let exerciseFetcher = SceneExerciseFetcher()
        exerciseFetcher.fetchExercises { (success) in
            DispatchQueue.main.async {
                if success == true, (ExerciseStorage.exercises.count <= 7) {
                    workoutsReadyNotification()
                } else if success == false {
                    NotificationCenter.default.post(name: FetchingExercisesFailedNotification, object: self)
                    workoutsFailedNotification()
                }
            }
        }
    }
    
    @objc func handleFailedFetch() {
        let alertController = UIAlertController(title: "Network Download Error", message: "Network connectivity not strong enough. Please try again when connected to WiFi", preferredStyle: .alert)
        alertController.overrideUserInterfaceStyle = .dark
        
        let retry = UIAlertAction(title: "Try Again", style: .default, handler: retryHandler)
        
        alertController.addAction(retry)
        
        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        self.window!.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        UNUserNotificationCenter.current().delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(handleFailedFetch), name: FetchingExercisesFailedNotification, object: nil)
        
        let exerciseFetcher = SceneExerciseFetcher()
        exerciseFetcher.fetchExercises() { (success) in
            DispatchQueue.main.async {
                if success == true, (ExerciseStorage.exercises.count <= 7) {
                    if notificationsAllowed {
                        workoutsReadyNotification()
                    }
                } else if success == false {
                    NotificationCenter.default.post(name: FetchingExercisesFailedNotification, object: self)
                    if notificationsAllowed {
                        workoutsFailedNotification()
                    }
                }
            }
        }
        
        
        self.window = self.window ?? UIWindow()
        
        DispatchQueue.main.async {
            if !UserDefaults.standard.bool(forKey: onboardingKey) {
                let pageViewController = OnboardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
                self.window!.rootViewController = pageViewController
                self.window!.makeKeyAndVisible()
                OnboardingViewController.completion = {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        let homeVC = HomeViewController()
                        homeVC.modalPresentationStyle = .fullScreen
                        self.window!.rootViewController = homeVC
                        self.window!.makeKeyAndVisible()
                    }
                }
                
            } else {
                
                self.window!.rootViewController = HomeViewController()
                self.window!.makeKeyAndVisible()
                
            }
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: PauseWorkoutNotification, object: self)
        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: PauseWorkoutNotification, object: self)
        }
        
        UserManager.save()
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        UserManager.save()
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

