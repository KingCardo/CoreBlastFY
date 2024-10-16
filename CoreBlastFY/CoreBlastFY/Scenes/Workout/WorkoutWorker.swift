//
//  WorkoutWorker.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 1/26/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//

import Foundation

class WorkoutWorker {
    
    var dataStore: [Exercise]
    
    init(dataStore: [Exercise]) {
        self.dataStore = dataStore
    }
    
    func fetchWorkout(completion: @escaping(Workout) -> Void) {
        let user = UserManager.loadUserFromFile()
        let workout = Workout(user: user, exercises: self.dataStore)
        completion(workout)
    }
}


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
