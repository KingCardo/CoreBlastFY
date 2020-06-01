//
//  SceneExerciseFetcher.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 5/30/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

struct SceneExerciseFetcher {
    
    func fetchExercises(completion: @escaping(Bool?) -> Void) {
        print("fetch exercises called, rwrw")
        DispatchQueue.global(qos: .userInitiated).async {
            ExerciseStorage.fetchCoreExercises { (success) in
                
                DispatchQueue.main.async {
                    
                    if success == false {
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
