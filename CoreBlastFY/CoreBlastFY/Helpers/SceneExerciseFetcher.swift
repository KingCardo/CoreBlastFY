//
//  SceneExerciseFetcher.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 5/30/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import Foundation

let exercisesLoaded  = "exercisesLoaded"

struct SceneExerciseFetcher {
    static var inProgress = false
    
    func fetchExercises(completion: @escaping(Bool?) -> Void) {
        if !SceneExerciseFetcher.inProgress {
            DispatchQueue.global(qos: .userInitiated).async {
                
                SceneExerciseFetcher.inProgress = true
                ExerciseStorage.fetchCoreExercises { (success) in
                    
                    DispatchQueue.main.async {
                        SceneExerciseFetcher.inProgress = false
                        if success == true {
                            completion(true)
                            return
                            
                        } else if success == false {
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
//        else {
//            completion(nil)
//            return
//        }
    }
}
