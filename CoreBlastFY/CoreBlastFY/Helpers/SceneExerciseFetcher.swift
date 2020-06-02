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
    static var inProgress = false
    
    func fetchExercises(completion: @escaping(Bool?) -> Void) {
        
        print("fetch exercises called, rwrw")
        DispatchQueue.global(qos: .userInitiated).async {
            if !SceneExerciseFetcher.inProgress {
            SceneExerciseFetcher.inProgress = true
            ExerciseStorage.fetchCoreExercises { (success) in
                
                DispatchQueue.main.async {
                    SceneExerciseFetcher.inProgress = false
                    if success == true {
                    completion(true)
                        return
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
}
