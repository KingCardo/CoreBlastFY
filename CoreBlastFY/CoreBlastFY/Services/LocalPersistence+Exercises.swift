//
//  LocalPersistence+Exercises.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 1/26/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import Foundation

let coreBeginnerKey = "beginner"
let coreNoviceKey = "novice"
let coreSolidKey = "solid"
let coreAdvancedKey = "advanced"
let coreRockstarKey = "rockstar"
let exerciseLoadedNotification = NSNotification.Name("ExercisesLoadedNotification")

class ExerciseStorage {
    
    static var failedCompletion: ((String) -> Void)?
    static var succeedCompletion: (() -> Void)?
    
    static var exercises: [Exercise] = [] {
        didSet {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: exerciseLoadedNotification, object: self)
            }
        }
    }
    
    static func fetchExercises(completion: @escaping(Bool) -> Void) {
            let worker = ExerciseWorker(exerciseInfoDataStore: LocalExercises())
            worker.fetchExercises { (exercises, error) in
                if !exercises.isEmpty {
                    ExerciseStorage.exercises += exercises
                    completion(true)
                    return
                }
        }
    }
    
    static func fetchCoreExercises(completion: @escaping(Bool) -> Void){
        ExerciseStorage.fetchExercises { (success) in
            completion(success)
        }
    }
}
