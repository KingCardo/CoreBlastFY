//
//  SceneExerciseFetcher.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 5/30/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit
let exercisesLoaded  = "exercisesLoaded"
struct SceneExerciseFetcher {
    
    func fetchExercises(completion: @escaping(Bool?) -> Void) {
        print("fetch exercises called, rwrw")
        DispatchQueue.global(qos: .userInitiated).async {
            ExerciseStorage.fetchCoreExercises { (success) in
                
                DispatchQueue.main.async {
                    
                    if success == true, !UserDefaults.standard.bool(forKey: exercisesLoaded) {
                        NotificationCenter.default.post(name: exerciseLoadedNotification, object: self)
                        UserDefaults.standard.set(true, forKey: exercisesLoaded)
                    }
                    
                    else if success == false {
                        NotificationCenter.default.post(name: FetchingExercisesFailedNotification, object: self)
                        completion(false)
                        return
                    } else {
                        completion(nil)
                        return
                    }
                }
            }
        }
    }
}
