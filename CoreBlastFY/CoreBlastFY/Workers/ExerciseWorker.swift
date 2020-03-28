//
//  ExerciseWorker.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 1/26/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import Foundation

protocol ExerciseInfoStoreProtocol {
    func fetchExercises(of level: String, completion: @escaping([Exercise], ExerciseInfoStoreError?) -> Void)
}

class ExerciseWorker {
    
    var exerciseInfoDataStore: ExerciseInfoStoreProtocol
    
    init(exerciseInfoDataStore: ExerciseInfoStoreProtocol) {
        self.exerciseInfoDataStore = exerciseInfoDataStore
    }
    
    func fetchExercises(of level: String, completion: @escaping([Exercise], ExerciseInfoStoreError?) -> Void) {
       
        exerciseInfoDataStore.fetchExercises(of: level) { (exercises, error) in
            if !exercises.isEmpty {
                    completion(exercises, nil)
                
            } else if let error = error {
                completion([], ExerciseInfoStoreError.CannotFetch(error.localizedDescription))
            }
        }
    }
}

enum ExerciseInfoStoreResult<U> {
    case Success(result: U)
    case Failure(error: ExerciseInfoStoreError)
}

enum ExerciseInfoStoreError: Equatable, Error {
    case CannotFetch(String)
}

func ==(lhs: ExerciseInfoStoreError, rhs: ExerciseInfoStoreError) -> Bool {
  switch (lhs, rhs) {
  case (.CannotFetch(let a), .CannotFetch(let b)) where a == b: return true
    default: return false
    }
    
}

