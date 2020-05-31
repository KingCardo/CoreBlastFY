//
//  SceneExerciseFetcher.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 5/30/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class SceneExerciseFetcher {
    
    func fetchExercises() {
    if !UserDefaults.standard.bool(forKey: onboardingKey) {
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.global(qos: .userInitiated).async {
                ExerciseStorage.fetchCoreExercises { (success) in

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
             
                            if success == false {
                            NotificationCenter.default.post(name: FetchingExercisesFailedNotification, object: self)
                        } else {
                            return
                        }
                    }
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                NotificationCenter.default.post(name: FetchingExercisesFailedNotification, object: self)
            }
        }
    } else if UserDefaults.standard.bool(forKey: onboardingKey) {
        DispatchQueue.global(qos: .userInitiated).async {
            ExerciseStorage.fetchCoreExercises { (success) in
                DispatchQueue.main.async {
                        if success == false {
                        NotificationCenter.default.post(name: FetchingExercisesFailedNotification, object: self)
                    } else {
                        return
                    }
                }
            }
        }
    }
    }
}
