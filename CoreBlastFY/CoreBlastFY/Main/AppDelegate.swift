//
//  AppDelegate.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/8/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let shouldDecrement = UserManager.decrementPoint()
        
        guard notificationsAllowed else { completionHandler(.noData); return }
        
        if shouldDecrement {
            sendPointDecrementNotification()
            completionHandler(.newData)
            
        } else {
            completionHandler(.noData)
        }
    }
  
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let threeDays: Double = 259200
        application.setMinimumBackgroundFetchInterval(threeDays)
        UserManager.loadUserFromFile()
        ProgressionPicController.shared.loadFromFile()
        EntryController.shared.loadFromFile()

        if UserAPI.user.totalPoints > 3 {
            registerForNotifications()
        }
        
        //TO DO: - fix user id issue
        print(UserAPI.user.id, "RWRWR")
        
        //FirebaseApp.configure()

        let success = ExerciseStorage.loadExercises()
        if !success {
            let worker = ExerciseWorker(exerciseInfoDataStore: CloudKitService())
            worker.fetchExercises { (exercises, error) in
                if !exercises.isEmpty {
                    print("done fetching, RWRWR")
                        ExerciseStorage.exercises = exercises
                        ExerciseStorage.save()
                    } else {
                        //TODO: Handle error
                        print(error?.localizedDescription)
                    }
                }
        }
    
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

