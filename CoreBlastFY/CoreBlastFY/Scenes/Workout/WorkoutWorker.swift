//
//  WorkoutWorker.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 1/26/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation

//protocol WorkoutInfoStoreProtocol {
//    func fetchWorkout(exercises: [Exercise], completion: @escaping(Workout?, WorkoutInfoStoreError?) -> Void)
//}

class WorkoutWorker {
    
    var dataStore: [Exercise]
    
    init(dataStore: [Exercise]) {
        self.dataStore = dataStore
    }
    
    func fetchWorkout(completion: @escaping(Workout) -> Void) {
        let workout = Workout(user: UserAPI.user, exercises: self.dataStore)
        completion(workout)
    }
}

let squatVideoPath = URL(fileURLWithPath:Bundle.main.path(forResource: "squat", ofType: "MOV")!)
let squat = Exercise(name: "Squat", tip: "full range of motion", level: .beginner, type: .stationary, videoURL: squatVideoPath)

let askipVideoPath = URL(fileURLWithPath:Bundle.main.path(forResource: "askip", ofType: "MOV")!)

let askip = Exercise(name: "A-Skip", tip: "Bounce in Rhythm", level: .beginner, type: .stationary, videoURL: askipVideoPath)
    
let exercisesMock = [squat, askip]

enum WorkoutInfoStoreResult<U> {
    case Success(result: U)
    case Failure(error: WorkoutInfoStoreError)
}

enum WorkoutInfoStoreError: Equatable, Error {
    case CannotFetch(String)
}

func ==(lhs: WorkoutInfoStoreError, rhs: WorkoutInfoStoreError) -> Bool {
  switch (lhs, rhs) {
  case (.CannotFetch(let a), .CannotFetch(let b)) where a == b: return true
    default: return false
    }
}
